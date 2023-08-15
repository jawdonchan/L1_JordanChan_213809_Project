import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:proj_layout/screen/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false; // hide password text
  bool _isDeclarationChecked = false; // for the checkbox
  void signUp() async {
  try {
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (email.isNotEmpty && password.isNotEmpty && confirmPassword.isNotEmpty) {
      if (password == confirmPassword) {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        if (userCredential != null) {
          // Check if user details document already exists
          QuerySnapshot userDetailsSnapshot = await FirebaseFirestore.instance
              .collection('User Details')
              .where('email', isEqualTo: email)
              .get();

          if (userDetailsSnapshot.docs.isEmpty) {
            // Create a new user details document
            Map<String, dynamic> newUserData = {
              'email': email,
              'name': '', // You can add other fields here
            };

            await FirebaseFirestore.instance
                .collection('User Details')
                .doc(userCredential.user.uid) // Use user's UID as document ID
                .set(newUserData);
          }

          // Successfully signed up, navigate to the next page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        }
      } else {
        // Handle password mismatch
        throw 'Passwords do not match';
      }
    } else {
      // Handle missing input fields
      throw 'Please enter email and password';
    }
  } catch (error) {
    // Handle signup error
    print('Error signing up: $error');
    // Display error message using a dialog or a snackbar
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Sign Up Error'),
          content: Text(error.toString()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
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
                child: TextFormField(
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
              buildPasswordInput(_passwordController, _isPasswordVisible, () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              }),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Confirm Password *',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                ),
              ),
              buildPasswordInput(_confirmPasswordController, _isPasswordVisible,
                  () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              }),
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

Widget buildPasswordInput(
  TextEditingController controller,
  bool isPasswordVisible,
  Function togglePasswordVisibility,
) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: GestureDetector(
          onTap: togglePasswordVisibility,
          child: Icon(
            isPasswordVisible ? Icons.visibility : Icons.visibility_off,
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
      obscureText: !isPasswordVisible,
    ),
  );
}
