import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lists_api/main.dart';

void main() => runApp(SplashScreenApp());

class SplashScreenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Splash Screen App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  String _welcomeText = '';

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    // Create curved animation
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // Start animation
    _controller.forward();

    // Set welcome text with animation
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _welcomeText = 'U S E R S ';
        });
      }
    });
    Timer(Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RegisterPage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ScaleTransition(
            scale: _animation,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Color.fromARGB(255, 255, 202, 62)),
              height: MediaQuery.of(context).size.height * 0.2,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScaleTransition(
                  scale: _animation,
                  child: Image.asset(
                    'assets/people.png', // Replace with your image asset path
                    width: 100,
                    height: 100,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  _welcomeText,
                  style: TextStyle(fontSize: 24.0, color: Colors.orange),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
