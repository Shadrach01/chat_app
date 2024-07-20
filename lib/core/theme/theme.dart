import 'package:chat_app/core/theme/app_pallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static _border([Color color = AppPallet.borderColor]) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 3.w,
        ),
        borderRadius: BorderRadius.circular(
          15.w,
        ),
      );

  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallet.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPallet.appBarColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(27.h),
      border: _border(),
      enabledBorder: _border(),
      focusedBorder: _border(AppPallet.gradientColor1),
      errorBorder: _border(AppPallet.errorColor),
    ),
  );
}
