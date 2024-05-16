import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final myKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(style: TextStyle(fontSize: 25), "Uplingoo"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: Expanded(
        child: Center(
          child: Form(
            key: myKey,
            child: SizedBox(
              width: 800,
              height: 700,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(style: TextStyle(fontSize: 25), "Registration"),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter First Name';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: "First Name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter First Name';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: "Lastname",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter First Name';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter First Name';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: "Password", border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter First Name';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: "Confirm Password",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Saved"),
                        backgroundColor: Colors.blue,
                        duration: Duration(seconds: 2),
                        behavior: SnackBarBehavior.floating,
                      ));
                    },
                    child: const Text("Login"),
                  )
                  // Text(style: TextStyle(fontSize: 20), "Login"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
