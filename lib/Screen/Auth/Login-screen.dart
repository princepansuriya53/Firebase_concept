import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_work/Screen/Auth/Google_auth.dart';
import 'package:firebase_work/Screen/Auth/Singup.dart';
import 'package:firebase_work/Screen/Post/post.dart';
import 'package:firebase_work/Utility/utlity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loding = false;
  final email = TextEditingController();
  final pwd = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Login',
            style: GoogleFonts.akayaTelivigala(
                fontSize: 30.h, color: Colors.black)),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height * .3,
                  width: double.infinity,
                  child: Lottie.asset('assets/firebase lotti.json')),
              Padding(
                padding: const EdgeInsets.all(10.0),
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
                      labelText: "email",
                      suffixIcon: const Icon(Icons.alternate_email),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.r))),
                      helperText: "Enter Email e.g Krishna_vasudev@gmal.com"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
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
                  autofillHints: const [AutofillHints.password],
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () =>
                            setState(() => _obscureText = !_obscureText),
                        icon: Icon(_obscureText
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      labelText: "Pasword",
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.r))),
                      helperText: "Enter Passowrd e.g 123@xyz"),
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
                onPressed: () => login(),
                child: Center(
                  child: loding
                      ? const CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 3)
                      : const Text('Login', textScaleFactor: 1.5),
                ),
              ),
              SizedBox(height: 10.h),
              const Divider(
                  indent: 20,
                  endIndent: 20,
                  thickness: 2.0, // Adjust thickness as needed
                  color: Colors.grey),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account ?',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Sing_up()));
                      },
                      child: const Text('Sing Up')),
                ],
              ),
              SignInButton(
                  elevation: 2,
                  btnTextColor: Colors.white,
                  btnColor: Colors.deepPurple,
                  buttonType: ButtonType.google,
                  onPressed: () => googleLogin(context)),
            ],
          ),
        ),
      ),
    );
  }

  void login() {
    if (_formKey.currentState!.validate()) {
      setState(() => loding = true);
      auth
          .signInWithEmailAndPassword(
        email: email.text.toString(),
        password: pwd.text.toString(),
      )
          .then((value) {
        setState(() => loding = false);
        Tost().Message(value.user!.email.toString());
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Post_screen()),
            (route) => false);
      }).onError((error, stackTrace) {
        Tost().Message(error.toString());
        setState(() {
          loding = false;
        });
      });
    }
  }
}
