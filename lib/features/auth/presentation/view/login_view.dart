import 'package:finalproject/features/auth/presentation/view/register_view.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
                Image.asset(
                  'assets/images/logo.png',
                  height: 150,
                ),
                SizedBox(height: 20),
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                buildTextField(Icons.email, 'Email'),
                const SizedBox(height: 20),
                buildTextField(Icons.lock, 'Password', obscureText: true),
                SizedBox(height: 10),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgot your password?',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFB68B4C),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child: const Text('Log in'),
                ),
                SizedBox(height: 20),
                Text('Don’t have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterView()),
                    );
                  },
                  child: const Text('Signup here.',
                      style: TextStyle(color: Colors.blue)),
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
