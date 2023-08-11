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

  File _image; // For storing the selected image

  // Function to pick an image from the gallery
  Future _pickImage() async {
    final pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);
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
        title: Text('Update Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _newNameController,
                decoration: InputDecoration(labelText: 'Update Name'),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _newEmailController,
                decoration: InputDecoration(labelText: 'Update Email'),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _newPasswordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Update Password'),
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
                  String profilePicUrl = '';
                  if (_image != null) {
                    // Upload the image and get the download URL
                    // Replace 'profiles' with your desired storage path
                    Reference storageRef = FirebaseStorage.instance.ref().child('profiles/${_image.path}');
                    UploadTask uploadTask = storageRef.putFile(_image);
                    await uploadTask.whenComplete(() async {
                      profilePicUrl = await storageRef.getDownloadURL();
                    });
                  }

                  // Add a new document in the "User Details" collection
                  await FirebaseFirestore.instance.collection('User Details').add({
                    'name': _newNameController.text.trim(),
                    'email': newEmail.isNotEmpty ? newEmail : FirebaseAuth.instance.currentUser.email,
                    'profilepic': profilePicUrl,
                  });

                  // Show a success message using a SnackBar
                  _scaffoldKey.currentState.showSnackBar(
                    SnackBar(content: Text('Profile updated successfully')),
                  );

                  Navigator.pop(context); // Navigate back after updating
                },
                child: Text('Update Profile'),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Pick Profile Picture'),
              ),
              if (_image != null) Image.file(_image), // Show selected image
            ],
          ),
        ),
      ),
    );
  }
}
