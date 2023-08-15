import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmailPage extends StatefulWidget {
  @override
  _EmailPageState createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  TextEditingController _toController = TextEditingController();
  TextEditingController _subjectController = TextEditingController();
  TextEditingController _messageController = TextEditingController();

  void _sendEmail() async {
    String to = _toController.text.trim();
    String subject = _subjectController.text.trim();
    String message = _messageController.text.trim();

    if (to.isNotEmpty && subject.isNotEmpty && message.isNotEmpty) {
      final emailUri = 'mailto:$to?subject=$subject&body=$message';
      if (await canLaunch(emailUri)) {
        await launch(emailUri);
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Could not launch email app.'),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Align(
            alignment: Alignment.topLeft,
            child: 
               Text(
                'Email',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: 15,),
              TextField(
                controller: _toController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'To',
                   border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                ),
              ),
              SizedBox(height: 15,),
              TextField(
                controller: _subjectController,
                decoration: InputDecoration(
                  labelText: 'Subject',
                   border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                ),
              ),
              SizedBox(height: 15,),
              TextField(
                controller: _messageController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Message',
                   border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _sendEmail,
                child: Text('Send Email'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


