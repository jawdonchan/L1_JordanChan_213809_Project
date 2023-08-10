import 'package:flutter/material.dart';

class CardDetailsPage extends StatelessWidget {
  final String cardName;
  final String cardDescription;
  final String cardApplication;

  CardDetailsPage({
    @required this.cardName,
    @required this.cardDescription,
    @required this.cardApplication,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            cardName,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(cardDescription),
          SizedBox(height: 10),
          Text(cardApplication),
        ],
      ),
    );
  }
}
