import 'dart:async';
import 'package:flutter/material.dart';
import 'package:technician_app/authentication_screen/sign_in_page.dart';

import 'colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const SignInPage();
      },));

    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color:white,
      child: Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: Image.asset(
              "assets/images/urban_logo.png"),
        ),
      ),
    );
  }
}
