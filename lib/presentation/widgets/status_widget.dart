import 'package:flutter/material.dart';

Widget heartStatus(String status) {
  IconData icon;
  Color color;

  switch (status.toLowerCase()) {
    case "alive":
      icon = Icons.favorite;
      color = const Color.fromARGB(255, 223, 38, 25);
      break;

    case "dead":
      icon = Icons.heart_broken;
      color = Colors.black87;
      break;

    default:
      icon = Icons.help_outline;
      color = const Color.fromARGB(255, 114, 100, 100);
  }
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, color: color, size: 22),
      const SizedBox(width: 6),
      Text(
        status,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    ],
  );
}
