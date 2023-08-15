import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:proj_layout/services/firebaseauth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class UpdateProfilePage extends StatefulWidget {
  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  TextEditingController _newNameController = TextEditingController();
  TextEditingController _newEmailController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _profilePicUrl = '';
  File _image; // For storing the selected image

  // Function to pick an image from the gallery
  Future _pickImage() async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Set the scaffold key
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
                Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Update Profile',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 15,),
              TextField(
                controller: _newNameController,
                decoration: InputDecoration(labelText: 'Update Name',
                border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                ),
                
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _newEmailController,
                decoration: InputDecoration(labelText: 'Update Email',
                border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _newPasswordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Update Password',
                border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  String newEmail = _newEmailController.text.trim();
                  String newPassword = _newPasswordController.text.trim();

                  if (newEmail.isNotEmpty) {
                    await FirebaseAuthService().updateEmail(newEmail);
                  }

                  if (newPassword.isNotEmpty) {
                    await FirebaseAuthService().updatePassword(newPassword);
                  }

                  // Upload the profile picture to Firebase Storage
                  String profilePicUrl =
                      _profilePicUrl; // Keep the current URL as default
                  if (_image != null) {
                    // Upload the image and get the download URL
                    Reference storageRef = FirebaseStorage.instance
                        .ref()
                        .child('profile/${_image.path}');
                    UploadTask uploadTask = storageRef.putFile(_image);
                    await uploadTask.whenComplete(() async {
                      profilePicUrl = await storageRef.getDownloadURL();
                    });
                  }

                  // Update the existing user details document in Firestore
                  QuerySnapshot userDetailsSnapshot = await FirebaseFirestore
                      .instance
                      .collection('User Details')
                      .where('email',
                          isEqualTo: FirebaseAuth.instance.currentUser.email)
                      .get();

                  if (userDetailsSnapshot.docs.isNotEmpty) {
                    DocumentSnapshot userDetailsDoc =
                        userDetailsSnapshot.docs[0];
                    Map<String, dynamic> updatedData = {};

                    if (_newNameController.text.isNotEmpty) {
                      updatedData['name'] = _newNameController.text.trim();
                    }
                    if (newEmail.isNotEmpty) {
                      updatedData['email'] = newEmail;
                    }
                    if (profilePicUrl.isNotEmpty) {
                      updatedData['profilepic'] = profilePicUrl;
                    }

                    await userDetailsDoc.reference.update(updatedData);

                    // Show a success message using a SnackBar
                    _scaffoldKey.currentState.showSnackBar(
                      SnackBar(content: Text('Profile updated successfully')),
                    );

                    Navigator.pop(context); // Navigate back after updating
                  }
                },
                child: Text('Update Profile', 
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
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

              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Pick Profile Picture', 
                 style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
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
              if (_image != null) Image.file(_image), // Show selected image
            ],
          ),
        ),
      ),
    );
  }
}
