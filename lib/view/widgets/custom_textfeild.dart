import 'package:flutter/material.dart';

class CustomTextFeild extends StatelessWidget {
  final TextEditingController controller;
  final String hinttext;
  const CustomTextFeild(
      {super.key, required this.controller, required this.hinttext});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 22, vertical: 13),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 12),
            hintText: hinttext,
            focusColor: Colors.amberAccent,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(23),
                borderSide: const BorderSide(color: Colors.yellowAccent))),
      ),
    );
  }
}
