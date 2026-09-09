import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../auth/user_role.dart';

/// Reads/creates the `users/{uid}` document that stores a user's role.
///
/// The document is created with `role: free` on first sign-in. There is no
/// admin UI to promote a user yet — for now, promote yourself to admin (or
/// grant VIP) by editing the document directly in the Firestore console.
class UserRepository {
  final _users = FirebaseFirestore.instance.collection('users');

  Future<UserRole> ensureUserDocument(User user) async {
    final ref = _users.doc(user.uid);
    final snapshot = await ref.get();
    if (!snapshot.exists) {
      await ref.set({
        'displayName': user.displayName,
        'email': user.email,
        'photoUrl': user.photoURL,
        'role': UserRole.free.name,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return UserRole.free;
    }
    return userRoleFromName(snapshot.data()?['role'] as String?);
  }
}

final userRepository = UserRepository();
