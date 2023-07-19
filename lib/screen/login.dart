import 'package:flutter/material.dart';
import 'package:proj_layout/bus/home.dart';
import 'package:provider/provider.dart';
import 'package:proj_layout/screen/signup.dart';
import 'package:proj_layout/carpark/cp_jsonparser.dart';

import 'home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void login() {
    String email = _emailController.text;
    String password = _passwordController.text;

    // Here you can add your logic to validate the email and password.
    // For simplicity, we'll assume the login is successful if both fields are non-empty.

    if (email.isNotEmpty && password.isNotEmpty) {
      // Navigate to the next page after successful login
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              // NextPage()
              HomePage(),
          // CPJsonParse(),
        ),
      );
    } else {
      // Handle login failure (e.g., show an error message)
      print('Invalid email or password');
    }
  }

  void signup() {
    // Navigate to the next page after successful login
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            // NextPage()

            SignUpPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios, // Use any custom icon here
            color: Colors.black, // Set the desired color for the icon
          ),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Email',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    // labelText: 'Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              SizedBox(height: 30.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Password:',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    // labelText: 'Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: login,
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white, // Set the button background color
                      onPrimary: Colors.white, // Set the text color
                      padding: EdgeInsets.symmetric(
                          horizontal: 40.0,
                          vertical: 10.0), // Set the button padding
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              8.0)), // Set the button border radius
                    ),
                  ),
                  ElevatedButton(
                    onPressed: signup,
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white, // Set the button background color
                      onPrimary: Colors.white, // Set the text color
                      padding: EdgeInsets.symmetric(
                          horizontal: 40.0,
                          vertical: 10.0), // Set the button padding
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              8.0)), // Set the button border radius
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class NextPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Next Page'),
//       ),
//       body: Center(
//         child: Text('Welcome to the next page!'),
//       ),
//     );
//   }
// }
