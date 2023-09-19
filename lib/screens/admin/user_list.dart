import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nita_grocers/screens/admin/admin_homepage.dart';
import 'dart:convert';

import 'package:nita_grocers/screens/admin/edit_cashier.dart';
import 'package:nita_grocers/screens/admin/insert_cashier.dart';
import 'package:nita_grocers/screens/cashier/cashier_homepage.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  List<Map<String, String>> users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      final url =
          Uri.parse('https://nitagrocersfix.000webhostapp.com/get-users.php');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as List<dynamic>;
        final userList = jsonData.map((user) {
          final idUser = user['id_user'].toString(); // Fetch the id_user
          final namaUser = user['name_user'].toString();
          final username = user['username'].toString();
          final password = user['password'].toString();
          return {
            'id_user': idUser,
            'name_user': namaUser,
            'username': username,
            'password': password
          };
        }).toList();

        setState(() {
          users = List<Map<String, String>>.from(userList);
        });
      } else {
        throw Exception('Failed to fetch users: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to fetch users: $error');
    }
  }

  void navigateToEditPage(Map<String, String> user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditCashierPage(user: user),
      ),
    ).then((value) {
      // Refresh the user list when returning from the edit page
      fetchUsers();
    });
  }

  Future<void> deleteUser(Map<String, String> user) async {
    final userID = user['id_user'];

    final url = Uri.parse(
        'https://nitagrocersfix.000webhostapp.com/delete-cashier.php');

    final response = await http.post(
      url,
      body: {
        'id_user': userID,
      },
    );

    if (response.statusCode == 200) {
      // User deleted successfully
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('User deleted successfully.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    users.remove(user); // Remove the deleted user from the list
                  });
                },
              ),
            ],
          );
        },
      );
    } else {
      // Error deleting user
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to delete user.'),
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
        title: Text('Cashier List'),
        backgroundColor: Color.fromARGB(255, 124, 181, 24),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate to a different page when the back button is pressed
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AdminHomepage()), // Replace `MyHomePage` with the desired page
            );
          },
        ),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            title: Text(user['name_user'] ?? ''),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Username: ${user['username'] ?? ''}'),
                Text('Password: ${user['password'] ?? ''}'),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    navigateToEditPage(user); // Navigate to the edit page
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    deleteUser(
                        user); // Show confirmation dialog and delete the user
                  },
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
                  builder: (context) => const InsertCashierPage()));
        },
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xFF7CB518),
      ),
    );
  }
}
