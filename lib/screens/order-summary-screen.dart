import 'package:flutter/material.dart';
import 'table-selection-screen.dart';
import 'global.dart'; // Import the global order list

class OrderSummaryScreen extends StatelessWidget {
  final int tableNumber;
  final Map<String, int> order;

  const OrderSummaryScreen(
      {super.key, required this.tableNumber, required this.order});

  void confirmOrder(BuildContext context) {
    if (order.isNotEmpty) {
      // Store order details in global list for kitchen
      kitchenOrders.add({
        'table': tableNumber,
        'items': Map.from(order),
      });

      // Navigate back to table selection
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TableSelectionScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;
    order.forEach((item, qty) {
      totalPrice += qty *
          (item == 'Parotta'
              ? 20.0
              : item == 'Biryani'
                  ? 250.0
                  : item == 'Chilli chicken'
                      ? 150.0
                      : 200.0);
    });

    return Scaffold(
      appBar: AppBar(title: Text('Table $tableNumber - Order Summary')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: order.entries.map((entry) {
                  return ListTile(
                    title: Text('${entry.key} x${entry.value}'),
                  );
                }).toList(),
              ),
            ),
            Text(
              'Total: \$${totalPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => confirmOrder(context),
              child: Text('Confirm Order'),
            ),
          ],
        ),
      ),
    );
  }
}
