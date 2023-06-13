import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditSupplierPage extends StatefulWidget {
  final String namaSupplier;
  final String noTelepon;

  const EditSupplierPage({
    Key? key,
    required this.namaSupplier,
    required this.noTelepon,
  }) : super(key: key);

  @override
  _EditSupplierPageState createState() => _EditSupplierPageState();
}

class _EditSupplierPageState extends State<EditSupplierPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _namaSupplierController;
  late TextEditingController _noTeleponController;

  @override
  void initState() {
    super.initState();
    _namaSupplierController = TextEditingController(text: widget.namaSupplier);
    _noTeleponController = TextEditingController(text: widget.noTelepon);
  }

  @override
  void dispose() {
    _namaSupplierController.dispose();
    _noTeleponController.dispose();
    super.dispose();
  }

  Future<void> updateSupplier() async {
    if (_formKey.currentState!.validate()) {
      final oldNamaSupplier = widget.namaSupplier;
      final newNamaSupplier = _namaSupplierController.text;
      final noTelepon = _noTeleponController.text;

      final url =
          'https://group1mobileproject.000webhostapp.com/updateSupplier.php';

      final response = await http.post(
        Uri.parse(url),
        body: {
          'oldNamaSupplier': oldNamaSupplier,
          'newNamaSupplier': newNamaSupplier,
          'noTelepon': noTelepon,
        },
      );

      if (response.statusCode == 200) {
        // Supplier updated successfully
        // You can add any additional logic here, such as showing a success message
        Navigator.of(context).pop();
      } else {
        // Error updating supplier
        // You can handle the error or show an error message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to update supplier. Please try again.'),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Supplier'),
        backgroundColor: Color.fromARGB(255, 124, 181, 24),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _namaSupplierController,
                decoration: InputDecoration(labelText: 'Supplier Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a supplier name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _noTeleponController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  updateSupplier();
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
