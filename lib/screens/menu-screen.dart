import 'package:flutter/material.dart';
import 'order-summary-screen.dart';

class MenuScreen extends StatefulWidget {
  final int tableNumber;
  const MenuScreen({super.key, required this.tableNumber});

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final List<Map<String, dynamic>> menuItems = [
    {'name': 'Parotta', 'price': 20.0},
    {'name': 'Biryani', 'price': 250.0},
    {'name': 'Chilli chicken', 'price': 150.0},
    {'name': 'Fried rice', 'price': 200.0},
  ];

  Map<String, int> order = {};

  void showOrderDialog(String itemName) {
    int quantity = order[itemName] ?? 1;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setModalState) {
          return Container(
            padding: EdgeInsets.all(16),
            height: 200,
            child: Column(
              children: [
                Text(
                  itemName,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: quantity > 1
                          ? () {
                              setModalState(() {
                                quantity--;
                              });
                            }
                          : null,
                      icon: Icon(Icons.remove),
                    ),
                    Text(
                      '$quantity',
                      style: TextStyle(fontSize: 18),
                    ),
                    IconButton(
                      onPressed: () {
                        setModalState(() {
                          quantity++;
                        });
                      },
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      order[itemName] = quantity;
                    });
                    Navigator.pop(context);
                  },
                  child: Text("Add to Order"),
                )
              ],
            ),
          );
        });
      },
    );
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
        children: menuItems.map((item) {
          return ListTile(
            title: Text('${item['name']}'),
            subtitle: Text('\$${item['price']}'),
            onTap: () => showOrderDialog(item['name']),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: proceedToSummary,
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}
