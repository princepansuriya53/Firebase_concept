import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_work/Screen/Auth/Login-screen.dart';
import 'package:firebase_work/Screen/Post/post.dart';
import 'package:flutter/material.dart';

class Splash_service {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    if (user != null) {
      Timer(
        const Duration(seconds: 2),
        () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Post_screen()),
            (Route<dynamic> route) => false),
      );
    } else {
      Timer(
        const Duration(seconds: 2),
        () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (Route<dynamic> route) => false),
      );
    }
  }
}
