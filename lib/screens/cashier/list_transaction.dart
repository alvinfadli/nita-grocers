import 'package:flutter/material.dart';
import 'package:nita_grocers/screens/cashier/insert_product.dart';
import 'package:nita_grocers/screens/cashier/cashier_history.dart';
import 'package:nita_grocers/screens/cashier/list_product.dart';
import 'cashier_homepage.dart';
import '../widgets/bottom_navigation.dart';

class CashierListTransaction extends StatefulWidget {
  const CashierListTransaction({Key? key}) : super(key: key);
  @override
  _CashierListTransactionState createState() => _CashierListTransactionState();
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'List Barang',
//       theme: ThemeData(
//         primaryColor: Color(0xFF7CB518), // Contoh warna hijau dengan kode heksadesimal #7CB518
//       ),
//       home: ListProdukPage(),
//     );
//   }
// }

// class ListProdukPage extends StatelessWidget {
// final List<Produk> produkList = [
//   Produk('P001', 'Lemineral 600ml', 'Minuman', 3000, 5000, 100, Icons.local_drink),
//   Produk('P002', 'Gerry Salut 25g', 'Makanan', 10000, 12000, 5, Icons.fastfood),
//   Produk('P003', 'Marjan Melon', 'Minuman', 18000, 20000, 20, Icons.local_drink),
//   Produk('P004', 'Gula 500g', 'Makanan', 15000, 20000, 15, Icons.fastfood),

//   ];
class _CashierListTransactionState extends State<CashierListTransaction> {
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => _widgetOptions[index]()),
    );
  }

  int _selectedIndex = 1;
  static List<Widget Function()> _widgetOptions = <Widget Function()>[
    () => const cashierHomepage(),
    () => const CashierListTransaction(),
    () => const CashierListProduct(),
    () => const CashierHistoryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF7CB518),
      ),
      body: const Center(
        child: Text(
          'Transaction List',
          style: TextStyle(fontSize: 24),
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
