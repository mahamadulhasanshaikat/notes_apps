import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:notes/view/login_screen.dart';

RegiUser(String userName, String userEmail, String userPass) async {
  User? userId = FirebaseAuth.instance.currentUser;
  try {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(userId!.uid)
        .set({
          'userName': userName,
          'userEmail': userEmail,
          'createdAt': DateTime.now(),
          'userId': userId.uid,
        })
        .then(
          (value) => {
            FirebaseAuth.instance.signOut(),
            Get.to(() => LoginScreen()),
          },
        );
  } on FirebaseAuthException catch (e) {
    log("Error $e");
  }
}
