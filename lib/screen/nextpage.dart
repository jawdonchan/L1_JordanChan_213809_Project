import 'package:flutter/material.dart';

class NextPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          title: Text('Custom Back Button'),
          backgroundColor: Colors.transparent,// Set a transparent background color
          elevation: 0,  // Set elevation to 0 for a flat appearance
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios, // Use any custom icon here
              color: Colors.black, // Set the desired color for the icon
            ),
            onPressed: () {
              // Handle the back button press
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            Center(
              child: Text('Im gay'),
            ),
            
          ]
        ),
        
      
    );
  }
}