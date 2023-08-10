import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'card_details.dart'; // Import the Card Details Page

class CardListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      // AppBar(
      //   // title: Text('Card Types'),
      //   automaticallyImplyLeading: false, // Remove the back icon
      // ),
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
              stream: FirebaseFirestore.instance.collection('Cards').snapshots(),
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
                        subtitle: Text(cardData['description']),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CardDetailsPage(
                                cardName: cardData['name'],
                                cardDescription: cardData['description'],
                                cardApplication: cardData['application'],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
