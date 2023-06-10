// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:nita_grocers/screens/admin/admin_history.dart';
// import 'package:nita_grocers/screens/admin/list_product.dart';
// import 'cashier_homepage.dart';
// import 'package:nita_grocers/screens/login.dart';
// import 'package:http/http.dart' as http;
// import '../widgets/cashier_bottom_navigation.dart';

// class CashierCart extends StatefulWidget {
//   final List<ClickedItem> clickedItems;

//   CashierCart({Key? key, required this.clickedItems}) : super(key: key);

//   @override
//   _CashierCartState createState() => _CashierCartState();
// }

// class _CashierCartState extends State<CashierCart> {
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => _widgetOptions[index]()),
//     );
//   }

//   int _selectedIndex = 1;
//   static List<Widget Function()> _widgetOptions = <Widget Function()>[
//     () => CashierHomepage(),
//     () => CashierCart(clickedItems: []), // Pass the actual clicked items list
//     () => AdminHistoryTransaction(),
//     () => LoginScreen(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text('Nita Grocers'),
//         backgroundColor: Color.fromARGB(255, 124, 181, 24),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.print),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: widget.clickedItems.length,
//         itemBuilder: (context, index) {
//           final clickedItem = widget.clickedItems[index];
//           return ListTile(
//             title: Text(clickedItem.name),
//             subtitle: Text('Amount: ${clickedItem.amount}'),
//             trailing: Text('Total Price: \$${clickedItem.totalPrice}'),
//           );
//         },
//       ),
//       bottomNavigationBar: CashierBottomNavigation(
//         selectedIndex: _selectedIndex,
//         onItemTapped: _onItemTapped,
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nita_grocers/screens/admin/admin_history.dart';
import 'package:nita_grocers/screens/admin/list_product.dart';
import 'cashier_homepage.dart';
import '../login.dart';
import 'cart_provider.dart';
import '../widgets/cashier_bottom_navigation.dart';

class CashierCart extends StatelessWidget {
  final List<ClickedItem> clickedItems;

  CashierCart({Key? key, required this.clickedItems}) : super(key: key);

  void _onItemTapped(int index, BuildContext context) {
    Provider.of<CartProvider>(context, listen: false).clearCart();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => _widgetOptions[index]()),
    );
  }

  int _selectedIndex = 1;
  static List<Widget Function()> _widgetOptions = <Widget Function()>[
    () => CashierHomepage(),
    () => CashierCart(
          clickedItems: [],
        ),
    () => AdminHistoryTransaction(),
    () => LoginScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final clickedItems = cartProvider.clickedItems;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Nita Grocers'),
        backgroundColor: Color.fromARGB(255, 124, 181, 24),
        actions: [
          IconButton(
            icon: Icon(Icons.print),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: clickedItems.length,
        itemBuilder: (context, index) {
          final clickedItem = clickedItems[index];
          return ListTile(
            title: Text(clickedItem.name),
            subtitle: Text('Amount: ${clickedItem.amount}'),
            trailing: Text('Total Price: \$${clickedItem.totalPrice}'),
          );
        },
      ),
      bottomNavigationBar: CashierBottomNavigation(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) => _onItemTapped(index, context),
      ),
    );
  }
}
