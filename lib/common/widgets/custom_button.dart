import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final Color? color;
  const CustomButton(
      {super.key,
      required this.buttonText,
      required this.onPressed,
      this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50), backgroundColor: color),
      child: Text(
        buttonText,
        style: TextStyle(color: color == null ? Colors.white : Colors.black),
      ),
    );
  }
}
