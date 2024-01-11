import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_work/Screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDpOGv1m6rZEoKoGzXbgjQ4UbariEyIIxU",
          appId: "1:224728354702:android:c8a31da1a148ed9bde1edf",
          messagingSenderId: "224728354702",
          projectId: "login-16d62"));
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return MaterialApp(
          themeMode: ThemeMode.system,
          debugShowCheckedModeBanner: false,
          title: 'Firebase Concept',
          theme: ThemeData(primarySwatch: Colors.deepPurple),
          home: child,
          // routes: {},
        );
      },
      child: Splash_screen(),
    );
  }
}
