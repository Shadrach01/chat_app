import 'package:chat_app/core/theme/app_pallet.dart';
import 'package:chat_app/core/widgets/my_text_field.dart';
import 'package:chat_app/core/network_connection/no_internet.dart';
import 'package:chat_app/core/widgets/text_widgets.dart';
import 'package:chat_app/features/auth/register/view/register_page.dart';
import 'package:chat_app/features/auth/sign_in/service/sign_in_services.dart';
import 'package:chat_app/features/auth/widgets/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// L O G I N  P A G E

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late SignInServices _controller;
  @override
  void initState() {
    super.initState();
    _controller = Provider.of<SignInServices>(context, listen: false);
    _controller.initConnectivity();
    _controller.initConnectivitySubscription();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignInServices>(
      builder: (context, signInServices, child) {
        return Scaffold(
          backgroundColor: AppPallet.backgroundColor,
          body: Padding(
            padding: EdgeInsets.all(15.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const LogoTextWidget(),
                SizedBox(height: 50.h),
                MyTextFields(
                  hintText: 'Email',
                  controller: _controller.emailController,
                ),
                SizedBox(height: 20.h),
                MyTextFields(
                  hintText: 'Password',
                  controller: _controller.passwordController,
                  obscureText: true,
                ),
                SizedBox(height: 30.h),
                Consumer<SignInServices>(
                  builder: (context, signInServices, child) {
                    return signInServices.isLoading
                        ? const Center(
                            child: Text18Widgets(text: "Please wait"))
                        : AuthButton(
                            onPressed: () => _controller.handleLogIn(),
                            text: 'L O G I N',
                          );
                  },
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text10Widgets(
                      text: "Don't have an account? ",
                    ),
                    SizedBox(width: 10.w),
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const RegisterPage())),
                      child: const Text10Widgets(
                        text: "Sign up here",
                        underlineText: TextDecoration.underline,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
