import 'package:chat_app/core/theme/app_pallet.dart';
import 'package:chat_app/core/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppPallet.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: Text32Widgets(
            text: "YOUR FRIEND CONTACT WILL BE DISPLAYED HERE",
          ),
        ),
      ),
    );
  }
}
