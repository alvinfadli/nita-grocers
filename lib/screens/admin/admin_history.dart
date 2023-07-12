import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../login.dart';
import '../widgets/bottom_navigation.dart';
import 'admin_homepage.dart';
import 'list_product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

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
        'https://nitagrocersfix.000webhostapp.com/get-transactions.php';

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
      bottomNavigationBar: BottomNavigation(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
