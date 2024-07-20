import 'package:chat_app/core/widgets/pop_up_message.dart';
import 'package:chat_app/core/theme/app_pallet.dart';
import 'package:chat_app/core/widgets/chat_bubble.dart';
import 'package:chat_app/core/widgets/my_text_field.dart';
import 'package:chat_app/core/widgets/text_widgets.dart';
import 'package:chat_app/features/chat_page/services/chat_page_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageList extends StatelessWidget {
  final String receiverId;
  final String currentUserId;
  final String senderProfilePicture;
  final String receiverProfilePicture;

  final ChatPageServices chatService;
  const MessageList({
    super.key,
    required this.receiverId,
    required this.currentUserId,
    required this.chatService,
    required this.senderProfilePicture,
    required this.receiverProfilePicture,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: chatService.getMessages(
        receiverId,
        currentUserId,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return toastInfo("Error ${snapshot.error}");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text24Widgets(text: 'Getting messages...');
        }

        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          return ListView(
            children: snapshot.data!.docs
                .map((document) => MessageItem(
                      document: document,
                      currentUserId: currentUserId,
                      senderProfilePicture: senderProfilePicture,
                      receiverProfilePicture: receiverProfilePicture,
                    ))
                .toList(),
          );
        } else {
          return const Center(
            child: Text18Widgets(text: "No messages yet"),
          );
        }
      },
    );
  }
}

class MessageItem extends StatelessWidget {
  final DocumentSnapshot document;
  final String currentUserId;
  final String senderProfilePicture;
  final String receiverProfilePicture;
  const MessageItem({
    super.key,
    required this.document,
    required this.currentUserId,
    required this.senderProfilePicture,
    required this.receiverProfilePicture,
  });

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    // Check if sender if the current user
    var isSender = (data['senderId'] == currentUserId);

    // Align the messages to the right if the sender is the current user,
    // Otherwise to the left
    var alignment = isSender ? Alignment.centerRight : Alignment.centerLeft;
    var margin = isSender
        ? EdgeInsets.fromLTRB(0, 0, 10.w, 0)
        : EdgeInsets.fromLTRB(10.w, 0, 0, 0);

    return Container(
      alignment: alignment,
      margin: margin,
      child: Row(
        mainAxisAlignment:
            isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (!isSender) ...[
            CircleAvatar(
              backgroundImage: NetworkImage(receiverProfilePicture),
              radius: 20.h,
            ),
            // SizedBox(width: 5.w),
          ],
          ChatBubble(
            message: data['message'],
            color: isSender ? AppPallet.appBarColor : AppPallet.lightGreen,
            isSender: isSender,
          ),
          if (isSender) ...[
            CircleAvatar(
              backgroundImage: NetworkImage(senderProfilePicture),
              radius: 20.h,
            ),
          ]
        ],
      ),
    );
  }
}

class MessageInput extends StatelessWidget {
  final TextEditingController messageController;
  final VoidCallback onSendMessage;
  const MessageInput({
    super.key,
    required this.messageController,
    required this.onSendMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 50.h,
              child: MyTextFields(
                controller: messageController,
                hintText: 'Enter Message',
              ),
            ),
          ),
          IconButton(
              onPressed: onSendMessage,
              icon: const Icon(
                Icons.arrow_upward,
                size: 20,
              ))
        ],
      ),
    );
  }
}
