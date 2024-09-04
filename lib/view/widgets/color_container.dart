import 'package:flutter/material.dart';

class ColorContainer extends StatelessWidget {
  final Color color;
  const ColorContainer({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(25)),
      width: 50,
      height: 50,
    );
  }
}
