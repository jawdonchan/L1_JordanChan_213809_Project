import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:proj_layout/services/firebaseauth_service.dart';

class RewardsPage extends StatefulWidget {
  @override
  _RewardsPageState createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage> {
  TextEditingController _promoCodeController = TextEditingController();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
 String getCurrentUserEmail() {
  final user = _auth.currentUser;
  return user != null ? user.email : null;
}
  bool _isValidPromoCode = false;
  String _promoCodeResult = '';

  Future<void> _checkPromoCode() async {
    final String inputCode = _promoCodeController.text.trim();

    Query rewardsQuery = _firestore
        .collection('Rewards')
        .where('promoCode', isEqualTo: inputCode);

    QuerySnapshot rewardsSnapshot = await rewardsQuery.get();

    if (rewardsSnapshot.docs.isNotEmpty) {
      DocumentSnapshot rewardsDoc = rewardsSnapshot.docs.first;

      String rewardValue = rewardsDoc.data()['value'];
      int rewardamt = int.parse(rewardValue);
      setState(() {
        _isValidPromoCode = true;
        _promoCodeResult =
            'Promo code applied successfully!\nYou have received \$$rewardValue reward.';
      });

      // Update user's card collection based on reward value
      await _updateUserCardCollection(getCurrentUserEmail(),rewardamt);
    } else {
      setState(() {
        _isValidPromoCode = false;
        _promoCodeResult = 'Invalid promo code.\nPlease try again.';
      });
    }
  }

 Future<void> _updateUserCardCollection(String userEmail, int rewardValue) async {
  QuerySnapshot userSnapshot = await _firestore
      .collection("User's Card Collection")
      .where('email', isEqualTo: userEmail)
      .get();

  if (userSnapshot.docs.isNotEmpty) {
    DocumentSnapshot userDoc = userSnapshot.docs.first;
    double userCards = userDoc.data()['value'] ?? 0;

    DocumentReference userRef =
        _firestore.collection("User's Card Collection").doc(userDoc.id);
    userRef.update({'value': userCards + rewardValue});
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Rewards Page',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _promoCodeController,
                decoration: InputDecoration(
                  labelText: 'Enter Promo Code',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  _checkPromoCode();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal, // Set the background color here
                ),
                child: Text('Apply Promo Code'),
              ),
              SizedBox(height: 20.0),
              Text(
                _promoCodeResult,
                style: TextStyle(
                  color: _isValidPromoCode ? Colors.green : Colors.red,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
