import 'package:firebase_work/Screen/Auth/verifection_screen.dart';
import 'package:firebase_work/Utility/utlity.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Num_auth extends StatefulWidget {
  @override
  State<Num_auth> createState() => _Num_authState();
}

class _Num_authState extends State<Num_auth> {
  final phonenumc = TextEditingController(text: "+91");

  final auth = FirebaseAuth.instance;

  bool load = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Authentication', style: GoogleFonts.b612()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                  controller: phonenumc,
                  autofillHints: const [AutofillHints.username],
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.numbers),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r)),
                    labelText: "Number",
                    hintText: "Enter Mobile Number",
                  ),
                  autofocus: true,
                  keyboardType: TextInputType.number),
              SizedBox(height: 20.h),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 5,
                    fixedSize: Size(150.w, 40.h),
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white),
                autofocus: true,
                onPressed: () {
                  auth.verifyPhoneNumber(
                    phoneNumber: phonenumc.text,
                    verificationCompleted: (_) {
                      setState(() => load = false);
                    },
                    verificationFailed: (error) {
                      Tost().Message(error.toString());
                      setState(() => load = false);
                    },
                    codeSent: (verificationId, int? forceResendingToken) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ver_screen(verificationId: verificationId)));
                      setState(() {
                        load = false;
                      });
                    },
                    codeAutoRetrievalTimeout: (e) {
                      Tost().Message(e.toString());
                      setState(() {
                        load = false;
                      });
                    },
                  );
                  setState(() {
                    load = true;
                  });
                },
                child: Center(
                    child: load
                        ? const CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2)
                        : const Text('Login', textScaleFactor: 1.5)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
