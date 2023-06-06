
import 'package:flutter/material.dart';
import '../widgets/bottom_navigation.dart';
import 'admin_homepage.dart';
import 'list_product.dart';

class AdminHistoryTransaction extends StatefulWidget {
  const AdminHistoryTransaction({Key? key}) : super(key: key);
  @override
  _AdminHistoryTransactionState createState() =>
      _AdminHistoryTransactionState();
}

class _AdminHistoryTransactionState extends State<AdminHistoryTransaction> {
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => _widgetOptions[index]()),
    );
  }

  int _selectedIndex = 2;
  static List<Widget Function()> _widgetOptions = <Widget Function()>[
    () => const AdminHomepage(),
    () => const CashierListProduct(),
    () => const AdminHistoryTransaction(),
  ];


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Riwayat Transaksi'),
        backgroundColor: Color.fromARGB(255, 124, 181, 24),
      ),
      bottomNavigationBar: BottomNavigation(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}