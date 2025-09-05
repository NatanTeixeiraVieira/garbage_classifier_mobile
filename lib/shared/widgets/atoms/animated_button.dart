import 'package:flutter/material.dart';
import 'package:garbage_classifier_mobile/shared/widgets/atoms/button.dart';

class AnimatedButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final AnimationController animationController;

  const AnimatedButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: text,
      hint: "Clique para $text",
      child: GestureDetector(
        onTap: onPressed,
        child: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            double scale = 1 - animationController.value;
            return Transform.scale(scale: scale, child: child);
          },
          child: Button(
            icon: icon,
            onPressed: onPressed,
            text: text,
          ),
        ),
      ),
    );
  }
}
