import 'package:flutter/material.dart';

class LinkText extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final String semanticLabel;
  final String semanticHint;

  const LinkText({
    super.key,
    required this.text,
    required this.onTap,
    required this.semanticLabel,
    required this.semanticHint,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticLabel,
      hint: semanticHint,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
