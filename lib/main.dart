import 'dart:async';

import 'package:chat_app/core/network_connection/no_internet.dart';
import 'package:chat_app/core/theme/theme.dart';
import 'package:chat_app/features/auth/auth_gate.dart';
import 'package:chat_app/features/auth/register/services/register_service.dart';
import 'package:chat_app/features/auth/register/view/register_page.dart';
import 'package:chat_app/features/auth/sign_in/service/sign_in_services.dart';
import 'package:chat_app/features/auth/sign_in/view/login_page.dart';
import 'package:chat_app/features/chat_page/services/chat_page_services.dart';
import 'package:chat_app/features/home_page/view/screen/home_page.dart';
import 'package:chat_app/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'features/chat_page/view/screen/chat_page.dart';
import 'features/home_page/services/home_page_services.dart';

Future<void> main() async {
  await Global.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SignInServices()),
        ChangeNotifierProvider(create: (context) => RegisterServices()),
        ChangeNotifierProvider(create: (context) => HomePageServices()),
        ChangeNotifierProvider(create: (context) => ChatPageServices()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'First Method',
            // You can use the library anywhere in the app even in theme
            theme: AppTheme.darkThemeMode,
            home: const AuthGate(),
            initialRoute: '/',
            getPages: [
              GetPage(name: '/', page: () => const LoginPage()),
              GetPage(name: '/Register', page: () => const RegisterPage()),
              GetPage(name: '/HomePage', page: () => const HomePage()),
              GetPage(
                  name: '/ChatPage',
                  page: () => ChatPage(
                        receiverFirstName: Get.parameters['receiverFirstName']!,
                        receiverLastName: Get.parameters['receiverLastName']!,
                        receiverUserId: Get.parameters['receiverUserId']!,
                        receiverProfilePicture:
                            Get.parameters['receiverProfilePicture']!,
                      )),
              GetPage(
                  name: '/NoInternetPage', page: () => const NoInternetPage()),
            ],
          );
        });
  }
}
