import 'package:chat_app/core/theme/app_pallet.dart';
import 'package:chat_app/core/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

SliverAppBar chatScreenAppBar(
  String firstName,
  String lastName,
  String profilePicture,
  String selectedTab,
  Function(String) onTabSelected,
) {
  return SliverAppBar(
    leading: IconButton(
      onPressed: () {},
      icon: const Icon(
        Icons.menu,
      ),
    ),
    snap: true,
    title: Text18Widgets(text: '$firstName $lastName'),
    centerTitle: true,
    expandedHeight: 180,
    floating: true,
    pinned: true,
    flexibleSpace: FlexibleSpaceBar(
      collapseMode: CollapseMode.parallax,
      background: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(profilePicture),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: 24.0.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  onTabSelected('PROFILE');
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 6.w, horizontal: 16.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: selectedTab == 'PROFILE'
                        ? AppPallet.backgroundColor
                        : AppPallet.transparentColor,
                  ),
                  child: const Text10Widgets(text: 'PROFILE'),
                ),
              ),
              SizedBox(width: 40.h),
              InkWell(
                onTap: () {
                  onTabSelected('CONTACT');
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 6.w, horizontal: 16.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: selectedTab == 'CONTACT'
                        ? AppPallet.backgroundColor
                        : AppPallet.transparentColor,
                  ),
                  child: const Text10Widgets(text: 'CONTACT'),
                ),
              ),
              SizedBox(width: 40.h),
              InkWell(
                onTap: () {
                  onTabSelected('CHAT');
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 6.w, horizontal: 16.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: selectedTab == 'CHAT'
                        ? AppPallet.backgroundColor
                        : AppPallet.transparentColor,
                  ),
                  child: const Text10Widgets(text: 'CHAT'),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
