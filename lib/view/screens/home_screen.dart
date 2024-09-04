import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note/core/constant/colors.dart';
import 'package:note/main.dart';
import 'package:note/services/services.dart';
import 'package:note/view/screens/add_note.dart';
import 'package:note/view/screens/auth/login.dart';
import 'package:note/view/screens/edit_note.dart';
import 'package:note/view/screens/view_note.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List data = [];
  Services services = Services();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Color? color;
  getData() async {
    try {
      String userId = await firebaseAuth.currentUser!.uid;
      data = await services.getNote(userId);
      setState(() {});
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  logout() async {
    try {
      //services.logout();
      // InitialServices().sharedPreferences.setBool("islogin", false);
      // InitialServices().islogin = false;
      sharedPref.clear();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false);
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.deepPurple),
          // margin: const EdgeInsets.only(
          //   top: 25,
          // ),
          child: const Icon(
            Icons.notes_outlined,
            color: Color.fromARGB(255, 247, 247, 247),
            size: 40,
            shadows: [Shadow(color: Colors.black)],
          ),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await logout();
              },
              icon: const Icon(Icons.logout_outlined))
        ],
        title: const Text('My Note'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            //color = Colors.white;
            colors.forEach((element) {
              if (element["name"] == data[index]["color"]) {
                color = element["color"];
              }
            });
            return InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ViewNote(
                        title: data[index]["name"],
                        noteContext: data[index]["contact"],
                      ))),
              child: Card(
                color: color,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${data[index]["name"]}",
                          ),
                          Text(
                            "${data[index]["contact"]}",
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      EditNoteScreen(noteId: data[index].id)));
                            },
                            icon: Icon(Icons.note_alt_outlined)),
                        IconButton(
                          onPressed: () {
                            services.deleteData(
                                data[index].userid, data[index].id);
                          },
                          icon: const Icon(Icons.delete),
                          color: Colors.redAccent[400],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
            color: Colors.deepPurple, borderRadius: BorderRadius.circular(21)),
        child: IconButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AddNoteScreen()));
          },
          icon: const Icon(Icons.add),
          color: Colors.white,
        ),
      ),
    );
  }
}
