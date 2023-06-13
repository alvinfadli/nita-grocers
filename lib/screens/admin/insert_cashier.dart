import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nita_grocers/screens/admin/user_list.dart';

class InsertCashierPage extends StatefulWidget {
  const InsertCashierPage({Key? key}) : super(key: key);

  @override
  _InsertCashierPageState createState() => _InsertCashierPageState();
}

class _InsertCashierPageState extends State<InsertCashierPage> {
  TextEditingController nameUserController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> _submitCashier() async {
    final url = 'https://group1mobileproject.000webhostapp.com/insertUser.php';

    final response = await http.post(
      Uri.parse(url),
      body: {
        'name_user': nameUserController.text,
        'username': usernameController.text,
        'password': passwordController.text,
      },
    );

    if (response.statusCode == 200) {
      // Cashier inserted successfully
      // You can add any additional logic here, such as showing a success message
      //Navigator.pop(context); // Navigate back to the previous page
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const UserListPage()));
    } else {
      // Error inserting cashier
      // You can handle the error or show an error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to insert cashier. Please try again.'),
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
        title: Text('Insert Cashier'),
        backgroundColor: Color.fromARGB(255, 124, 181, 24),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: nameUserController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
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
              obscureText: true,
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
                _submitCashier();
              },
              child: Text('Insert Cashier'),
            ),
          ],
        ),
      ),
    );
  }
}
