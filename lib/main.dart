import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lists_api/list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  Future<void> _registerUser() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (password != 'pistol') {
      setState(() {
        _errorMessage = 'Password must be "pistol"';
      });
      return;
    }

    var response = await http.post(
      Uri.parse('https://reqres.in/api/register'),
      body: jsonEncode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserListPage(),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to register user. Please try again.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: SizedBox(
          height: 600,
          child: Container(
            padding: EdgeInsets.all(25),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.orange, Color.fromARGB(255, 241, 180, 88)],
              ),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(80),
                  bottomRight: Radius.circular(80),
                  topLeft: Radius.circular(80),
                  topRight: Radius.circular(80)),
            ),
            child: Center(
              child: Container(
                height: 400,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 70,
                    ),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 24),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3,
                              color: Color.fromARGB(193, 240, 195, 32)),
                        ),
                      ),
                    ),
                    SizedBox(height: 25.0),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 24),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3,
                              color: Color.fromARGB(255, 255, 202, 60)),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      _errorMessage,
                      style: TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 24.0),
                    ElevatedButton(
                      onPressed: _registerUser,
                      child: Text(
                        'Submit',
                        style: TextStyle(fontSize: 22.0, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: EdgeInsets.symmetric(horizontal: 28.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
