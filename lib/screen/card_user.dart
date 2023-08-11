import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'card_choose.dart';

class UserCardsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          // User is not logged in
          return Center(
            child: Text('Please log in to view your cards.'),
          );
        }

        final user = snapshot.data;
        final userEmail = user.email;

        return Scaffold(
          // appBar: AppBar(
          //   title: Text('Your Cards'),
          // ),
          body: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Padding(
            padding: EdgeInsets.all(18.0),
            child: Text(
              'Your Card:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
              Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("User's Card Collection")
                      .where('email', isEqualTo: userEmail)
                      .snapshots(),
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

                    List<DocumentSnapshot> userCardDocs = snapshot.data.docs;

                    if (userCardDocs.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('No cards found.'),
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to the Choose Card page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChooseCardTypePage(),
                            ),
                          );
                        },
                        child: Text('Choose Card'),
                      ),
                    ],
                  ),
                );
              }

                    return ListView.builder(
                      itemCount: userCardDocs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> userCardData =
                            userCardDocs[index].data() as Map<String, dynamic>;

                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: ListTile(
                            title: Text('Card Type: ${userCardData['type']}'),
                            subtitle: Text('Email: ${userCardData['email']}'),
                            
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
           floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Implement your logic here to add value to the card
              // This will be executed when the button is pressed
            },
            child: Icon(Icons.attach_money_rounded),
            backgroundColor: Colors.teal, 
          ),
        );
      },
    );
  }
}
