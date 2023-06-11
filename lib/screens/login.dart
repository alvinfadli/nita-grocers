import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:nita_grocers/screens/admin/admin_homepage.dart';
import 'package:nita_grocers/screens/cashier/cashier_homepage.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> login() async {
    var url =
        Uri.parse('https://group1mobileproject.000webhostapp.com/login.php');

    var response = await http.post(url, body: {
      'username': _usernameController.text,
      'password': _passwordController.text,
    });

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      if (result['status'] == 'success' && result['id_role'] == 1) {
        print(result['message']);
        // Login successful
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AdminHomepage()),
        );
      } else if (result['status'] == 'success' && result['id_role'] == 2) {
        print(result['message']);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CashierHomepage()),
        );
      } else {
        // Login failed
      }
    } else {
      // Error in the request
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                  width: 350,
                  height: 300,
                  child: Image.asset('assets/big_logo.png'),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  hintText: 'Enter username',
                  fillColor: Color.fromARGB(255, 124, 181, 24),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 124, 181, 24),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 25.0,
                right: 25.0,
                top: 15,
                bottom: 20,
              ),
              child: TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter password',
                  fillColor: Color.fromARGB(255, 124, 181, 24),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                obscureText: true,
              ),
            ),
            SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  login();
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 124, 181, 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: Text(
                  "Login",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class Dashboard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Dashboard'),
//       ),
//       body: Center(
//         child: Text('Welcome to the Dashboard!'),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:nita_grocers/screens/cashier/cashier_homepage.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:nita_grocers/main.dart';

// class LoginScreen extends StatelessWidget {
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

//   BuildContext? _scaffoldContext;

//   Future<void> login(BuildContext context) async {
//     var url = Uri.parse('https://nitagrocers.000webhostapp.com/login.php');

//     var response = await http.post(url, body: {
//       'username': _usernameController.text,
//       'password': _passwordController.text,
//     });

//     if (_scaffoldContext == null) return;

//     if (response.statusCode == 200) {
//       var result = jsonDecode(response.body);
//       if (result['status'] == 'success') {
//         // Login successful
//         //Navigator.pushReplacementNamed(context, MaterialPageRoute(builder: (context) => cashierHomepage()));
//         //print("BANGSATTTTTTTT");
//         //Navigator.push(MaterialPageRoute(builder: (_) => cashierHomepage()));
//         Navigator.pushReplacement(context,
//             MaterialPageRoute(builder: (context) => cashierHomepage()));
//       } else {
//         // Login failed
//         showDialog(
//           context: _scaffoldContext!,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: const Text('Login Failed'),
//               content: Text(result['message']),
//               actions: [
//                 TextButton(
//                   child: const Text('OK'),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             );
//           },
//         );
//       }
//     } else {
//       // Error in the request
//       showDialog(
//         context: _scaffoldContext!,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text('Error'),
//             content: Text('Error: ${response.statusCode}'),
//             actions: [
//               TextButton(
//                 child: const Text('OK'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.only(top: 60.0),
//               child: Center(
//                 child: Container(
//                     width: 350,
//                     height: 300,
//                     child: Image.asset('assets/big_logo.png')),
//               ),
//             ),
//             Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 25),
//                 child: TextFormField(
//                   controller: _usernameController,
//                   decoration: InputDecoration(
//                     labelText: 'Username',
//                     hintText: 'Enter username',
//                     fillColor: const Color.fromARGB(255, 124, 181, 24),
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20.0),
//                         borderSide: const BorderSide(
//                           color: Color.fromARGB(255, 124, 181, 24),
//                         )),
//                   ),
//                 )),
//             Padding(
//                 padding: const EdgeInsets.only(
//                     left: 25.0, right: 25.0, top: 15, bottom: 20),
//                 child: TextFormField(
//                   controller: _passwordController,
//                   decoration: InputDecoration(
//                     labelText: 'Password',
//                     hintText: 'Enter password',
//                     fillColor: const Color.fromARGB(255, 124, 181, 24),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20.0),
//                     ),
//                   ),
//                   obscureText: true,
//                 )),
//             SizedBox(
//               height: 50,
//               width: 200,
//               child: ElevatedButton(
//                 // onPressed: () {
//                 // Navigator.push(context,
//                 //     MaterialPageRoute(builder: (_) => cashierHomepage()));
//                 // },
//                 onPressed: () {
//                   login(context);
//                 },
//                 style: ElevatedButton.styleFrom(
//                     primary: const Color.fromARGB(255, 124, 181, 24),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20.0))),
//                 child: const Text("Login",
//                     style: TextStyle(
//                       fontSize: 20,
//                       color: Colors.white,
//                       fontWeight: FontWeight.normal,
//                     )),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
