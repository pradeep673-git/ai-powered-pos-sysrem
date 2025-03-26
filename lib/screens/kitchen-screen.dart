import 'package:flutter/material.dart';
import 'package:college_project/api_service.dart'; // Ensure this import is correct
import 'global.dart';

class KitchenScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kitchen Management")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InventoryScreen()),
              ),
              child: Text("Inventory"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrderManagementScreen()),
              ),
              child: Text("Orders"),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- ORDER MANAGEMENT SCREEN ----------------
class OrderManagementScreen extends StatefulWidget {
  @override
  _OrderManagementScreenState createState() => _OrderManagementScreenState();
}

class _OrderManagementScreenState extends State<OrderManagementScreen> {
  void markOrderAsReady(int index) {
    setState(() {
      if (index < kitchenOrders.length) {
        readyOrders.add(kitchenOrders[index]); // Move order to `readyOrders`
        kitchenOrders.removeAt(index); // Remove order from active kitchen list
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kitchen Orders")),
      body: kitchenOrders.isEmpty
          ? Center(child: Text("No Orders Yet"))
          : ListView.builder(
              itemCount: kitchenOrders.length,
              itemBuilder: (context, index) {
                final order = kitchenOrders[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Table ${order['table']}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: order['items'].entries.map<Widget>((entry) {
                            return Text("${entry.value} x ${entry.key}");
                          }).toList(),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () => markOrderAsReady(index),
                              child: Text("Ready"),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  kitchenOrders.removeAt(index); // Remove order
                                });
                              },
                              child: Text("Decline"),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

// ---------------- INVENTORY MANAGEMENT SCREEN ----------------
class InventoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Inventory Management")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddInventoryScreen(isAdding: true)),
              ),
              child: Text("Add to Inventory"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddInventoryScreen(isAdding: false)),
              ),
              child: Text("Take from Inventory"),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- ADD / TAKE INVENTORY SCREEN ----------------
class AddInventoryScreen extends StatefulWidget {
  final bool isAdding;
  AddInventoryScreen({required this.isAdding});

  @override
  _AddInventoryScreenState createState() => _AddInventoryScreenState();
}

class _AddInventoryScreenState extends State<AddInventoryScreen> {
  final TextEditingController itemController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  String selectedUnit = "kg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.isAdding ? "Add to Inventory" : "Take from Inventory")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: itemController,
              decoration: InputDecoration(labelText: "Item Name"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Quantity"),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: selectedUnit,
              onChanged: (String? newValue) {
                setState(() {
                  selectedUnit = newValue!;
                });
              },
              items: ["kg", "liters", "count"].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async { // Make the onPressed async
                String item = itemController.text;
                String quantityStr = quantityController.text;
                if (item.isNotEmpty && quantityStr.isNotEmpty) {
                  int quantity = int.tryParse(quantityStr) ?? 0; // Parse the quantity
                  if (quantity > 0) {
                    try {
                      if (widget.isAdding) {
                        await ApiService.addInventory(item, quantity, selectedUnit);
                      } else {
                        await ApiService.removeInventory(item, quantity);
                      }
                      String action = widget.isAdding ? "added to" : "taken from";
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("$quantity $selectedUnit of $item $action inventory")),
                      );
                      Navigator.pop(context);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Failed to update inventory: $e")),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please enter a valid quantity")),
                    );
                  }
                }
              },
              child: Text(widget.isAdding ? "Add" : "Take"),
            ),
          ],
        ),
      ),
    );
  }
}
