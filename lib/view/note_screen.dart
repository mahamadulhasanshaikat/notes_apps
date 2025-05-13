import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:notes/view/home_screen.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  TextEditingController noteController = TextEditingController();

  User? userId = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Note", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: noteController,
                  maxLines: null,
                  decoration: InputDecoration(hintText: "Add Note"),
                ),
              ),
              Gap(15),
              ElevatedButton(
                onPressed: () async {
                  var note = noteController.text.trim();
                  if (note != "") {
                    try {
                      await FirebaseFirestore.instance
                          .collection("notes")
                          .doc()
                          .set({
                            'createdAt': DateTime.now(),
                            'note': note,
                            'userId': userId?.uid,
                          })
                          .then(
                            (value) => {
                              Get.offAll(() => HomeScreen()),
                              log("Data Update"),
                            },
                          );
                    } on FirebaseException catch (e) {
                      log("Error $e");
                    }
                  } else {}
                },
                child: Text("Add Note"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
