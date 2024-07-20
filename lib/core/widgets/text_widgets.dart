import 'dart:ui';

import 'package:chat_app/core/theme/app_pallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogoTextWidget extends StatelessWidget {
  const LogoTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "Let's\n Chat",
      style: TextStyle(
        fontFamily: 'Gluten',
        fontSize: 50.sp,
        color: AppPallet.whiteColor,
        height: 0.h,
      ),
    );
  }
}

class HintTextStyle {
  static TextStyle style = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 15.sp,
    color: AppPallet.greyColor1,
  );
}

class Text10Widgets extends StatelessWidget {
  final String text;
  final TextDecoration? underlineText;
  const Text10Widgets({
    super.key,
    required this.text,
    this.underlineText,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 10.sp,
        fontWeight: FontWeight.bold,
        decoration: underlineText,
      ),
    );
  }
}

class Text18Widgets extends StatelessWidget {
  final String text;
  final Color color;
  final bool? softWrap;

  const Text18Widgets({
    super.key,
    required this.text,
    this.color = AppPallet.whiteColor,
    this.softWrap,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      softWrap: softWrap,
      text,
      style: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }
}

class Text32Widgets extends StatelessWidget {
  final String text;
  const Text32Widgets({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 32.sp,
      ),
    );
  }
}

class Text24Widgets extends StatelessWidget {
  final String text;
  const Text24Widgets({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
