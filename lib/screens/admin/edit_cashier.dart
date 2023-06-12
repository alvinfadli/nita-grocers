import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nita_grocers/screens/admin/user_list.dart';

class EditCashierPage extends StatefulWidget {
  final Map<String, String> user;

  const EditCashierPage({Key? key, required this.user}) : super(key: key);

  @override
  _EditCashierPageState createState() => _EditCashierPageState();
}

class _EditCashierPageState extends State<EditCashierPage> {
  TextEditingController namaUserController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initializeFields();
  }

  void initializeFields() {
    // Initialize the text fields with user data
    namaUserController.text = widget.user['name_user'] ?? '';
    usernameController.text = widget.user['username'] ?? '';
    passwordController.text = widget.user['password'] ?? '';
  }

  Future<void> _updateCashier() async {
    final url = Uri.parse(
        'https://group1mobileproject.000webhostapp.com/updateCashier.php');

    final response = await http.post(
      url,
      body: {
        'oldUsername': widget.user['username'], // Change parameter name
        'newUsername': usernameController.text, // Change parameter name
        'password': passwordController.text,
        'oldNameUser': widget.user['name_user'], // Change parameter name
        'newNameUser': namaUserController.text, // Change parameter name
      },
    );

    if (response.statusCode == 200) {
      // Cashier updated successfully
      // You can add any additional logic here, such as showing a success message
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => UserListPage()),
      );
    } else {
      // Error updating cashier
      // You can handle the error or show an error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to update cashier. Please try again.'),
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
        title: Text('Edit Cashier'),
        backgroundColor: Color.fromARGB(255, 124, 181, 24),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate to a different page when the back button is pressed
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => UserListPage()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: namaUserController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nama User',
              ),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
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
                _updateCashier();
              },
              child: Text('Update Cashier'),
            ),
          ],
        ),
      ),
    );
  }
}
