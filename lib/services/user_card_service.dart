import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserCardService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method to add a new user card document
  Future<void> addUserCard(String cardType) async {
    try {
      User currentUser = _auth.currentUser;
      if (currentUser != null) {
        await _firestore
            .collection('User\'s Card Collection')
            .doc(currentUser.uid)
            .set({
          'email': currentUser.email,
          'type': cardType,
        });
      }
    } catch (e) {
      print('Error adding user card: $e');
    }
  }
}
