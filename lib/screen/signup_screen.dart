import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xFFF7F2E9),
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 60.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image.asset(
                //   'assets/logo.png',
                //   height: 100,
                // ),
                SizedBox(height: 20),
                const Text(
                  'Uplingoo',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFB68B4C),
                  ),
                ),
                const Text(
                  'Upgrade your score',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFFB68B4C),
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  'Signup',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                buildTextField(Icons.person, 'Username'),
                const SizedBox(height: 20),
                buildTextField(Icons.email, 'Email'),
                SizedBox(height: 20),
                buildTextField(Icons.lock, 'Password', obscureText: true),
                SizedBox(height: 20),
                buildTextField(Icons.lock, 'Confirm Password',
                    obscureText: true),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFB68B4C),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child: Text('Sign Up'),
                ),
                SizedBox(height: 20),
                Text('Already have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/');
                  },
                  child:
                      Text('Login here.', style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(IconData icon, String hintText,
      {bool obscureText = false}) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Color(0xFFB68B4C)),
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
