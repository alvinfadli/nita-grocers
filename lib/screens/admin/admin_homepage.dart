import 'dart:math';
import 'package:flutter/material.dart';
import 'package:nita_grocers/screens/admin/admin_history.dart';
import 'list_product.dart';
import '../widgets/bottom_navigation.dart';

class AdminHomepage extends StatefulWidget {
  const AdminHomepage({Key? key}) : super(key: key);
  @override
  _AdminHomepageState createState() => _AdminHomepageState();
}

class _AdminHomepageState extends State<AdminHomepage> {
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => _widgetOptions[index]()),
    );
  }

  int _selectedIndex = 0;
  static List<Widget Function()> _widgetOptions = <Widget Function()>[
    () => const AdminHomepage(),
    () => const CashierListProduct(),
    () => const AdminHistoryTransaction(),
  ];

  @override
  void initState() {
    super.initState();
  }
  //   return data;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Nita Grocers'),
        backgroundColor: Color.fromARGB(255, 124, 181, 24),
      ),
      body: ListView(
        shrinkWrap: true,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Padding(
          //   padding: EdgeInsets.all(16.0),
          //   child: Column(),
          // ),
          // Padding(
          //   padding: EdgeInsets.all(16.0),
          //   child: Column(),
          // ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 2.0,
                                blurRadius: 5.0,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                // Handle button 1 click
                              },
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top:
                                            8.0), // Add padding to the top of the image
                                    child: Image(
                                      image: AssetImage('assets/supplier.png'),
                                      width: 100,
                                      height: 100,
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 8.0),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Suppliers',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 2.0,
                                blurRadius: 5.0,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                // Handle button 2 click
                              },
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top:
                                            8.0), // Add padding to the top of the image
                                    child: Image(
                                      image: AssetImage('assets/cashier.png'),
                                      width: 100,
                                      height: 100,
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 8.0),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Cashiers',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigation(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
