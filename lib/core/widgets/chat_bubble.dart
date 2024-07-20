import 'package:chat_app/core/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final Color? color;
  final bool isSender;
  const ChatBubble({
    super.key,
    required this.message,
    this.color,
    required this.isSender,
  });

  @override
  Widget build(BuildContext context) {
    var margin = isSender
        ? EdgeInsets.fromLTRB(20.w, 5.h, 7.w, 10.h)
        : EdgeInsets.fromLTRB(7.w, 5.h, 20.w, 10.h);

    return Container(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8.w),
      margin: margin,
      padding: EdgeInsets.all(12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.w),
        color: color,
      ),
      child: Text18Widgets(
        text: message,
        softWrap: true,
      ),
    );
  }
}
