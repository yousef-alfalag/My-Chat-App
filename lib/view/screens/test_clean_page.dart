import 'package:flutter/material.dart';
import 'package:note/main.dart';

class TestCleanScreen extends StatelessWidget {
  const TestCleanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            MaterialButton(
              onPressed: () {
                sharedPref.clear();
              },
              child: Text("Clean sharedpref"),
            )
          ],
        ),
      ),
    );
  }
}
