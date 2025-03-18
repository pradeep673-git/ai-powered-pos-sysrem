import 'package:flutter/material.dart';
import 'table-selection-screen.dart';
import 'kitchen-screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                  MaterialPageRoute(
                      builder: (context) => TableSelectionScreen()),
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
              title: "Management",
              icon: Icons.admin_panel_settings,
              onTap: () {
                // TODO: Add navigation for Management screen
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

  const HomeButton(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
        textStyle: TextStyle(fontSize: 18),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
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
