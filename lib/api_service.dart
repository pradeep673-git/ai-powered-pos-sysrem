import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://127.0.0.1:8000"; // Backend URL

  // Signup Function
  static Future<bool> signup(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/signup"),  // FastAPI signup endpoint
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
      }),
    );

    return response.statusCode == 201;  // Returns true if signup is successful
  }
  static Future<void> addInventory(String name, int quantity, String unit) async {
    final url = Uri.parse('$baseUrl/inventory/add');
    
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'quantity': quantity,
          'unit': unit,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to add item with status code ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to add item: $e');
    }
  }

  static Future<void> removeInventory(String name, int quantity) async {
    final url = Uri.parse('$baseUrl/inventory/remove');
    
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'quantity': quantity,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to remove item with status code ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to remove item: $e');
    }
  }
}
