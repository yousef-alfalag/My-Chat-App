import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note/core/constant/colors.dart';
import 'package:note/services/services.dart';
import 'package:note/view/screens/home_screen.dart';

class AddNoteController extends ChangeNotifier {
  Services services = Services();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String? color;
  bool colorSelected = false;
  changeColor(index) {
    colorSelected = !colorSelected;
    color = colorSelected ? colors[index]["name"] : null;
    notifyListeners();
  }

  addNote(String title, String context) async {
    String userId = await firebaseAuth.currentUser!.uid;
    services.addNote(title, context, color, userId);
    Navigator.of(context as BuildContext).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false);
  }
}
