import 'package:flutter/material.dart';

class StepProgress extends StatelessWidget {
  final int totalSteps;
  final int currentStep; // 1-based
  final Color activeColor;
  final Color inactiveColor;
  final double height;

  const StepProgress({
    super.key,
    required this.totalSteps,
    required this.currentStep,
    required this.activeColor,
    required this.inactiveColor,
    this.height = 10,
  });

  @override
  Widget build(BuildContext context) {
    final segments = List.generate(totalSteps, (i) => i + 1);
    return SizedBox(
      height: height,
      child: Row(
        children: segments.map((s) {
          final isActive = s <= currentStep;
          return Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 1),
              decoration: BoxDecoration(
                color: isActive ? activeColor : inactiveColor,
                borderRadius: BorderRadius.circular(height / 2),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

