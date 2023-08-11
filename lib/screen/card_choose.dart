import 'package:flutter/material.dart';
import 'package:proj_layout/services/user_card_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'card_details.dart';

class ChooseCardTypePage extends StatefulWidget {
  @override
  _ChooseCardTypePageState createState() => _ChooseCardTypePageState();
}

class _ChooseCardTypePageState extends State<ChooseCardTypePage> {
  String selectedCardName;
  String selectedCardDescription;
  String selectedCardApplication;
  UserCardService _userCardService = UserCardService();
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Available Card Types:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('Cards').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error loading data'),
                  );
                }

                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List<DocumentSnapshot> cardDocs = snapshot.data.docs;
                return ListView.builder(
                  itemCount: cardDocs.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> cardData =
                        cardDocs[index].data() as Map<String, dynamic>;

                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: ListTile(
                        title: Text(cardData['name']),
                        // subtitle: Text(cardData['description']),
                        onTap: () {
                          setState(() {
                            selectedCardName = cardData['name'];
                            selectedCardDescription = cardData['description'];
                            selectedCardApplication = cardData['application'];
                          });
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
          if (selectedCardName != null)
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CardDetailsPage(
                    cardName: selectedCardName,
                    cardDescription: selectedCardDescription,
                    cardApplication: selectedCardApplication,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Send selectedCardType to the database
                      await _userCardService.addUserCard(selectedCardName);
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Success'),
                          content: Text(
                              'Selected card type added to your collection.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Text('Select Card Type'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
