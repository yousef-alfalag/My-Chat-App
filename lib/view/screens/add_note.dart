import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note/core/constant/colors.dart';
import 'package:note/services/services.dart';
import 'package:note/view/screens/home_screen.dart';
import 'package:note/view/widgets/color_container.dart';
import 'package:note/view/widgets/custom_button.dart';
import 'package:note/view/widgets/custom_textfeild.dart';

class AddNoteScreen extends StatelessWidget {
  const AddNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Services services = Services();
    TextEditingController titleCont = TextEditingController();
    TextEditingController contextCont = TextEditingController();
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    String? color;
    bool colorSelected = false;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Note'),
      ),
      body: Container(
        child: Column(
          children: [
            CustomTextFeild(
              controller: titleCont,
              hinttext: "Title",
            ),
            const SizedBox(
              height: 12,
            ),
            CustomTextFeild(
              controller: contextCont,
              hinttext: "Context",
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: colors.length,
                  itemBuilder: (context, index) {
                    // return Container(
                    //   width: 50,
                    //   height: 10,
                    //   color: Colors.amber,
                    // );
                    return InkWell(
                      onTap: () {
                        color = colors[index]["name"];
                      },
                      child: ColorContainer(
                        color: colors[index]["color"],
                      ),
                    );
                  }),
            ),
            CustomButton(
                onPressed: () async {
                  String userId = await firebaseAuth.currentUser!.uid;
                  services.addNote(
                      titleCont.text, contextCont.text, color, userId);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HomeScreen()));
                },
                buttonName: "Add Note"),
          ],
        ),
      ),
    );
  }
}
