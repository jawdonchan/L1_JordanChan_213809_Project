import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proj_layout/services/user_card_service.dart';

class UpdateCardPage extends StatefulWidget {
  @override
  _UpdateCardPageState createState() => _UpdateCardPageState();
}

class _UpdateCardPageState extends State<UpdateCardPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController _expiryDateController = TextEditingController();
  bool _loading = false;
  String selectedCardName;
  List<DocumentSnapshot> cardDocs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Update Card Information',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Expiry Date',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _expiryDateController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.all(15),
                  hintText: 'Enter Expiry Date',
                ),
              ),
            ),
            SizedBox(height: 10),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                   Text(
                    'Change Card Type',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
            StreamBuilder<QuerySnapshot>(
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

                      cardDocs = snapshot.data.docs;
                      List<String> cardNames = cardDocs
                          .map((cardData) => cardData.data()['name'] as String)
                          .toList();

                      return Column(
                        children: [
                          DropdownButton<String>(
                            value: selectedCardName,
                            hint: Text('Select a card'),
                            onChanged: (newValue) {
                              setState(() {
                                selectedCardName = newValue;
                              });
                            },
                            items: cardNames.map((cardName) {
                              return DropdownMenuItem<String>(
                                value: cardName,
                                child: Text(cardName),
                              );
                            }).toList(),
                          ),
                          if (selectedCardName != null)
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text('Selected Card: $selectedCardName'),
                                    // Add more card details here
                                  ],
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
               ],
             ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loading ? null : _updateCardDetails,
              child: Text('Update Card'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateCardDetails() async {
    setState(() {
      _loading = true;
    });

    try {
      final User user = _auth.currentUser;

      if (user != null) {
        final String userId = user.uid;

        final DocumentReference userRef =
            _firestore.collection("User's Card Collection").doc(userId);

        Map<String, dynamic> updateData = {};

        if (_expiryDateController.text.isNotEmpty) {
          updateData['expiryDate'] = _expiryDateController.text;
        }

        if (selectedCardName != null) {
          updateData['type'] = selectedCardName;
        }

        if (updateData.isNotEmpty) {
          await userRef.update(updateData);
        }

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Success'),
            content: Text('Card information updated.'),
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
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('An error occurred while updating card information.'),
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
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }
}
