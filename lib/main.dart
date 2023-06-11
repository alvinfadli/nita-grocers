import 'package:flutter/material.dart';
import 'package:nita_grocers/screens/admin/admin_homepage.dart';
import 'package:nita_grocers/screens/cashier/cart_provider.dart';
import 'package:nita_grocers/screens/cashier/cashier_homepage.dart';
import 'package:nita_grocers/screens/login.dart';
import 'package:provider/provider.dart';

import 'Providers/AuthProviders.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/admin': (context) => AdminHomepage(),
        '/kasir': (context) => CashierHomepage(),
      },
    );
  }
}
