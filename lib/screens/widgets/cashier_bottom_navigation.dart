import 'package:flutter/material.dart';

class CashierBottomNavigation extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  CashierBottomNavigation(
      {required this.selectedIndex, required this.onItemTapped});

  @override
  _CashierBottomNavigationState createState() =>
      _CashierBottomNavigationState();
}

class _CashierBottomNavigationState extends State<CashierBottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes the shadow position
          ),
        ],
      ),
      child: BottomNavigationBar(
        selectedItemColor: Color.fromARGB(255, 124, 181, 24),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
        currentIndex: widget.selectedIndex,
        onTap: widget.onItemTapped,
      ),
    );
  }
}
