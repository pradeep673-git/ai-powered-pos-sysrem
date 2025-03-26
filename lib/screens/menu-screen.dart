import 'package:flutter/material.dart';
import 'order-summary-screen.dart';

class MenuScreen extends StatefulWidget {
  final int tableNumber;
  MenuScreen({required this.tableNumber});

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  // Categorized Indian Food Menu
  final Map<String, List<Map<String, dynamic>>> menuCategories = {
    "Veg": [
      {'name': 'Paneer Butter Masala', 'price': 180.0},
      {'name': 'Aloo Gobi', 'price': 150.0},
      {'name': 'Dal Tadka', 'price': 120.0},
      {'name': 'Chole Bhature', 'price': 160.0},
      {'name': 'Vegetable Biryani', 'price': 200.0},
    ],
    "Non-Veg": [
      {'name': 'Chicken Biryani', 'price': 250.0},
      {'name': 'Mutton Curry', 'price': 300.0},
      {'name': 'Tandoori Chicken', 'price': 280.0},
      {'name': 'Fish Curry', 'price': 220.0},
      {'name': 'Butter Chicken', 'price': 260.0},
    ],
    "Breads": [
      {'name': 'Butter Naan', 'price': 50.0},
      {'name': 'Tandoori Roti', 'price': 40.0},
      {'name': 'Plain Paratha', 'price': 45.0},
      {'name': 'Aloo Paratha', 'price': 60.0},
      {'name': 'Kulcha', 'price': 55.0},
    ],
    "Rice": [
      {'name': 'Steamed Rice', 'price': 100.0},
      {'name': 'Jeera Rice', 'price': 120.0},
      {'name': 'Veg Pulao', 'price': 140.0},
      {'name': 'Chicken Fried Rice', 'price': 180.0},
      {'name': 'Mutton Biryani', 'price': 280.0},
    ],
  };

  Map<String, int> order = {}; // Stores selected items and their quantities

  void addToOrder(String itemName) {
    setState(() {
      order[itemName] = (order[itemName] ?? 0) + 1;
    });
  }

  void removeFromOrder(String itemName) {
    setState(() {
      if (order.containsKey(itemName) && order[itemName]! > 0) {
        order[itemName] = order[itemName]! - 1;
        if (order[itemName] == 0) {
          order.remove(itemName);
        }
      }
    });
  }

  void proceedToSummary() {
    if (order.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderSummaryScreen(
            tableNumber: widget.tableNumber,
            order: order,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Table ${widget.tableNumber} - Menu')),
      body: ListView(
        children: menuCategories.entries.map((category) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category Header
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  category.key, // Category Name (Veg, Non-Veg, Breads, Rice)
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
                ),
              ),
              // List of Menu Items in the Category
              ...category.value.map((item) {
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: Text(item['name']),
                    subtitle: Text('₹${item['price']}'),
                    trailing: SizedBox(
                      width: 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove, color: Colors.red),
                            onPressed: () => removeFromOrder(item['name']),
                          ),
                          Text(
                            order[item['name']]?.toString() ?? '0',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: Icon(Icons.add, color: Colors.green),
                            onPressed: () => addToOrder(item['name']),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ],
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.shopping_cart),
        onPressed: proceedToSummary,
      ),
    );
  }
}
