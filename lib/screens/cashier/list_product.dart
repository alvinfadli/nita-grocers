import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:nita_grocers/screens/cashier/insert_product.dart';
import 'package:nita_grocers/screens/cashier/cashier_history.dart';
import 'package:nita_grocers/screens/cashier/list_transaction.dart';
import 'cashier_homepage.dart';
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

  int _selectedIndex = 2;
  static List<Widget Function()> _widgetOptions = <Widget Function()>[
    () => const cashierHomepage(),
    () => const CashierListTransaction(),
    () => const CashierListProduct(),
    () => const CashierHistoryPage(),
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
          'https://group1mobileproject.000webhostapp.com/getProduct.php'));
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
        title: Text('Products'),
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF7CB518),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: DataTable(
            columns: [
              DataColumn(label: Text('Nama Produk')),
              DataColumn(label: Text('Harga Beli')),
              DataColumn(label: Text('Harga Jual')),
              DataColumn(label: Text('Stok')),
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
                  DataCell(Text(produk.stok.toString())),
                ],
              );
            }).toList(),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => InsertProductPage()));
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF7CB518),
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
        title: Text('Detail Produk'),
        backgroundColor: Color(0xFF7CB518),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            Text(
              'Kategori: ${produk.kategori}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Harga Beli: ${produk.hargaBeli}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Harga Jual: ${produk.hargaJual}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Stok: ${produk.stok}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
