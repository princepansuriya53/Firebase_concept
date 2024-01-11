// ignore_for_file: deprecated_member_use

import 'package:firebase_work/Screen/Auth/login_withOTP.dart';
import 'package:firebase_work/Utility/utlity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class Sing_up extends StatefulWidget {
  const Sing_up({super.key});

  @override
  State<Sing_up> createState() => _Sing_upState();
}

class _Sing_upState extends State<Sing_up> {
  final Auth = FirebaseAuth.instance;
  final email = TextEditingController();
  final pwd = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool loding = false;
  bool lodings = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Sign Up', style: GoogleFonts.akayaTelivigala(fontSize: 30.h)),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  autofillHints: const [AutofillHints.username],
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: true,
                  controller: email,
                  autofocus: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.r)),
                      labelText: "User Name",
                      suffixIcon: const Icon(Icons.alternate_email),
                      helperText: "Enter Email e.g Ram@gmal.com"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  autofillHints: const [AutofillHints.password],
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: _obscureText,
                  autocorrect: true,
                  controller: pwd,
                  autofocus: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.r)),
                      suffixIcon: IconButton(
                        onPressed: () =>
                            setState(() => _obscureText = !_obscureText),
                        icon: Icon(_obscureText
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      labelText: "Pasword",
                      helperText: "Enter Passowrd e.g123@xyz"),
                ),
              ),
              SizedBox(height: 10.h),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 5,
                    fixedSize: Size(150.w, 40.h),
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white),
                autofocus: true,
                onPressed: () {
                  singup();
                },
                child: Center(
                    child: loding
                        ? const CircularProgressIndicator(
                            strokeWidth: 3, color: Colors.white)
                        : const Text('Sign UP', textScaleFactor: 1.5)),
              ),
              SizedBox(height: 10.h),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 5,
                    fixedSize: Size(166.w, 40.h),
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white),
                autofocus: true,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Num_auth()),
                  );
                },
                child: Center(
                    child: lodings
                        ? const CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 3)
                        : const Text('Login With Number', textScaleFactor: 1)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void singup() {
    if (_formKey.currentState!.validate()) {
      setState(
        () => loding = true,
      );
      Auth.createUserWithEmailAndPassword(
        email: email.text.toString(),
        password: pwd.text.toString(),
      ).then((value) {
        Tost().Message(value.toString());
        setState(
          () => loding = false,
        );
      }).onError((error, stackTrace) {
        Tost().Message(error.toString());
        setState(() {
          loding = false;
        });
      });
    }
  }
}
