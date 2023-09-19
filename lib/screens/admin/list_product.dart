import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:nita_grocers/screens/admin/insert_product.dart';
import 'package:nita_grocers/screens/admin/admin_history.dart';
import '../login.dart';
import 'admin_homepage.dart';
import '../widgets/bottom_navigation.dart';

class CashierListProduct extends StatefulWidget {
  const CashierListProduct({Key? key}) : super(key: key);

  @override
  _CashierListProductState createState() => _CashierListProductState();
}

class _CashierListProductState extends State<CashierListProduct> {
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
    () => const AdminHomepage(),
    () => const CashierListProduct(),
    () => const AdminHistoryTransaction(),
    () => LoginScreen(),
  ];
  List<Produk> produkList = [];

  @override
  void initState() {
    super.initState();
    fetchProductData();
  }

  Future<void> fetchProductData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://nitagrocersfix.000webhostapp.com/get-products.php'));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        List<Produk> products = [];
        for (var data in responseData) {
          Produk product = Produk(
            data['namaProduk'],
            data['kategori'],
            data['supplier'],
            int.parse(data['hargaBeli']),
            int.parse(data['hargaJual']),
            int.parse(data['stok']),
          );
          products.add(product);
        }
        setState(() {
          produkList = products;
        });
      } else {
        throw Exception('Failed to fetch product data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF7CB518),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            const DataColumn(label: Text('Nama Produk')),
            const DataColumn(label: Text('Harga Beli')),
            const DataColumn(label: Text('Harga Jual')),
            //const DataColumn(label: Text('Stok')),
          ],
          rows: produkList.map((Produk produk) {
            return DataRow(
              cells: [
                DataCell(
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailProdukPage(produk),
                        ),
                      );
                    },
                    child: Text(produk.namaProduk),
                  ),
                ),
                DataCell(Text(produk.hargaBeli.toString())),
                DataCell(Text(produk.hargaJual.toString())),
                //DataCell(Text(produk.stok.toString())),
              ],
            );
          }).toList(),
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const InsertProductPage()));
        },
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xFF7CB518),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class Produk {
  final String namaProduk;
  final String kategori;
  final String supplier;
  final int hargaBeli;
  final int hargaJual;
  final int stok;

  Produk(
    this.namaProduk,
    this.kategori,
    this.supplier,
    this.hargaBeli,
    this.hargaJual,
    this.stok,
  );
}

class DetailProdukPage extends StatelessWidget {
  final Produk produk;

  DetailProdukPage(this.produk);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
        backgroundColor: const Color(0xFF7CB518),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            Text(
              'Kategori: ${produk.kategori}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(
              'Harga Beli: ${produk.hargaBeli}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(
              'Harga Jual: ${produk.hargaJual}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(
              'Stok: ${produk.stok}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
