import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:nita_grocers/screens/admin/admin_history.dart';
import 'package:nita_grocers/screens/admin/list_product.dart';
import 'package:nita_grocers/screens/cashier/cart_provider.dart';
import 'package:nita_grocers/screens/cashier/cashier_history.dart';
import 'package:provider/provider.dart';
import '../../Providers/AuthProviders.dart';
import '../login.dart';
import '../widgets/cashier_bottom_navigation.dart';
import 'cashier_cart.dart';

class CashierHomepage extends StatefulWidget {
  const CashierHomepage({Key? key}) : super(key: key);

  @override
  _CashierHomepageState createState() => _CashierHomepageState();
}

class _CashierHomepageState extends State<CashierHomepage> {
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => _widgetOptions[index]()),
    );
  }

  int _selectedIndex = 0;
  static final List<Widget Function()> _widgetOptions = <Widget Function()>[
    () => CashierHomepage(),
    () => CashierCart(),
    () => CashierHistory(),
    () => LoginScreen(),
  ];

  List<Item> items = [];
  List<ClickedItem> clickedItems = [];

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  Future<void> fetchItems() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://nitagrocersfix.000webhostapp.com/get-cashier-products.php'),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<Item> fetchedItems = [];
        for (var itemData in data) {
          final item = Item(
            name: itemData['name'],
            price: int.parse(itemData['price']),
          );
          fetchedItems.add(item);
        }
        setState(() {
          items = fetchedItems;
        });
      } else {
        print('Failed to fetch items. Error code: ${response.statusCode}');
      }
    } catch (e) {
      print('Failed to fetch items: $e');
    }
  }

  void _showAmountDialog(Item item) {
    int amount = 1; // Default amount

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Amount'),
          content: TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              amount = int.tryParse(value) ?? 1;
            },
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                final clickedItem = ClickedItem(
                  name: item.name,
                  amount: amount,
                  totalPrice: amount * item.price,
                );
                context.read<CartProvider>().addToCart(clickedItem);
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void addToCart(ClickedItem clickedItem) {
    setState(() {
      clickedItems.add(clickedItem);
    });
  }

  void printClickedItems() {
    for (var item in clickedItems) {
      print('Name: ${item.name}');
      print('Amount: ${item.amount}');
      print('Total Price: ${item.totalPrice}');
      print('-------------');
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
            onPressed: printClickedItems,
          ),
        ],
      ),
      body: GridView.extent(
        maxCrossAxisExtent: 200,
        padding: EdgeInsets.all(10),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: items.map((item) {
          return GestureDetector(
            onTap: () => _showAmountDialog(item),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        item.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        '\Rp. ${item.price.toString()}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
      bottomNavigationBar: CashierBottomNavigation(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

class Item {
  final String name;
  final int price;

  Item({required this.name, required this.price});
}

class ClickedItem {
  final String name;
  final int amount;
  final int totalPrice;

  ClickedItem({
    required this.name,
    required this.amount,
    required this.totalPrice,
  });
}
