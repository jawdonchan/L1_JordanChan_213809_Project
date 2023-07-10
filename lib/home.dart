import 'package:flutter/material.dart';
import 'nextpage.dart';
class HomePage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('White App Bar'),
          backgroundColor: Colors.white, // Set the background color to white
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NextPage(),
                  ),
                );
              },
              child: Text('Go to next page'),
            )
          )
        ]
      ) 
    );
  }
}