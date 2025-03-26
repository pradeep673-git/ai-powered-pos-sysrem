import 'package:flutter/material.dart';
import 'package:college_project/api_service.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void signup() async {
    if (_formKey.currentState!.validate()) {
      bool success = await ApiService.signup(
        nameController.text,
        emailController.text,
        passwordController.text,
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Signup Failed. Try again.")),
        );
        Navigator.pop(context); // Go back to Login Screen
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Signup Successful!")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Signup")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Name"),
                validator: (value) =>
                    value!.isEmpty ? "Enter your name" : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email"),
                validator: (value) =>
                    value!.isEmpty ? "Enter a valid email" : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
                validator: (value) =>
                    value!.length < 6 ? "Password too short" : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: signup,
                child: Text("Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

