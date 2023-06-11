import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  String _token = '';
  int _userRole = 0;
  int _userID = 0;

  bool get isLoggedIn => _isLoggedIn;
  String get token => _token;
  int get userRole => _userRole;
  int get userID => _userID;

  void setLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }

  void setUserRole(int role) {
    _userRole = role;
    notifyListeners();
  }

  void setUserID(int id) {
    _userID = id;
    notifyListeners();
  }

  Future<void> login(String username, String password) async {
    try {
      final url =
          Uri.parse('https://group1mobileproject.000webhostapp.com/login.php');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'username': username, 'password': password},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['status'] == 'success') {
          _token = jsonData['message'];
          _isLoggedIn = true;
          _userRole = int.parse(jsonData['id_role']);
          _userID = jsonData['id_user'];
        } else {
          throw Exception('Failed to login: ${jsonData['message']}');
        }
      } else {
        throw Exception('Failed to login: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to login: $error');
    }
  }

  void logout() {
    _token = '';
    _isLoggedIn = false;
    _userRole = 0;
    _userID = 0;
    notifyListeners();
  }
}
