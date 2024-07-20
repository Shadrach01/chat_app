import 'package:chat_app/core/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

AppBar appBar() {
  return AppBar(
    title: const Text18Widgets(text: 'Messages'),
    centerTitle: true,
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.search,
        ),
      ),
    ],
  );
}
