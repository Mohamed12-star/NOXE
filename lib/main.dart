import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'auth/auth_controller.dart';
import 'firebase_options.dart';
import 'l10n/locale_controller.dart';
import 'screens/root_screen.dart';
import 'screens/sign_in_screen.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeGoogleSignIn();
  authController.listenToAuthChanges();
  appLocale.restore();
  runApp(const NoxeApp());
}

class NoxeApp extends StatelessWidget {
  const NoxeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: appLocale,
      builder: (context, _) {
        return MaterialApp(
          title: 'Noxe Pronos',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          home: ListenableBuilder(
            listenable: authController,
            builder: (context, _) {
              return authController.currentUser == null
                  ? const SignInScreen()
                  : const RootScreen();
            },
          ),
          builder: (context, child) {
            return Directionality(
              textDirection:
                  appLocale.current.code == 'ar' ? TextDirection.rtl : TextDirection.ltr,
              child: child!,
            );
          },
        );
      },
    );
  }
}
