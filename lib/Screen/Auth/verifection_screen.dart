// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_work/Screen/Post/post.dart';
import 'package:firebase_work/Utility/utlity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ver_screen extends StatefulWidget {
  String verificationId;
  ver_screen({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<ver_screen> createState() => _VeryficaenState();
}

class _VeryficaenState extends State<ver_screen> {
  final otp = TextEditingController();

  final auth = FirebaseAuth.instance;

  bool load = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Authentication', style: GoogleFonts.b612()),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 80.h,
                width: double.infinity,
                child: Lottie.asset("assets/OTP.json")),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  controller: otp,
                  maxLength: 6,
                  decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.numbers),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r)),
                      labelText: "OTP",
                      hintText: "Enter 6 Digit Code"),
                  autofocus: true,
                  keyboardType: TextInputType.number),
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 5,
                  fixedSize: Size(150.w, 40.h),
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white),
              autofocus: true,
              onPressed: () async {
                setState(() {
                  load = true;
                });
                final credential = PhoneAuthProvider.credential(
                  verificationId: widget.verificationId,
                  smsCode: otp.text.toString(),
                );
                try {
                  await auth.signInWithCredential(credential);
                  // ignore: use_build_context_synchronously
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Post_screen()),
                      (route) => false);
                } catch (e) {
                  setState(() {
                    load = false;
                  });
                  Tost().Message(e.toString());
                }
              },
              child: Center(
                  child: load
                      ? const CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 3)
                      : const Text('Login', textScaleFactor: 1.5)),
            ),
          ],
        ),
      ),
    );
  }
}
