import 'package:chat_app/core/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.signal_wifi_connected_no_internet_4,
                size: 40.h,
              ),
              const Text10Widgets(text: "No Internet connection"),
              const Text18Widgets(text: "Please check you internet"),
              SizedBox(height: 15.h),
            ],
          ),
        ),
      ),
    );
  }
}
