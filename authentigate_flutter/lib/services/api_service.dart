import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://localhost:8080/api/users";

  static Future<http.Response> registerUser(Map<String, dynamic> userData) async {
    return await http.post(
      Uri.parse("$baseUrl/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(userData),
    );
  }

  static Future<http.Response> loginUser(String email, String password) async {
    return await http.post(
      Uri.parse("$baseUrl/login?email=$email&passwordHash=$password"),
    );
  }
}
