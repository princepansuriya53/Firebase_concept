// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_work/Screen/Post/post.dart';
import 'package:firebase_work/Utility/utlity.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<void> googleLogin(BuildContext context) async {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  if (googleSignInAccount != null) {
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final AuthCredential authCredential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );

    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      // Signing in with the credential
      UserCredential result = await auth.signInWithCredential(authCredential);
      User? user = result.user;

      if (user != null) {
        // Get.off(() => const HomeScreen());

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Post_screen()),
        );
      }
    } catch (error) {
      print('Error signing in with Google: $error');
      // Utils.snackBar(massageType: MassageType.error);
      Tost().Message(error.toString());
    }
  }
}

Future<void> googleLogout() async {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth auth = FirebaseAuth.instance;

  try {
    await googleSignIn.signOut();
    await auth.signOut();

    // Redirect to your log-in or splash screen
    // Get.off(() => const LoginScreen());
  } catch (error) {
    // print('Error signing out: $error');
    // Utils.snackBar(massageType: MassageType.error);
  }
}
