import 'package:chat_app/core/network_connection/network_controller.dart';
import 'package:chat_app/core/secrets/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Global {
  static Future init() async {
    // ensure that all dependencies have been initialized
    WidgetsFlutterBinding.ensureInitialized();

    Get.put<NetworkController>(NetworkController(), permanent: true);

    // Initialize Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
