import 'package:firebase_work/Firebase_service/splash_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Splash_screen extends StatefulWidget {
  const Splash_screen({super.key});

  @override
  State<Splash_screen> createState() => _Splash_screenState();
}

class _Splash_screenState extends State<Splash_screen> {
  Splash_service Splash_screen = Splash_service();
  @override
  void initState() {
    Splash_screen.isLogin(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/Screenimg.jpg'),
            Text('Firebase Concept',
                style: GoogleFonts.bigShouldersDisplay(fontSize: 25.sp)),
            SizedBox(height: 20.h),
            const CircularProgressIndicator(
                strokeWidth: 5,
                backgroundColor: Colors.amber,
                color: Colors.orangeAccent),
          ],
        ),
      ),
    );
  }
}
