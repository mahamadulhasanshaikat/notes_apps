import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:notes/view/edit_note_screem.dart';
import 'package:notes/view/login_screen.dart';
import 'package:notes/view/note_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? userId = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes Apps", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Get.off(() => LoginScreen());
              log("LogOut user");
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Icon(Icons.logout_outlined, color: Colors.white),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream:
              FirebaseFirestore.instance
                  .collection("notes")
                  .where("userId", isEqualTo: userId?.uid)
                  .snapshots(),

          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("Somthing went wrong"));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CupertinoActivityIndicator());
            }
            if (snapshot.data!.docs.isEmpty) {
              return Center(child: Text("No Data Found!"));
            }
            if (snapshot.data != null) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var note = snapshot.data!.docs[index]['note'];
                  var noteId = snapshot.data!.docs[index]['userId'];
                  var docId = snapshot.data!.docs[index].id;
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      child: ListTile(
                        title: Text(note),
                        subtitle: Text(noteId),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                log(docId);
                                Get.to(
                                  () => EditNoteScreem(),
                                  arguments: {'note': note, 'docId': docId},
                                );
                              },
                              child: Icon(Icons.edit),
                            ),
                            Gap(10.0),
                            GestureDetector(
                              onTap: () async {
                                await FirebaseFirestore.instance
                                    .collection("notes")
                                    .doc(docId)
                                    .delete();
                              },
                              child: Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }

            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Get.to(() => NoteScreen());
        },
        child: Icon(Icons.add, color: Colors.indigoAccent),
      ),
    );
  }
}
