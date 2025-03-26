import 'package:flutter/material.dart';
import 'table-selection-screen.dart';
import 'global.dart'; // Import global file to store kitchen orders

class OrderSummaryScreen extends StatelessWidget {
  final int tableNumber;
  final Map<String, int> order;

  OrderSummaryScreen({required this.tableNumber, required this.order});

  // Function to categorize items
  Map<String, List<Map<String, dynamic>>> categorizeOrder() {
    Map<String, List<Map<String, dynamic>>> categorizedOrder = {
      "Veg": [],
      "Non-Veg": [],
      "Breads": [],
      "Rice": [],
    };

    final menuItems = {
      "Veg": {
        'Paneer Butter Masala': 180.0,
        'Aloo Gobi': 150.0,
        'Dal Tadka': 120.0,
        'Chole Bhature': 160.0,
        'Vegetable Biryani': 200.0,
      },
      "Non-Veg": {
        'Chicken Biryani': 250.0,
        'Mutton Curry': 300.0,
        'Tandoori Chicken': 280.0,
        'Fish Curry': 220.0,
        'Butter Chicken': 260.0,
      },
      "Breads": {
        'Butter Naan': 50.0,
        'Tandoori Roti': 40.0,
        'Plain Paratha': 45.0,
        'Aloo Paratha': 60.0,
        'Kulcha': 55.0,
      },
      "Rice": {
        'Steamed Rice': 100.0,
        'Jeera Rice': 120.0,
        'Veg Pulao': 140.0,
        'Chicken Fried Rice': 180.0,
        'Mutton Biryani': 280.0,
      },
    };

    order.forEach((item, qty) {
      menuItems.forEach((category, items) {
        if (items.containsKey(item)) {
          categorizedOrder[category]!.add({'name': item, 'price': items[item], 'qty': qty});
        }
      });
    });

    return categorizedOrder;
  }

  @override
  Widget build(BuildContext context) {
    final categorizedOrder = categorizeOrder();
    double totalPrice = 0;

    order.forEach((item, qty) {
      totalPrice += qty *
          (categorizedOrder["Veg"]!.any((e) => e['name'] == item)
              ? categorizedOrder["Veg"]!.firstWhere((e) => e['name'] == item)['price']
              : categorizedOrder["Non-Veg"]!.any((e) => e['name'] == item)
                  ? categorizedOrder["Non-Veg"]!.firstWhere((e) => e['name'] == item)['price']
                  : categorizedOrder["Breads"]!.any((e) => e['name'] == item)
                      ? categorizedOrder["Breads"]!.firstWhere((e) => e['name'] == item)['price']
                      : categorizedOrder["Rice"]!.firstWhere((e) => e['name'] == item)['price']);
    });

    return Scaffold(
      appBar: AppBar(title: Text('Table $tableNumber - Order Summary')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: categorizedOrder.entries.map((category) {
                  if (category.value.isEmpty) return SizedBox(); // Skip empty categories
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          category.key, // Category Name (Veg, Non-Veg, Breads, Rice)
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                      ),
                      ...category.value.map((item) {
                        return ListTile(
                          title: Text('${item['name']} x${item['qty']}'),
                          trailing: Text('₹${(item['price'] * item['qty']).toStringAsFixed(2)}'),
                        );
                      }).toList(),
                    ],
                  );
                }).toList(),
              ),
            ),
            Divider(),
            Text(
              'Total: ₹${totalPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Send Order to Kitchen
                kitchenOrders.add({
                  "table": tableNumber,
                  "items": order,
                });

                // Navigate back to Table Selection
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => TableSelectionScreen()),
                  (route) => false, // Removes all previous routes
                );
              },
              child: Text('Confirm Order'),
            ),
          ],
        ),
      ),
    );
  }
}
