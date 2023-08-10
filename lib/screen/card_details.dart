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
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1.0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
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
          // ElevatedButton(
          //   onPressed: () {
          //     Navigator.pop(context, cardName); // Return the selected card type
          //   },
          //   child: Text('Select Card Type'),
          // ),
        ],
      ),
    );
  }
}
