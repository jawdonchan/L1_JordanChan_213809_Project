import 'package:flutter/material.dart';
import 'package:proj_layout/main.dart';
import 'nextpage.dart';
import 'login.dart';
import 'package:provider/provider.dart';

class PromptPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null, // Remove the app bar only for the PromptPage
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 15,0,0),
            child: Text(
              'FetchMyLine',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
             padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              'images/jyp.jpg', 
              height: 370,
              width: 300,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Flexible(
              child: Text(
                'Find your way around Singapore with precise bus timings and MRT routes for easy planning',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: 300,
            child: ElevatedButton(
              onPressed: () {
                // Navigate to the login page when the button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
               style: ElevatedButton.styleFrom(
                primary: Colors.white, // Background color
                onPrimary: Colors.black, // Text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Rounded corners
                  side: BorderSide(color: Colors.black, width: 2), // to change border color
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Button padding
              ),
              child: Text('Login/Sign Up'),
            ),
          ),
          Container(
            width: 300,
            child: ElevatedButton(
              onPressed: () {
                // Navigate to the guest page when the button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NextPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white, // Background color
                onPrimary: Colors.black, // Text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Rounded corners
                  side: BorderSide(color: Colors.black, width: 2), // to change border color
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Button padding
              ),
              child: Text('Continue as Guest'),
            ),
          ),
        ],
      ),
    );
  }
}
