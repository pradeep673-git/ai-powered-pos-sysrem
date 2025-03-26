import 'package:flutter/material.dart';
import 'table-selection-screen.dart';
import 'kitchen-screen.dart';
import 'chatbot-screen.dart'; // Importing Chatbot Screen

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Restaurant Management")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HomeButton(
              title: "Waiter",
              icon: Icons.restaurant,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TableSelectionScreen()),
                );
              },
            ),
            SizedBox(height: 20),
            HomeButton(
              title: "Kitchen",
              icon: Icons.kitchen,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => KitchenScreen()),
                );
              },
            ),
            SizedBox(height: 20),
            HomeButton(
              title: "Chatbot 🤖",
              icon: Icons.chat,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatbotScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class HomeButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  HomeButton({required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
        textStyle: TextStyle(fontSize: 18),
      ),
      onPressed: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 24),
          SizedBox(width: 10),
          Text(title),
        ],
      ),
    );
  }
}
