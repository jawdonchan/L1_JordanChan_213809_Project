import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CallPage extends StatefulWidget {
  @override
  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  TextEditingController _phoneNumberController = TextEditingController();

  void _makePhoneCall() async {
    String phoneNumber = _phoneNumberController.text.trim();
    if (phoneNumber.isNotEmpty) {
      final phoneCallUri = 'tel:$phoneNumber';
      if (await canLaunch(phoneCallUri)) {
        await launch(phoneCallUri);
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Could not launch phone call.'),
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
        title: Text('Call Page'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _makePhoneCall,
                child: Text('Call'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


