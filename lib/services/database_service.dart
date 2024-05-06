import 'package:http/http.dart' as http;
import 'dart:convert';

class DatabaseService {
  static Future<User?> getUserById(int id) async {
    final response = await http.get(
      Uri.parse('http://your-backend-api/user/$id'),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get user');
    }
  }
}
