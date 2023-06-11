import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../login.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/cashier_bottom_navigation.dart';
import 'cashier_cart.dart';
import 'cashier_homepage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class CashierHistory extends StatefulWidget {
  const CashierHistory({Key? key}) : super(key: key);
  @override
  _CashierHistoryState createState() => _CashierHistoryState();
}

class _CashierHistoryState extends State<CashierHistory> {
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
    () => CashierHomepage(),
    () => CashierCart(), // Pass the actual clicked items list
    () => CashierHistory(),
    () => LoginScreen(),
  ];

  List transactionList = [];
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    fetchTransaction();
  }

  Future<void> fetchTransaction() async {
    String url =
        'https://group1mobileproject.000webhostapp.com/Transactions.php';

    // Menentukan tanggal pencarian jika ada
    String? searchDate;
    if (selectedDate != null) {
      final formatter = DateFormat('yyyy-MM-dd');
      searchDate = formatter.format(selectedDate!);
    }

    // Mengirim permintaan HTTP dengan tanggal pencarian jika ada
    try {
      var response = await http.get(Uri.parse(url + '?searchDate=$searchDate'));
      transactionList = jsonDecode(response.body);
      setState(() {
        transactionList = jsonDecode(response.body);
      });
    } catch (exc) {
      // Tangani kesalahan
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      fetchTransaction(); // Memperbarui daftar transaksi setelah tanggal pencarian diubah
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Riwayat Transaksi'),
        backgroundColor: Color.fromARGB(255, 124, 181, 24),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              _selectDate();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: transactionList.length,
        itemBuilder: (context, index) {
          if (selectedDate != null) {
            final formatter = DateFormat('yyyy-MM-dd');
            final transactionDate =
                formatter.parse(transactionList[index]['order_date']);
            if (transactionDate != selectedDate) {
              return Container(); // Jika tanggal transaksi tidak cocok dengan tanggal pencarian, tampilkan kontainer kosong
            }
          }

          return Card(
            margin: const EdgeInsets.all(5),
            child: ListTile(
              leading: const Icon(
                CupertinoIcons.shopping_cart,
                color: Color.fromARGB(255, 124, 181, 24),
                size: 30,
              ),
              title: Text(
                transactionList[index]['name_user'],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 124, 181, 24),
                ),
              ),
              subtitle: Text(
                transactionList[index]['order_date'],
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Color.fromARGB(221, 127, 127, 127),
                ),
              ),
              trailing: Text(
                'Rp.' +
                    NumberFormat('#,###').format(
                        int.parse(transactionList[index]['total_amount'])),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 124, 181, 24),
                ),
              ),
            ),
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
