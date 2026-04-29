import 'package:flutter/material.dart';

class QuizOptionCard extends StatelessWidget {
  final String letter;
  final String text;
  final bool selected;
  final bool correct;
  final VoidCallback? onTap;

  const QuizOptionCard({
    super.key,
    required this.letter,
    required this.text,
    this.selected = false,
    this.correct = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(14);
    final bg = selected
        ? (correct ? const Color(0xFF45E6C1) : const Color(0xFFEBEBEB))
        : Colors.white;
    final border = selected ? Colors.transparent : const Color(0xFFEAEAEA);

    return InkWell(
      borderRadius: radius,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: radius,
          border: Border.all(color: border),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 0,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: selected
                    ? (correct ? const Color(0xFF45E6C1) : const Color(0xFFD0D0D0))
                    : const Color(0xFFF0F0F0),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                letter,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: selected ? Colors.white : const Color(0xFF6B6B6B),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                text,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF2D2D2D),
                    ),
              ),
            ),
            if (selected && correct) ...[
              const SizedBox(width: 8),
              Icon(Icons.check_rounded, color: Colors.white, size: 22),
            ],
          ],
        ),
      ),
    );
  }
}

