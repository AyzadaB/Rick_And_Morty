import 'package:flutter/material.dart';

Widget genderStatus(String gender) {
  IconData icon;
  Color color;

  switch (gender.toLowerCase()) {
    case "male":
      icon = Icons.male;
      color = const Color.fromARGB(255, 35, 44, 211);
      break;

    case "female":
      icon = Icons.female;
      color = const Color.fromARGB(221, 111, 6, 163);
      break;

    default:
      icon = Icons.question_mark;
      color = const Color.fromARGB(255, 114, 100, 100);
  }
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, color: color, size: 27),
      const SizedBox(width: 6),
      Text(
        gender,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    ],
  );
}
