import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xFFF7F2E9), // Background color similar to the image
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset(
            //   'assets/images/logo.png',
            //   height: 100, // Adjust the height as necessary
            // ),
            SizedBox(height: 20),
            Text(
              'Uplingoo',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color(0xFFB68B4C),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Upgrade your score',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFFB68B4C),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
