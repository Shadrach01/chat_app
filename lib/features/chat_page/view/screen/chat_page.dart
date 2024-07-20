import 'package:chat_app/features/chat_page/services/chat_page_services.dart';
import 'package:chat_app/features/chat_page/view/widgets/app_bar.dart';
import 'package:chat_app/features/chat_page/view/widgets/widgets.dart';
import 'package:chat_app/features/contact_page/view/screen/contact_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../profile_page/view/screen/profile_page.dart';

class ChatPage extends StatefulWidget {
  final String receiverFirstName;
  final String receiverLastName;
  final String receiverProfilePicture;
  final String receiverUserId;

  const ChatPage({
    super.key,
    required this.receiverFirstName,
    required this.receiverLastName,
    required this.receiverUserId,
    required this.receiverProfilePicture,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late ChatPageServices chatPageServices;

  String selectedTab = 'CHAT'; // Default selected tab

  @override
  void initState() {
    super.initState();
    chatPageServices = Provider.of<ChatPageServices>(context, listen: false);
    chatPageServices.fetch(context);
    chatPageServices.receiverId = widget.receiverUserId;
  }

  void onTabSelected(String tab) {
    setState(() {
      selectedTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        // floatHeaderSlivers: true,
        headerSliverBuilder: (context, isScrolled) {
          return [
            // Sliver App bar
            chatScreenAppBar(
              widget.receiverFirstName,
              widget.receiverLastName,
              widget.receiverProfilePicture,
              selectedTab,
              onTabSelected,
            ),
          ];
        },
        body: Consumer<ChatPageServices>(
          builder: (context, chatService, child) {
            return (selectedTab == 'CHAT')
                ? Column(
                    children: [
                      Expanded(
                          child: chatPageServices.senderProfilePicture == null
                              ? const Center(child: CircularProgressIndicator())
                              : MessageList(
                                  receiverId: widget.receiverUserId,
                                  currentUserId:
                                      chatService.firebaseAuth.currentUser!.uid,
                                  chatService: chatService,
                                  senderProfilePicture:
                                      chatPageServices.senderProfilePicture!,
                                  receiverProfilePicture:
                                      widget.receiverProfilePicture,
                                )),
                      SizedBox(height: 15.h),
                      MessageInput(
                        messageController: chatService.messageController,
                        onSendMessage: () async {
                          await chatService.sendMessageController();
                        },
                      ),
                    ],
                  )
                : (selectedTab == 'PROFILE')
                    ? const ProfilePage()
                    : const ContactPage();
          },
        ),
      ),
    );
  }
}
