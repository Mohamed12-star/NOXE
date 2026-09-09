import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../services/user_repository.dart';
import 'user_role.dart';

/// The Google Cloud "Web client" OAuth ID for this Firebase project. Needed
/// as `serverClientId` so Google Sign-In returns an ID token that Firebase
/// Auth can verify — Android does not return one without it. Found in
/// android/app/google-services.json under the `client_type: 3` entry (also
/// visible in Firebase Console > Authentication > Sign-in method > Google >
/// Web SDK configuration).
const String _googleWebClientId =
    '84206729969-0iaf9fte8jgb71bg85iv1nalob8h81tc.apps.googleusercontent.com';

/// App-wide auth state, on the same singleton + [ChangeNotifier] pattern as
/// `appLocale` (see lib/l10n/locale_controller.dart) — screens listen via
/// `ListenableBuilder` and rebuild automatically on sign-in/out.
class AuthController extends ChangeNotifier {
  User? _currentUser = FirebaseAuth.instance.currentUser;
  UserRole _role = UserRole.free;
  bool _busy = false;
  String? _lastError;

  User? get currentUser => _currentUser;
  UserRole get role => _role;
  bool get busy => _busy;
  String? get lastError => _lastError;

  /// Call once at startup, after `Firebase.initializeApp` and
  /// `GoogleSignIn.instance.initialize`.
  void listenToAuthChanges() {
    FirebaseAuth.instance.authStateChanges().listen(_onAuthStateChanged);
  }

  Future<void> _onAuthStateChanged(User? user) async {
    _currentUser = user;
    if (user == null) {
      _role = UserRole.free;
      notifyListeners();
      return;
    }
    final role = await userRepository.ensureUserDocument(user);
    // Guard against a stale resolution: if the user changed again while this
    // was in flight, an older call could otherwise overwrite the role for
    // whoever is signed in now.
    if (_currentUser?.uid != user.uid) return;
    _role = role;
    notifyListeners();
  }

  Future<void> signInWithGoogle() async {
    _busy = true;
    _lastError = null;
    notifyListeners();
    try {
      final account = await GoogleSignIn.instance.authenticate();
      final idToken = account.authentication.idToken;
      final credential = GoogleAuthProvider.credential(idToken: idToken);
      await FirebaseAuth.instance.signInWithCredential(credential);
      // _onAuthStateChanged (via the authStateChanges stream) picks up the
      // rest — user doc creation/read and role resolution.
    } on GoogleSignInException catch (e) {
      if (e.code != GoogleSignInExceptionCode.canceled) {
        _lastError = e.description ?? e.code.name;
      }
    } catch (e) {
      _lastError = e.toString();
    } finally {
      _busy = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await GoogleSignIn.instance.signOut();
    await FirebaseAuth.instance.signOut();
  }
}

/// Initializes the Google Sign-In SDK. Must be awaited once at startup,
/// before any [AuthController] method is called.
Future<void> initializeGoogleSignIn() {
  return GoogleSignIn.instance.initialize(serverClientId: _googleWebClientId);
}

final AuthController authController = AuthController();
