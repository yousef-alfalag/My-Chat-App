import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:note/core/functions/check_internet.dart';
import 'package:note/data/models/note_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Services {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  List<QueryDocumentSnapshot> data = [];
  QuerySnapshot? _querySnapshot;
  late Note newNote;

  CollectionReference note = FirebaseFirestore.instance.collection("note");
  // check internet
  Future checkInternet = checksInternet();
// sqlite configuratoin
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initalDb();
      return _db;
    } else {
      return _db;
    }
  }

  initalDb() async {
    String dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, "notes.db");
    Database myDB = await openDatabase(path,
        onCreate: _onCreate, version: 3, onUpgrade: _onUpgrade);
    return myDB;
  }

  _onCreate(Database db, int vertion) async {
    await db.execute('''
CREATE TABLE "notes" (
note_id INTEGER AUTOINCREMENT NOT NUTT PRIMARY KEY ,
note_title TEXT NOT NULL ,
note_context TEXT NOT NULL
)
''');
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) {
    db.execute('''
ALTER TABLE notes 
ADD user_Id TEXT 
''');
  }

// firebase & sqlite CRUD
  getNote(String? userId) async {
    if (await checkInternet) {
      //online
      _querySnapshot = await note.doc(userId).collection("note").get();
      data.addAll(_querySnapshot!.docs);
      return data;
    } else {
      //locale
      Database? mydb = await db;
      List<Map> response = await mydb!.rawQuery("SELECT * FROM 'notes'");
      return response;
    }
  }

  addNote(String title, String context, String? color, String userId) async {
    newNote =
        Note(userId: userId, title: title, contact: context, color: color);
    if (await checkInternet) {
      try {
        DocumentReference response =
            await note.doc(userId).collection("note").add(newNote.toMap());
        if (kDebugMode) {
          print("success");
        }
      } catch (e) {
        print("error $e");
      }
    } else {
      Database? mydb = await db;
      int response = await mydb!.rawInsert(
          "INSERT INTO 'NOTES' (note_title , note_context,color,user_Id) VALUES ($title,$context,$color,$userId)");
      return response;
    }
  }

  deleteData(userId, id) async {
    if (await checkInternet) {
      await note.doc(userId).collection("note").doc(id).delete();
    } else {
      Database? mydb = await db;
      int response =
          await mydb!.rawDelete("DELETE FROM 'NOTES' WHERE note_id = $id");
      return response;
    }
  }

  updateNote(userId, id, String title, String context) async {
    if (await checkInternet) {
      note
          .doc(userId)
          .collection("note")
          .doc(id)
          .update({"title": title, "context": context});
    } else {
      Database? mydb = await db;
      int response = await mydb!.rawUpdate(
          "UPDATE 'NOTES' SET 'note_title' = $title , 'note_context' = $context WHERE note_id = $id");
      return response;
    }
  }

  //Authentication
  Future singUp(String email, password) async {
    await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future login(String email, password) async {
    await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future logout() async {
    await firebaseAuth.signOut();
  }
}
