import 'dart:io';

import 'package:chat_app/core/theme/app_pallet.dart';
import 'package:chat_app/core/widgets/my_text_field.dart';
import 'package:chat_app/core/widgets/text_widgets.dart';
import 'package:chat_app/features/auth/register/services/register_service.dart';
import 'package:chat_app/features/auth/sign_in/view/login_page.dart';
import 'package:chat_app/features/auth/widgets/auth_button.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../widgets/auth_text_fields.dart';

// S I G N U P  P A G E

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late RegisterServices _controller;

  @override
  void initState() {
    _controller = Provider.of<RegisterServices>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallet.backgroundColor,
      body: Padding(
        padding: EdgeInsets.all(15.h),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50.h),
              Consumer<RegisterServices>(builder: (context, controller, child) {
                return Stack(
                  children: [
                    controller.image == null
                        ? CircleAvatar(
                            radius: 64.w,
                            child: const Icon(
                              Icons.person,
                              size: 85,
                            ),
                          )
                        : ClipOval(
                            child: Image.file(
                              File(controller.image!.path),
                              fit: BoxFit.cover,
                              width: 128.w,
                              height: 128.h,
                            ),
                          ),
                    Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: controller.selectImage,
                        icon: const Icon(Icons.add_a_photo),
                      ),
                    ),
                  ],
                );
              }),
              SizedBox(height: 20.h),
              AuthTextFields(
                hintText: 'Email',
                controller: _controller.emailController,
              ),
              SizedBox(height: 20.h),
              MyTextFields(
                hintText: 'First Name',
                controller: _controller.firstNameController,
              ),
              SizedBox(height: 20.h),
              MyTextFields(
                hintText: 'Last Name',
                controller: _controller.lastNameController,
              ),
              SizedBox(height: 20.h),
              MyTextFields(
                hintText: 'Password',
                controller: _controller.passwordController,
                obscureText: true,
              ),
              SizedBox(height: 20.h),
              MyTextFields(
                hintText: 'Confirm Password',
                controller: _controller.confirmPasswordController,
                obscureText: true,
              ),
              SizedBox(height: 25.h),
              Consumer<RegisterServices>(
                builder: (context, registerServices, child) {
                  return registerServices.isLoading
                      ? const Text18Widgets(
                          text: "Please wait while we sign you in")
                      : AuthButton(
                          onPressed: _controller.handleRegister,
                          text: 'S I G N  U P',
                        );
                },
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text10Widgets(
                    text: "Already have an account? ",
                  ),
                  SizedBox(width: 10.w),
                  GestureDetector(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const LoginPage())),
                    child: const Text10Widgets(
                      text: "Go to Login",
                      underlineText: TextDecoration.underline,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
