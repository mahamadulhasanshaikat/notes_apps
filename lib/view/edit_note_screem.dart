import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/route_manager.dart';
import 'package:notes/view/home_screen.dart';

class EditNoteScreem extends StatefulWidget {
  const EditNoteScreem({super.key});

  @override
  State<EditNoteScreem> createState() => _EditNoteScreemState();
}

class _EditNoteScreemState extends State<EditNoteScreem> {
  TextEditingController noteUpdateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Note", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller:
                    noteUpdateController
                      ..text = Get.arguments['note'].toString(),
              ),
            ),
            Gap(15),
            ElevatedButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection("notes")
                    .doc(Get.arguments['docId'].toString())
                    .update({'note': noteUpdateController.text.trim()})
                    .then(
                      (value) => {
                        Get.offAll(() => HomeScreen()),
                        log("Data Update"),
                      },
                    );
              },
              child: Text("Update"),
            ),
          ],
        ),
      ),
    );
  }
}
