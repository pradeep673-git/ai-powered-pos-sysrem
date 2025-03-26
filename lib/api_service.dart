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
}
