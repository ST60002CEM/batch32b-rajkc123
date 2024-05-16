import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(style: TextStyle(fontSize: 25), "Uplingoo"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: Center(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(style: TextStyle(fontSize: 25), "Login"),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: "Password", border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(onPressed: () {}, child: const Text("Login"))
              // Text(style: TextStyle(fontSize: 20), "Login"),
            ],
          ),
        ),
      ),
    );
  }
}
