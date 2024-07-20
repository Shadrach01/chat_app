import 'package:chat_app/core/theme/app_pallet.dart';
import 'package:chat_app/core/widgets/text_widgets.dart';
import 'package:chat_app/features/auth/auth_gate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  Future<void> signOut() async {
    Get.offAll(
      () => const AuthGate(),
      transition: Transition.zoom,
      duration: const Duration(milliseconds: 500),
    );
    return await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400.h,
      child: Drawer(
        backgroundColor: AppPallet.lightGreen,
        width: 270.w,
        child: Column(
          children: [
            const DrawerHeader(
              child: Center(
                child: LogoTextWidget(),
              ),
            ),
            SizedBox(height: 50.h),
            GestureDetector(
              onTap: signOut,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.logout),
                  SizedBox(width: 20.w),
                  const Text18Widgets(text: "S I G N O U T "),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
