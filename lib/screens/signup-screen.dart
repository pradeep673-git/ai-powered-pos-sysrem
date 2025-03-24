import 'package:flutter/material.dart';
import 'package:college_project/api_service.dart';


class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController(); // Add this line
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void handleSignup() async {
    try {
      final response = await ApiService.signup(
        nameController.text, // Pass name to signup
        emailController.text,
        passwordController.text,
      );
      print(response); // Handle response accordingly
    } catch (e) {
      print(e); // Handle error accordingly
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Signup')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController, // Add this line for name input
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            ElevatedButton(
              onPressed: handleSignup,
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
