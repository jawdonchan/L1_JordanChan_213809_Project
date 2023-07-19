import 'package:flutter/material.dart';
import 'package:proj_layout/main.dart';
import 'nextpage.dart';
import 'login.dart';
import 'package:provider/provider.dart';

class PromptPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('White App Bar'),
          backgroundColor: Colors.white, // Set the background color to white
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Center(
              child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
            child: Text('Go to Login page'),
          ))
        ]));
  }
}
