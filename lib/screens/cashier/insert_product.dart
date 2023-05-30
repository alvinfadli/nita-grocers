import 'package:flutter/material.dart';

class InsertProductPage extends StatefulWidget {
  const InsertProductPage({Key? key}) : super(key: key);
  @override
  _InsertProductState createState() => _InsertProductState();
}

class _InsertProductState extends State<InsertProductPage> {
  String? selectedCategory;
  String? selectedSupplier;

  List<String> categories = [
    'Category 1',
    'Category 2',
    'Category 3',
  ];

  List<String> suppliers = [
    'Supplier 1',
    'Supplier 2',
    'Supplier 3',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Product'),
        automaticallyImplyLeading: true,
        backgroundColor: Color.fromARGB(255, 124, 181, 24),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nama Produk',
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Harga Beli',
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Harga Jual',
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Stok Produk',
                ),
              ),
              SizedBox(height: 10.0),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Kategori',
                ),
                value: selectedCategory,
                items: categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
              ),
              SizedBox(height: 10.0),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Supplier',
                ),
                value: selectedSupplier,
                items: suppliers.map((String supplier) {
                  return DropdownMenuItem<String>(
                    value: supplier,
                    child: Text(supplier),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedSupplier = value;
                  });
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(fontSize: 20),
                  primary: Color.fromARGB(255, 124, 181, 24),
                ),
                onPressed: () {
                  // Logika untuk tombol input
                },
                child: Text('Input Produk'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
