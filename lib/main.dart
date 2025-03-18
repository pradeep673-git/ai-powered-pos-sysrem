import 'package:flutter/material.dart';
import 'screens/login-screen.dart';

void main() {
  runApp(RestaurantApp());
}

class RestaurantApp extends StatelessWidget {
  const RestaurantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant Order Management',
      theme: ThemeData(primarySwatch: Colors.red),
      home: LoginScreen(), // Start with Login Screen
    );
  }
}
