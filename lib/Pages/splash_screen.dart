
import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTimer() {
    var duration = const Duration(seconds: 4);
    return Timer(duration, route);
  }
  route() {
      Navigator.pushReplacementNamed(context, '/home_page');
  }


  @override
  void initState() {
    super.initState();
    startTimer();
  }


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(
            ),
                Center(
                    child: Image(
                        image:
                        AssetImage('assets/images/Logos.png' ),
                        height: 700,
                        width: 800,
                    ),
                ),
            // Text(
            //   "SUDOKU MANIA",
            //   style: TextStyle(
            //       fontFamily: 'Roboto',
            //       fontSize: 50,
            //       fontStyle: FontStyle.italic,
            //       color: Color(0xFF15213D)
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
