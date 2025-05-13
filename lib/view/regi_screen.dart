import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:notes/services/regi_service.dart';
import 'package:notes/view/login_screen.dart';

class RegiScreen extends StatefulWidget {
  const RegiScreen({super.key});

  @override
  State<RegiScreen> createState() => _RegiScreenState();
}

class _RegiScreenState extends State<RegiScreen> {
  bool hidden = true;
  TextEditingController userNameController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();

  User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: Get.height / 4,
                width: Get.width,
                child: Lottie.asset("assets/reg.json"),
              ),

              Text("Registration From", style: TextStyle(fontSize: 25)),
              Gap(20),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: userNameController,
                  decoration: InputDecoration(
                    hintText: "Name",
                    prefixIcon: Icon(Icons.person_2_outlined),
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
                  controller: userEmailController,
                  decoration: InputDecoration(
                    hintText: "Eamil",
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
                  controller: userPasswordController,
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
                    var userName = userNameController.text.trim();
                    var userEmail = userEmailController.text.trim();
                    var userPass = userPasswordController.text.trim();

                    await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                          email: userEmail,
                          password: userPass,
                        )
                        .then(
                          (value) => {
                            log("User Create"),
                            RegiUser(userName, userEmail, userPass),
                          },
                        );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigoAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text("Registration", style: TextStyle(fontSize: 20)),
                ),
              ),

              Gap(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(
                      fontFamily: 'Regular',
                      color: Colors.indigoAccent,
                    ),
                  ),
                  const SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      Get.to(() => const LoginScreen());
                      // showToast("Register Screen", Colors.redAccent);
                    },
                    child: const Text(
                      'Login',
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
