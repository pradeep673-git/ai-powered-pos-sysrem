import 'package:flutter/material.dart';
import 'global.dart';
import 'menu-screen.dart';
import 'home-screen.dart'; // Import Home Screen

class TableSelectionScreen extends StatefulWidget {
  @override
  _TableSelectionScreenState createState() => _TableSelectionScreenState();
}

class _TableSelectionScreenState extends State<TableSelectionScreen> {
  void showReadyOrders() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Ready Orders"),
          content: readyOrders.isEmpty
              ? Text("No orders ready yet")
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: readyOrders.asMap().entries.map((entry) {
                    int index = entry.key;
                    var order = entry.value;
                    return ListTile(
                      title: Text("Table ${order['table']}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: order['items'].entries.map<Widget>((entry) {
                          return Text("${entry.value} x ${entry.key}");
                        }).toList(),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.close, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            readyOrders.removeAt(index);
                          });
                          Navigator.pop(context);
                          showReadyOrders(); // Refresh dialog after removal
                        },
                      ),
                    );
                  }).toList(),
                ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Table"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: showReadyOrders,
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to Home Screen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: 10, // Number of tables
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MenuScreen(tableNumber: index + 1),
                ),
              );
            },
            child: Card(
              color: Colors.red[100],
              child: Center(
                child: Text(
                  'Table ${index + 1}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
