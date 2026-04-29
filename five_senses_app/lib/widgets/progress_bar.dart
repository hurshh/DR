import 'package:flutter/material.dart';

class LinearProgressBar extends StatelessWidget {
  final double progress; // 0..1
  final Color activeColor;
  final Color inactiveColor;
  final double height;

  const LinearProgressBar({
    super.key,
    required this.progress,
    required this.activeColor,
    required this.inactiveColor,
    this.height = 10,
  });

  @override
  Widget build(BuildContext context) {
    final p = progress.clamp(0.0, 1.0);

    return ClipRRect(
      borderRadius: BorderRadius.circular(height / 2),
      child: Container(
        height: height,
        color: inactiveColor,
        child: FractionallySizedBox(
          alignment: Alignment.centerLeft,
          widthFactor: p,
          child: Container(color: activeColor),
        ),
      ),
    );
  }
}

