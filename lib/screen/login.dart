import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home.dart';
import 'package:proj_layout/bus/bs_jsonparser.dart';

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
        MaterialPageRoute(builder: (context) => 
        // NextPage()
        
        CPJsonParse(),
        ),
      );
    } else {
      // Handle login failure (e.g., show an error message)
      print('Invalid email or password');
    }
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
                onPressed: login,
                child: Text('Login'),
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
