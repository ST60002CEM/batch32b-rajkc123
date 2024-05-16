// lib/screens/splash_screen.dart

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final String name;

  SplashScreen({required this.name});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome ${widget.name}',
              style: TextStyle(fontSize: 24),
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
