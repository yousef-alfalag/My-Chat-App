import 'package:flutter/material.dart';

class ViewNote extends StatelessWidget {
  final String title;
  final String noteContext;
  const ViewNote({super.key, required this.title, required this.noteContext});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My note'),
      ),
      body: Container(
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, color: Colors.black),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              noteContext,
              style: const TextStyle(
                  fontSize: 16, color: Color.fromARGB(255, 94, 94, 94)),
            )
          ],
        ),
      ),
    );
  }
}
