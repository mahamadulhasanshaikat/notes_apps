import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:notes/view/forgot_screen.dart';
import 'package:notes/view/home_screen.dart';
import 'package:notes/view/regi_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<LoginScreen> {
  bool hidden = true;
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                // height: 300,
                child: Lottie.asset("assets/login.json"),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: loginEmailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                    prefixIcon: Icon(Icons.email_outlined),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.indigoAccent,
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
              Gap(10),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: loginPassController,
                  obscureText: hidden,
                  decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: Icon(Icons.lock_outline),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          hidden = !hidden;
                        });
                      },
                      child:
                          hidden
                              ? const Icon(
                                Icons.visibility_off_outlined,
                                color: Colors.indigoAccent,
                              )
                              : const Icon(
                                Icons.visibility_outlined,
                                color: Colors.indigoAccent,
                              ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.indigoAccent,
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),

              Gap(20),
              SizedBox(
                width: 350,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    var loginEmail = loginEmailController.text.trim();
                    var loginPass = loginPassController.text.trim();

                    try {
                      final User? firebaseUser =
                          (await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                email: loginEmail,
                                password: loginPass,
                              )).user;
                      if (firebaseUser != null) {
                        Get.to(() => HomeScreen());
                      }
                    } on FirebaseAuthException catch (e) {
                      log("Error $e");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigoAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text("Login", style: TextStyle(fontSize: 20)),
                ),
              ),
              Gap(15),
              InkWell(
                onTap: () {
                  Get.to(() => const ForgotScreen());
                },
                child: Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'Forget password',
                    style: TextStyle(
                      fontFamily: 'Regular',
                      color: Colors.indigoAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Gap(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(
                      fontFamily: 'Regular',
                      color: Colors.indigoAccent,
                    ),
                  ),
                  const SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      Get.to(() => const RegiScreen());
                      // showToast("Register Screen", Colors.redAccent);
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Regular',
                        color: Colors.indigoAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
