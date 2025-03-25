import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://localhost:8000"; // Replace with your server's IP address

  static Future<bool> signup(String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/auth/signup"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception("Signup failed: ${response.body}");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
