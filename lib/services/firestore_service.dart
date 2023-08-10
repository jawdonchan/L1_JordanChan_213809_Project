import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<String>> fetchCardTypes() async {
  DocumentSnapshot snapshot =
      await FirebaseFirestore.instance.collection('Cards').doc('Types').get();

  if (snapshot.exists) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    List<String> cardTypes = data.keys.toList();
    return cardTypes;
  } else {
    return [];
  }
}
