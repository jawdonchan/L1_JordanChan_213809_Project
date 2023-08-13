import 'package:flutter/material.dart';
import 'package:proj_layout/services/user_card_service.dart';

class TopUpPage extends StatelessWidget {
  final String userEmail = 'user@example.com'; // Replace with the actual user's email
  final double topUpValue = 50.0; // Replace with the actual top-up value

  @override
  Widget build(BuildContext context) {
    UserCardService userCardService = UserCardService();

    return Scaffold(
      appBar: AppBar(
        title: Text('Top Up Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Top Up Your Card',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Call the addValueToCard method
                await userCardService.addValueToCard(userEmail, topUpValue);
                // Show success message or navigate back
              },
              child: Text('Top Up'),
            ),
          ],
        ),
      ),
    );
  }
}
