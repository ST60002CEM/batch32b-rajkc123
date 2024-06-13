import 'package:finalproject/features/auth/presentation/view/login_view.dart';
import 'package:finalproject/model/signup_model.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  List<SignupModel> signupList = [];
  SignupModel? signupModel;
  String? username;
  String? email;
  String? password;
  final myKey = GlobalKey<FormState>();
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
            child: Form(
              key: myKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 100,
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 40),
                  const Text(
                    'Signup',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter your username';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        username = value;
                      },
                      decoration: const InputDecoration(
                          labelText: ("Enter your username"),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)))),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your email';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: const InputDecoration(
                        labelText: ("Enter your email"),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      password = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Set your password';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: ("Enter password"),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      password = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Confirm password';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: ("Enter Confirm password"),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (myKey.currentState!.validate()) {
                        setState(() {
                          signupList.add(
                            SignupModel(
                              fName: username,
                              email: email,
                              password: password,
                            ),
                          );
                        });
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Sign up completed"),
                          backgroundColor: Colors.blue,
                          duration: Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                        ));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFB68B4C),
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                    child: Text('Sign Up'),
                  ),
                  const SizedBox(height: 20),
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginView()),
                      );
                    },
                    child: const Text('Login here.',
                        style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
