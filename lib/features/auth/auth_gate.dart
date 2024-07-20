import 'package:chat_app/features/auth/sign_in/view/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../home_page/view/screen/home_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapShot) {
          // If user is logged in
          if (snapShot.hasData) {
            return const HomePage();
          }

          // User is not logged in
          else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
