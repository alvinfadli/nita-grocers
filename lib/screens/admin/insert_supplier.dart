import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nita_grocers/screens/admin/supplier_list.dart';

class InsertSupplierPage extends StatefulWidget {
  const InsertSupplierPage({Key? key}) : super(key: key);

  @override
  _InsertSupplierPageState createState() => _InsertSupplierPageState();
}

class _InsertSupplierPageState extends State<InsertSupplierPage> {
  TextEditingController namaSupplierController = TextEditingController();
  TextEditingController noTeleponController = TextEditingController();

  Future<void> _submitSupplier() async {
    final url = 'https://nitagrocersfix.000webhostapp.com/insert-supplier.php';

    final response = await http.post(
      Uri.parse(url),
      body: {
        'namasupplier': namaSupplierController.text,
        'notelepon': noTeleponController.text,
      },
    );

    if (response.statusCode == 200) {
      // Supplier inserted successfully
      // You can add any additional logic here, such as showing a success message
      // Navigator.pop(context); // Navigate back to the previous page
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SupplierListPage()));
    } else {
      // Error inserting supplier
      // You can handle the error or show an error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to insert supplier. Please try again.'),
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
        title: Text('Insert Supplier'),
        backgroundColor: Color.fromARGB(255, 124, 181, 24),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: namaSupplierController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nama Supplier',
              ),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: noTeleponController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'No. Telepon',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(fontSize: 20),
                primary: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                minimumSize: Size(200, 50),
              ),
              onPressed: () {
                _submitSupplier();
              },
              child: Text('Insert Supplier'),
            ),
          ],
        ),
      ),
    );
  }
}
