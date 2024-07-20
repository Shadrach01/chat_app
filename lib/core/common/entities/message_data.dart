import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  // GET THE SENDER DETAILS
  final String senderId;
  final String senderEmail;

  // GET THE RECEIVER DETAILS, MESSAGE AND TIMESTAMP
  final String receiverId;
  final String message;
  final Timestamp timestamp;

  Message({
    required this.senderId,
    required this.senderEmail,
    required this.receiverId,
    required this.message,
    required this.timestamp,
  });

  // CONVERT TO MAP
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
