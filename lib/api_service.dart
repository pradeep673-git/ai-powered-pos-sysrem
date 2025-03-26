// college_project/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:8000'; // Update this if necessary

  static Future<Map<String, dynamic>> signup(String name, String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/signup');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name, 'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Signup failed with status: ${response.statusCode}');
        return {'detail': 'Signup failed'};
      }
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }
}
