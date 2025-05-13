import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/view/home_screen.dart';
import 'package:notes/view/login_screen.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    // final auth = FirebaseAuth.instance;
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Timer(
        const Duration(seconds: 4),
        () => Get.offAll(() => const HomeScreen()),
      );
    } else {
      Timer(
        const Duration(seconds: 4),
        () => Get.offAll(() => const LoginScreen()),
      );
    }
  }
}
