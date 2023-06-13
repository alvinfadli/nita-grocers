import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nita_grocers/screens/admin/edit_supplier.dart';
import 'dart:convert';

import 'package:nita_grocers/screens/admin/insert_supplier.dart';

class SupplierListPage extends StatefulWidget {
  const SupplierListPage({Key? key}) : super(key: key);

  @override
  _SupplierListPageState createState() => _SupplierListPageState();
}

class _SupplierListPageState extends State<SupplierListPage> {
  List<Map<String, String>> suppliers = [];

  @override
  void initState() {
    super.initState();
    fetchSuppliers();
  }

  Future<void> fetchSuppliers() async {
    try {
      final url = Uri.parse(
          'https://group1mobileproject.000webhostapp.com/getSuppliers.php');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as List<dynamic>;
        final supplierList = jsonData.map((supplier) {
          final namaSupplier = supplier['namasupplier'].toString();
          final noTelepon = supplier['notelepon'].toString();
          return {
            'namasupplier': namaSupplier,
            'notelepon': noTelepon,
          };
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

  Future<void> deleteSupplier(int index) async {
    final supplier = suppliers[index];
    final namaSupplier = supplier['namasupplier'];
    final noTelepon = supplier['notelepon'];

    final url =
        'https://group1mobileproject.000webhostapp.com/deleteSupplier.php';

    final response = await http.post(
      Uri.parse(url),
      body: {
        'namasupplier': namaSupplier,
        'notelepon': noTelepon,
      },
    );

    if (response.statusCode == 200) {
      // Supplier deleted successfully
      // You can add any additional logic here, such as showing a success message
      fetchSuppliers(); // Fetch updated supplier list
    } else {
      // Error deleting supplier
      // You can handle the error or show an error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to delete supplier. Please try again.'),
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

  Future<void> editSupplier(int index) async {
    final supplier = suppliers[index];
    final namaSupplier = supplier['namasupplier'];
    final noTelepon = supplier['notelepon'];

    // Implement your edit logic here
    // For example, you can navigate to a new page to edit the supplier details
    // You can pass the existing supplier details to the edit page
    // and update the details using a form or any other input method
    // After the edit is done, you can update the supplier details in the database
    // and fetch the updated supplier list

    // Example:
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditSupplierPage(
          namaSupplier: supplier['namasupplier'] ?? '',
          noTelepon: supplier['notelepon'] ?? '',
        ),
      ),
    ).then((value) {
      // Callback after edit page is closed
      // Fetch the updated supplier list
      fetchSuppliers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Supplier List'),
        backgroundColor: Color.fromARGB(255, 124, 181, 24),
      ),
      body: ListView.builder(
        itemCount: suppliers.length,
        itemBuilder: (context, index) {
          final supplier = suppliers[index];
          return ListTile(
            title: Text(supplier['namasupplier'] ?? ''),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('No. Telepon: ${supplier['notelepon'] ?? ''}'),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    // Edit button action
                    editSupplier(index);
                  },
                  icon: Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () {
                    // Delete button action
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Confirmation'),
                          content: Text(
                              'Are you sure you want to delete this supplier?'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text('Delete'),
                              onPressed: () {
                                deleteSupplier(index);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const InsertSupplierPage()));
        },
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xFF7CB518),
      ),
    );
  }
}
