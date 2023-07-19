import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isDeclarationChecked = false;
  void signUp() {
    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    // Perform sign-up logic with the provided email and password
    // ...

    // Example: Print the email and password for demonstration
    print('Name: $name');
    print('Email: $email');
    print('Password: $password');
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
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Name *',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    // labelText: 'Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Email *',
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
                ),
              ),
              SizedBox(height: 10.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Password *',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    // labelText: 'Password',
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                      child: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: Colors.blue, // Set the border color
                        width: 2.0, // Set the border width
                      ),
                    ),
                  ),
                  obscureText: !_isPasswordVisible,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text('Declaration',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Checkbox(
                      value: _isDeclarationChecked,
                      onChanged: (value) {
                        setState(() {
                          _isDeclarationChecked = value;
                        });
                      },
                    ),
                  ),
                  // Reduced spacing using SizedBox
                  Text('I agree to the terms and conditions.'),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: _isDeclarationChecked,
                    onChanged: (value) {
                      setState(() {
                        _isDeclarationChecked = value;
                      });
                    },
                  ),
                  SizedBox(width: 4.0), // Reduced spacing using SizedBox
                  Text('I agree to the terms and conditions.'),
                ],
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: signUp,
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
