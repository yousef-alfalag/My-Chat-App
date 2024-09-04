import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note/services/services.dart';
import 'package:note/view/screens/home_screen.dart';
import 'package:note/view/widgets/custom_button.dart';
import 'package:note/view/widgets/custom_textfeild.dart';

class EditNoteScreen extends StatelessWidget {
  final noteId;
  const EditNoteScreen({super.key, required this.noteId});

  @override
  Widget build(BuildContext context) {
    Services services = Services();
    TextEditingController titleCont = TextEditingController();
    TextEditingController contextCont = TextEditingController();
    String userId = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
        appBar: AppBar(
          title: const Text('SAVE'),
        ),
        body: Container(
          child: Column(
            children: [
              CustomTextFeild(
                controller: titleCont,
                hinttext: "Title",
              ),
              CustomTextFeild(
                controller: contextCont,
                hinttext: "Context",
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                onPressed: () {
                  services.updateNote(
                      userId, noteId, titleCont.text, contextCont.text);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const HomeScreen()));
                },
                buttonName: "Add Note",
              )
            ],
          ),
        ));
  }
}
