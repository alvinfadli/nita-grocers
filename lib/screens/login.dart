import 'package:flutter/material.dart';
import 'package:nita_grocers/screens/cashier/cashier_homepage.dart';

class LoginScreen extends StatelessWidget {
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
                    child: Image.asset('assets/big_logo.png')),
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                    hintText: 'Enter username',
                    fillColor: Color.fromARGB(255, 124, 181, 24),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 124, 181, 24),
                        )),
                  ),
                )),
            Padding(
                padding: const EdgeInsets.only(
                    left: 25.0, right: 25.0, top: 15, bottom: 20),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter password',
                    fillColor: Color.fromARGB(255, 124, 181, 24),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  obscureText: true,
                )),
            SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => cashierHomepage()));
                },
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 124, 181, 24),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0))),
                child: Text("Login",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
