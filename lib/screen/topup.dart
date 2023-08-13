import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proj_layout/services/user_card_service.dart';

class AddValuePage extends StatefulWidget {
  final String userEmail;
  AddValuePage({this.userEmail});

  @override
  _AddValuePageState createState() => _AddValuePageState();
}

class _AddValuePageState extends State<AddValuePage> {
  TextEditingController _valueController = TextEditingController();

 void _addValueToCard() {
  double valueToAdd = double.tryParse(_valueController.text) ?? 0.0;
  print("Value to add: $valueToAdd");
  if (valueToAdd > 0) {
    // Use UserCardService to add value to the card
    UserCardService().addValueToCard(widget.userEmail, valueToAdd);

    // Navigate back to the previous page after adding value
    Navigator.pop(context);
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Value to Card'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _valueController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Value to Add',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addValueToCard,
              child: Text('Add Value'),
            ),
          ],
        ),
      ),
    );
  }
}
