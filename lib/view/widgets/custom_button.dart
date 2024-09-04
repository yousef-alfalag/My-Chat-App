import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key, required this.onPressed, required this.buttonName});
  final void Function()? onPressed;
  final String buttonName;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
          color: Colors.deepPurple, borderRadius: BorderRadius.circular(18)),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          buttonName,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
