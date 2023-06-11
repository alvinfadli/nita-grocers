import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'list_product.dart';

class InsertProductPage extends StatefulWidget {
  const InsertProductPage({Key? key}) : super(key: key);

  @override
  _InsertProductState createState() => _InsertProductState();
}

class _InsertProductState extends State<InsertProductPage> {
  String? selectedCategory;
  String? selectedSupplier;

  List<Map<String, String>> categories = [];
  List<Map<String, String>> suppliers = [];
  TextEditingController productNameController = TextEditingController();
  TextEditingController hargaBeliController = TextEditingController();
  TextEditingController hargaJualController = TextEditingController();
  TextEditingController stokProdukController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchCategories();
    fetchSuppliers();
  }

  Future<void> fetchCategories() async {
    try {
      final url = Uri.parse(
          'https://group1mobileproject.000webhostapp.com/getCategories.php');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as List<dynamic>;
        final categoryList = jsonData.map((category) {
          final idKategori = category['id_kategori'].toString();
          final namaKategori = category['namakategori'].toString();
          return {'id': idKategori, 'name': namaKategori};
        }).toList();

        setState(() {
          categories = List<Map<String, String>>.from(categoryList);
        });
      } else {
        throw Exception('Failed to fetch categories: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to fetch categories: $error');
    }
  }

  Future<void> fetchSuppliers() async {
    try {
      final url = Uri.parse(
          'https://group1mobileproject.000webhostapp.com/getSuppliers.php');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as List<dynamic>;
        final supplierList = jsonData.map((supplier) {
          final idSupplier = supplier['id_supplier'].toString();
          final namaSupplier = supplier['namasupplier'].toString();
          return {'id': idSupplier, 'namasupplier': namaSupplier};
        }).toList();

        setState(() {
          suppliers = List<Map<String, String>>.from(supplierList);
        });
      } else {
        throw Exception('Failed to fetch suppliers: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to fetch suppliers: $error');
    }
  }

  Future<void> _submitProduct() async {
    final url =
        'https://group1mobileproject.000webhostapp.com/inputProduct.php';

    final response = await http.post(
      Uri.parse(url),
      body: {
        'nama_produk': productNameController.text,
        'id_kategori': selectedCategory ?? '',
        'id_supplier': selectedSupplier ?? '',
        'harga_beli': hargaBeliController.text,
        'harga_jual': hargaJualController.text,
        'stok': stokProdukController.text,
      },
    );

    if (response.statusCode == 200) {
      // Product inserted successfully
      // You can add any additional logic here, such as showing a success message
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CashierListProduct()),
      );
    } else {
      // Error inserting product
      // You can handle the error or show an error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to insert product. Please try again.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Product'),
        automaticallyImplyLeading: true,
        backgroundColor: Color.fromARGB(255, 124, 181, 24),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextField(
                  controller: productNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nama Produk',
                  ),
                ),
                SizedBox(height: 10.0),
                TextField(
                  controller: hargaBeliController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Harga Beli',
                  ),
                ),
                SizedBox(height: 10.0),
                TextField(
                  controller: hargaJualController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Harga Jual',
                  ),
                ),
                SizedBox(height: 10.0),
                TextField(
                  controller: stokProdukController,
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
                  items: categories.map((Map<String, String> category) {
                    return DropdownMenuItem<String>(
                      value: category['id']!, // Use the correct data type here
                      child:
                          Text(category['name'] ?? ''), // Add a null check here
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
                  items: suppliers.map((Map<String, String> supplier) {
                    return DropdownMenuItem<String>(
                      value: supplier['id']!, // Use the correct data type here
                      child: Text(supplier['namasupplier'] ??
                          ''), // Add a null check here
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    minimumSize: Size(200, 50), // Adjust the height here
                  ),
                  onPressed: () {
                    _submitProduct();
                  },
                  child: Text('Input Produk'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
