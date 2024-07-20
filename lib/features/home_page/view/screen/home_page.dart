import 'package:chat_app/core/theme/app_pallet.dart';
import 'package:chat_app/core/widgets/app_drawer.dart';
import 'package:chat_app/features/home_page/view/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import '../widgets/user_list_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      drawer: const AppDrawer(),
      backgroundColor: AppPallet.backgroundColor,
      body: const UsersListWidget(),
    );
  }
}
