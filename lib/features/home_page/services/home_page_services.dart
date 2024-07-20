import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class HomePageServices extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return FirebaseFirestore.instance.collection('users').snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => doc.data())
            .where((data) => data['email'] != _auth.currentUser!.email)
            .toList());
  }
}
