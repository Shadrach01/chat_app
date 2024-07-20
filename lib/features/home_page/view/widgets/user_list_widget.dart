// Each messages tile
import 'package:chat_app/core/widgets/pop_up_message.dart';
import 'package:chat_app/core/theme/app_pallet.dart';
import 'package:chat_app/core/widgets/text_widgets.dart';
import 'package:chat_app/features/chat_page/view/screen/chat_page.dart';
import 'package:chat_app/features/home_page/services/home_page_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class UsersListWidget extends StatelessWidget {
  const UsersListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final homePageService =
        Provider.of<HomePageServices>(context, listen: false);
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: homePageService.getUsersStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return toastInfo("There's an error, please try again shortly");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppPallet.gradientColor1,
            ),
          );
        }

        return ListView(
          children: snapshot.data!
              .map((data) => _buildUserListItem(context, data))
              .toList(),
        );
      },
    );
  }
}

Widget _buildUserListItem(BuildContext context, Map<String, dynamic> data) {
  if (data.isEmpty) {
    return const Text32Widgets(
      text: 'No users found',
    );
  }
  return GestureDetector(
    onTap: () {
      Get.toNamed(
        '/ChatPage',
        parameters: {
          'receiverFirstName': data['first name'],
          'receiverLastName': data['last name'],
          'receiverProfilePicture': data['profile picture'],
          'receiverUserId': data['uid'],
        },
      );
    },
    child: Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 25.w,
              backgroundImage: data['profile picture'] != null
                  ? NetworkImage(data['profile picture'])
                  : null,
              child: data['profile picture'] == null
                  ? const Icon(Icons.person)
                  : null,
            ),
            title: Text(
              '${data['first name']} ${data['last name']}',
            ),
          ),
          const Divider(
            thickness: .2,
            color: AppPallet.greyColor1,
          ),
        ],
      ),
    ),
  );
}
