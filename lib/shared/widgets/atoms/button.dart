import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const Button({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(text),
    );
  }
}
