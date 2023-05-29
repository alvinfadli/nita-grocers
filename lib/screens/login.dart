import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        child: Center(
          child: Text(
            'Login screen content',
            style: TextStyle(fontSize: 24.0),
          ),
        ),
      ),
    );
  }
}
