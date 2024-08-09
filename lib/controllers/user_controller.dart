import 'dart:convert';

import '../models/user.dart';
import 'package:http/http.dart' as http;

class UserController {
  final http.Client? client;

  UserController({this.client});

  /// Get all users data to List of User
  Future<List<User>> fetchUsers({int page = 1}) async {
    final response = await (client ?? http.Client())
        .get(Uri.parse('https://reqres.in/api/users?page=$page'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;

      final List<dynamic> usersData = jsonData['data'];

      return usersData.map((userJson) => User.fromJson(userJson)).toList();
    } else {
      throw Exception("Failed to retrieve users data");
    }
  }
}
