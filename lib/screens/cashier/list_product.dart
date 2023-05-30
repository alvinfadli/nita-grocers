import 'package:flutter/material.dart';
import 'package:nita_grocers/screens/cashier/insert_product.dart';
import 'package:nita_grocers/screens/cashier/cashier_history.dart';
import 'cashier_homepage.dart';
import '../widgets/bottom_navigation.dart';

class CashierListProduct extends StatefulWidget {
  const CashierListProduct({Key? key}) : super(key: key);
  @override
  _CashierListProductState createState() => _CashierListProductState();
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
    () => cashierHomepage(),
    () => CashierListProduct(),
    () => CashierHistoryPage(),
  ];
  final List<Produk> produkList = [
    Produk('P001', 'Lemineral 600ml', 'Minuman', 3000, 5000, 100,
        Icons.local_drink),
    Produk(
        'P002', 'Gerry Salut 25g', 'Makanan', 10000, 12000, 5, Icons.fastfood),
    Produk(
        'P003', 'Marjan Melon', 'Minuman', 18000, 20000, 20, Icons.local_drink),
    Produk('P004', 'Gula 500g', 'Makanan', 15000, 20000, 15, Icons.fastfood),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF7CB518),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(label: Text('Nomor Produk')),
            DataColumn(label: Text('Nama Produk')),
            DataColumn(label: Text('Kategori')),
            DataColumn(label: Text('Harga Pokok')),
            DataColumn(label: Text('Harga Jual')),
            DataColumn(label: Text('Stok')),
          ],
          rows: produkList.map((Produk produk) {
            return DataRow(cells: [
              DataCell(Text(produk.nomorProduk)),
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
                  child: Row(
                    children: [
                      Icon(produk.icon),
                      SizedBox(width: 8),
                      Text(produk.namaProduk),
                    ],
                  ),
                ),
              ),
              DataCell(Text(produk.kategori)),
              DataCell(Text(produk.hargaPokok.toString())),
              DataCell(Text(produk.hargaJual.toString())),
              DataCell(Text(produk.stok.toString())),
            ]);
          }).toList(),
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Aksi saat tombol "Add Product" ditekan
          // Contoh: Navigasi ke halaman tambah produk
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
  final String nomorProduk;
  final String namaProduk;
  final String kategori;
  final int hargaPokok;
  final int hargaJual;
  final int stok;
  final IconData icon;

  Produk(this.nomorProduk, this.namaProduk, this.kategori, this.hargaPokok,
      this.hargaJual, this.stok, this.icon);
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
            Icon(produk.icon, size: 64),
            SizedBox(height: 16),
            Text(
              'Nama Produk: ${produk.namaProduk}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            Text(
              'Kategori: ${produk.kategori}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Harga Pokok: ${produk.hargaPokok}',
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
