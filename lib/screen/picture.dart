import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class UploadFilePage extends StatefulWidget {
  @override
  _UploadFilePageState createState() => _UploadFilePageState();
}

class _UploadFilePageState extends State<UploadFilePage> {
  File _file;
  final picker = ImagePicker();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> _pickFile() async {
  final pickedFile = await picker.getImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    setState(() {
      _file = File(pickedFile.path);
    });
  }
}


  Future<void> _uploadFile() async {
  try {
    if (_file != null) {
      final user = _auth.currentUser;
      final fileName = '${user.uid}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      Reference ref = _storage.ref().child('user_files/$fileName');
      UploadTask uploadTask = ref.putFile(_file);

      await uploadTask.whenComplete(() {
        Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('File uploaded successfully')),
        );
      });
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(content: Text('No file selected')),
      );
    }
  } catch (e) {
    print('Error uploading file: $e');
    Scaffold.of(context).showSnackBar(
      SnackBar(content: Text('Error uploading file')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload File'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _file == null
                ? Text('No file selected.')
                : Text('Selected File: ${_file.path}'),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _pickFile,
              child: Text('Pick File'),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: _uploadFile,
              child: Text('Upload File'),
            ),
          ],
        ),
      ),
    );
  }
}
