import 'package:chat_app/core/theme/app_pallet.dart';
import 'package:chat_app/core/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// A U T H  B U T T O N
class AuthButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  const AuthButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppPallet.lightGreen,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 65.h,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          fixedSize: Size(395.w, 55.h),
          backgroundColor: AppPallet.transparentColor,
          shadowColor: AppPallet.transparentColor,
        ),
        child: Text18Widgets(text: text),
      ),
    );
  }
}
