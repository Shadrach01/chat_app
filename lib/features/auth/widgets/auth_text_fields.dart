import 'package:chat_app/core/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthTextFields extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;

  const AuthTextFields({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: HintTextStyle.style,
          contentPadding: EdgeInsets.symmetric(
            vertical: 25.w,
            horizontal: 25.h,
          ),
        ),
        controller: controller,
        obscureText: obscureText,
      ),
    );
  }
}
