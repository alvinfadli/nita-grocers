import 'package:flutter/material.dart';
import '../widgets/bottom_navigation.dart';
import 'admin_homepage.dart';
import 'list_product.dart';

class Transaction {
  final String title;
  final double amount;
  final DateTime date;

  Transaction({required this.title, required this.amount, required this.date});
}

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

  final List<Transaction> transactions = [
    Transaction(title: 'Kasir1', amount: 49.99, date: DateTime.now()),
    Transaction(title: 'Kasir2', amount: 12.99, date: DateTime.now()),
    Transaction(title: 'Kasir', amount: 99.99, date: DateTime.now()),
  ];

  List<Transaction> filteredTransactions = [];

  @override
  void initState() {
    super.initState();
    filteredTransactions = transactions;
  }

  void _searchTransactions(String query) {
    setState(() {
      filteredTransactions = transactions
          .where((transaction) =>
              transaction.title.toLowerCase().contains(query.toLowerCase()))
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
                  title: Text(transaction.title),
                  subtitle: Text(transaction.date.toString()),
                  trailing: Text('\$${transaction.amount.toStringAsFixed(2)}'),
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

// void main() {
//   runApp(MaterialApp(
//     home: AdminHistoryTransaction(),
//   ));
// }

