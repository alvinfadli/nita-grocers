// import 'package:flutter/material.dart';
// import '../widgets/bottom_navigation.dart';
// import 'cashier_homepage.dart';
// import 'list_product.dart';

// class Transaction {
//   final String title;
//   final double amount;
//   final DateTime date;

//   Transaction({required this.title, required this.amount, required this.date});
// }

// class CashierHistoryPage extends StatefulWidget {
//   const CashierHistoryPage({Key? key}) : super(key: key);
//   @override
//   _CashierHistoryPageState createState() => _CashierHistoryPageState();
// }

// class _CashierHistoryPageState extends State<CashierHistoryPage> {
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => _widgetOptions[index]()),
//     );
//   }

//   int _selectedIndex = 2;
//   static List<Widget Function()> _widgetOptions = <Widget Function()>[
//     () => const cashierHomepage(),
//     () => const CashierListProduct(),
//     () => const CashierHistoryPage(),
//   ];

//   final List<Transaction> transactions = [
//     Transaction(title: 'Kasir1', amount: 49.99, date: DateTime.now()),
//     Transaction(title: 'Kasir2', amount: 12.99, date: DateTime.now()),
//     Transaction(title: 'Kasir', amount: 99.99, date: DateTime.now()),
//   ];

//   List<Transaction> filteredTransactions = [];

//   @override
//   void initState() {
//     super.initState();
//     filteredTransactions = transactions;
//   }

//   void _searchTransactions(String query) {
//     setState(() {
//       filteredTransactions = transactions
//           .where((transaction) =>
//               transaction.title.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text('Riwayat Transaksi'),
//         backgroundColor: Color.fromARGB(255, 124, 181, 24),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: TextField(
//               onChanged: _searchTransactions,
//               decoration: InputDecoration(
//                 labelText: 'Cari Transaksi',
//                 prefixIcon: Icon(Icons.search),
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: filteredTransactions.length,
//               itemBuilder: (context, index) {
//                 final transaction = filteredTransactions[index];
//                 return ListTile(
//                   leading: Icon(Icons.shopping_cart),
//                   title: Text(transaction.title),
//                   subtitle: Text(transaction.date.toString()),
//                   trailing: Text('\$${transaction.amount.toStringAsFixed(2)}'),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigation(
//         selectedIndex: _selectedIndex,
//         onItemTapped: _onItemTapped,
//       ),
//     );
//   }
// }

// // void main() {
// //   runApp(MaterialApp(
// //     home: CashierHistoryPage(),
// //   ));
// // }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/bottom_navigation.dart';
import 'cashier_homepage.dart';
import 'list_product.dart';

class Transaction {
  final String produkId;
  final DateTime tanggalTrans;
  final double total;

  Transaction(
      {required this.produkId,
      required this.tanggalTrans,
      required this.total});
}

class CashierHistoryPage extends StatefulWidget {
  const CashierHistoryPage({Key? key}) : super(key: key);
  @override
  _CashierHistoryPageState createState() => _CashierHistoryPageState();
}

class _CashierHistoryPageState extends State<CashierHistoryPage> {
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
    () => const cashierHomepage(),
    () => const CashierListProduct(),
    () => const CashierHistoryPage(),
  ];

  List<Transaction> transactions = [];
  List<Transaction> filteredTransactions = [];

  @override
  void initState() {
    super.initState();
    fetchTransactions();
  }

  Future<void> fetchTransactions() async {
    final response = await http.get(Uri.parse(
        'https://group1mobileproject.000webhostapp.com/getTransaction.php'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonTransactions = jsonDecode(response.body);
      setState(() {
        transactions = jsonTransactions.map((json) {
          return Transaction(
            produkId: json['produk_id'],
            tanggalTrans: DateTime.parse(json['tanggaltrans']),
            total: json['total'].toDouble(),
          );
        }).toList();
        filteredTransactions = transactions;
      });
    } else {
      throw Exception('Failed to fetch transactions');
    }
  }

  void _searchTransactions(String query) {
    setState(() {
      filteredTransactions = transactions
          .where((transaction) =>
              transaction.produkId.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Riwayat Transaksi'),
        backgroundColor: Color.fromARGB(255, 124, 181, 24),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: _searchTransactions,
              decoration: InputDecoration(
                labelText: 'Cari Transaksi',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredTransactions.length,
              itemBuilder: (context, index) {
                final transaction = filteredTransactions[index];
                return ListTile(
                  leading: Icon(Icons.shopping_cart),
                  title: Text(transaction.produkId),
                  subtitle: Text(transaction.tanggalTrans.toString()),
                  trailing: Text('\$${transaction.total.toStringAsFixed(2)}'),
                );
              },
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
