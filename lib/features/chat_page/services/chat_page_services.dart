import 'package:chat_app/core/common/entities/message_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChatPageServices extends ChangeNotifier {
  // Instance of Firebase Auth and FireStore
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  TextEditingController messageController = TextEditingController();
  String? receiverId;
  String? senderProfilePicture;

  // METHOD TO SEND MESSAGE
  Future<void> _sendMessage(String receiverId, String message) async {
    // GET CURRENT USER INFO
    final String currentUserId = firebaseAuth.currentUser!.uid;
    final String currentUserEmail = firebaseAuth.currentUser!.email.toString();
    // GET THE CURRENT TIME
    final Timestamp timestamp = Timestamp.now();

    // CREATE A NEW MESSAGE
    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverId: receiverId,
      message: message,
      timestamp: timestamp,
    );

    //CONSTRUCT CHAT ROOM ID FROM CURRENT USER ID AND RECEIVER ID
    // (SORTED TO ENSURE UNIQUENESS)
    List<String> ids = [currentUserId, receiverId];
    ids.sort(); // SORT THE IDS (THIS ENSURES THAT THE CHAT ROOM ID IS ALWAYS THE SAME FOR ANY PAIR OF PEOPLE)
    String chatRoomId = ids
        .join("_"); // COMBINE THE IDS INTO A SINGLE STRING TO USE A CHATROOM ID

    // ADD NEW MESSAGES TO DATABASE
    await _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  // Handles the message sending
  Future<void> sendMessageController() async {
    if (messageController.text.isNotEmpty) {
      // Format the sent message to not have any spaces left
      final trimmedMessage = messageController.text.trim();
      await _sendMessage(receiverId!, trimmedMessage);

      // CLEAR THE CONTROLLER AFTER SENDING THE MESSAGE
      messageController.clear();
    }
  }

  // Get the current user profile picture
  Future<void> fetch(BuildContext context) async {
    try {
      final currentUser = firebaseAuth.currentUser;
      if (currentUser != null) {
        final uid = currentUser.uid;
        final DocumentSnapshot userDoc =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();
        if (userDoc.exists) {
          senderProfilePicture = userDoc.get('profile picture');
          notifyListeners();
        } else {
          // Handle the case where the document does not exist
          if (kDebugMode) {
            print("User document does not exist");
          }
        }
      }
    } catch (e) {
      // Handle errors here
      if (kDebugMode) {
        print("Error fetching user profile picture: $e");
      }
    }
  }

  // METHOD TO GET MESSAGES
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    // CONSTRUCT CHAT ROOM ID FROM THE USER ID (SORTED TO ENSURE IT MATCHES THE ID USED WHEN SENDING THE MESSAGE)
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
