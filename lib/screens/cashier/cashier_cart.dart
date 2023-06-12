import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nita_grocers/screens/admin/admin_history.dart';
import 'package:nita_grocers/screens/admin/list_product.dart';
import 'package:nita_grocers/screens/cashier/cashier_history.dart';
import 'package:provider/provider.dart';
import '../../Providers/AuthProviders.dart';
import 'cart_provider.dart';
import 'cashier_homepage.dart';
import 'package:nita_grocers/screens/login.dart';
import 'package:http/http.dart' as http;
import '../widgets/cashier_bottom_navigation.dart';
import 'package:intl/intl.dart';

class CashierCart extends StatefulWidget {
  CashierCart({Key? key}) : super(key: key);

  @override
  _CashierCartState createState() => _CashierCartState();
}

class _CashierCartState extends State<CashierCart> {
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => _widgetOptions[index]()),
    );
  }

  int _selectedIndex = 1;
  static List<Widget Function()> _widgetOptions = <Widget Function()>[
    () => CashierHomepage(),
    () => CashierCart(), // Pass the actual clicked items list
    () => CashierHistory(),
    () => LoginScreen(),
  ];

  Future<void> submitOrder(BuildContext context) async {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final clickedItems = cartProvider.clickedItems;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userID = authProvider.userID; // Access the name_user property
    // Prepare the data to be sent to the server
    final List<Map<String, dynamic>> orderDetails = clickedItems.map((item) {
      return {
        'nama_barang': item.name,
        'jumlah': item.amount,
        'total_harga': item.totalPrice,
      };
    }).toList();
    final totalSum =
        clickedItems.fold<int>(0, (sum, item) => sum + item.totalPrice);
    final orderData = {
      'order_date': DateTime.now().toString(),
      'total_price': totalSum,
      'order_details': orderDetails,
      'id_user': userID, // Include the name_user key
    };
    final url =
        'https://group1mobileproject.000webhostapp.com/inputTransaction.php';
    final response =
        await http.post(Uri.parse(url), body: json.encode(orderData));

    if (response.statusCode == 200) {
      // Order submitted successfully, handle the response as needed
      print('Order submitted successfully.');
    } else {
      // Error submitting the order, handle the error as needed
      print('Error submitting the order.');
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, _) {
          final clickedItems = cartProvider.clickedItems;
          final totalSum =
              clickedItems.fold<int>(0, (sum, item) => sum + item.totalPrice);

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: clickedItems.length,
                  itemBuilder: (context, index) {
                    final item = clickedItems[index];

                    return ListTile(
                      title: Text('${item.name}'),
                      subtitle: Text('Amount: ${item.amount}'),
                      trailing: Text(
                        '${NumberFormat.currency(locale: 'en_US', symbol: 'Rp. ').format(item.totalPrice)}',
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Text(
                  'Total Sum: ${NumberFormat.currency(locale: 'en_US', symbol: 'Rp. ').format(totalSum)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          // Add your logic for the first button
                          onPressed: () =>
                              context.read<CartProvider>().clearCart(),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red, // Customize the color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Customize the border radius
                            ),
                            minimumSize: Size(
                                double.infinity, 50), // Set the button height
                          ),
                          child: Text(
                            'Clear',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            submitOrder(
                                context); // Call the submitOrder method with the context
                            context.read<CartProvider>().clearCart();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green, // Customize the color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Customize the border radius
                            ),
                            minimumSize: Size(
                                double.infinity, 50), // Set the button height
                          ),
                          child: Text(
                            'Submit',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
            ],
          );
        },
      ),
      bottomNavigationBar: CashierBottomNavigation(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
