import 'package:flutter/material.dart';
import '../api_service.dart'; // API service for backend calls
import 'login-screen.dart'; // Navigate to Login Screen after signup

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void signup() async {
    if (_formKey.currentState!.validate()) {
      bool success = await ApiService.signup(
        nameController.text,
        emailController.text,
        passwordController.text,
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Signup successful! Please log in.")),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Signup failed. Try again.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Signup",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),

                // Name Input Field
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                      labelText: "Name", border: OutlineInputBorder()),
                  validator: (value) =>
                      value!.isEmpty ? "Enter your name" : null,
                ),
                SizedBox(height: 10),

                // Email Input Field
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      labelText: "Email", border: OutlineInputBorder()),
                  validator: (value) =>
                      value!.isEmpty ? "Enter your email" : null,
                ),
                SizedBox(height: 10),

                // Password Input Field
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: "Password", border: OutlineInputBorder()),
                  validator: (value) =>
                      value!.isEmpty ? "Enter your password" : null,
                ),
                SizedBox(height: 20),

                // Signup Button
                ElevatedButton(
                  onPressed: signup,
                  child: Text("Signup"),
                ),

                // Navigate to Login Screen
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text("Already have an account? Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
