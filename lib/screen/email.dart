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
        title: Text('Email Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _toController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'To',
              ),
            ),
            TextField(
              controller: _subjectController,
              decoration: InputDecoration(
                labelText: 'Subject',
              ),
            ),
            TextField(
              controller: _messageController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Message',
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
    );
  }
}


