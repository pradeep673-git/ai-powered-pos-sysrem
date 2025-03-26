// flutter_frontend/lib/signup.dart
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

    void handleSignup() async {
        try {
            final response = await ApiService.signup(
                nameController.text,
                emailController.text,
                passwordController.text,
            );

            if (response['detail'] == null) {
                print("Signup successful: ${response}");
            } else {
                print("Signup failed: ${response['detail']}");
            }
        } catch (e) {
            print("Error during signup: $e");
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
                            controller: nameController,
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
