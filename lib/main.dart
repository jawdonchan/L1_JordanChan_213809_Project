import 'package:flutter/material.dart';
import 'home.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'White App Bar',
      theme: ThemeData(
        primaryColor: Colors.white, // Set the primary color to white
      ),
      home: HomePage(),
      // home: Scaffold(
      //   appBar: AppBar(
      //     title: Text('White App Bar'),
      //     backgroundColor: Colors.white, // Set the background color to white
      //   ),
      //   body: Center(
      //     child: Text('Hello, World!'),
      //   ),
      // ),
    );
  }
}
