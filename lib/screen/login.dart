import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(
          Icons.arrow_back_ios, // Use any custom icon here
          color: Colors.black, // Set the desired color for the icon
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Login',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
                textAlign: TextAlign.left,
              ),
            ),
            Text(
              'Email',
              style: TextStyle(fontSize: 25),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                String email = _emailController.text;
                String password = _passwordController.text;
                // Here you can add your logic to validate the email and password
                // and perform the login action.
                // For now, we will simply print the values.
                print('Email: $email');
                print('Password: $password');
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
