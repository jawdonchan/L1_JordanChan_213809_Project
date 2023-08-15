import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'card_update.dart';
import 'topup.dart';
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
        final userId = user.uid;
        final userEmail = user.email;

        return Scaffold(
          // appBar: AppBar(
          //   title: Text('Your Cards'),
          // ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(15.0),
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
                               style: ElevatedButton.styleFrom(
                              primary: Colors.teal, // Set the background color here
                              ),
                              child: Text('Choose Card', 
                             ),
                              
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

                        String expiryDate = userCardData['expiryDate'];
          if (expiryDate == null) {
            expiryDate = 'Not Set';
          }
                        return Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1.0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    title: Text(
                                        'Concession Card'),
                                    subtitle:
                                        Text('Email: ${userCardData['email']}'),
                                  ),
                                  Divider(), // Add a divider line
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(8,0,8,0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            'Card Type: ${userCardData['type']}'),
                                        Text(
                                            'Balance:'), // Display the balance here
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 6,),
                                  Padding(
                                   padding: const EdgeInsets.fromLTRB(8,0,12,0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                         // Replace with actual row content
                                        Text(
                                            'Find My Line', 
                                            style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),),
                                            Text(
                                            '\$${userCardData['value']}',
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                      ],
                                    ),
                                  ),
                                 SizedBox(height: 6,),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(8,0,8,10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                         Text('Expiry Date: $expiryDate'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Navigate to UpdateCardPage and pass the user ID and email
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdateCardPage(
                                    
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                              primary: Colors.teal, // Set the background color here
                              ),
                              child: Text('Update Card', 
                             ),
                            ),

                          ],
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
              // Navigate to the Add Value page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddValuePage(userEmail: userEmail),
                ),
              );
            },
            child: Icon(Icons.attach_money_rounded),
            backgroundColor: Colors.teal,
          ),
        );
      },
    );
  }
}
