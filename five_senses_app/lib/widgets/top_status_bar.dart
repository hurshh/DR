import 'package:flutter/material.dart';

class TopStatusBar extends StatelessWidget {
  final String timeText;

  const TopStatusBar({
    super.key,
    required this.timeText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 12,
        top: MediaQuery.of(context).padding.top + 6,
      ),
      child: Row(
        children: [
          Text(
            timeText,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
          ),
          const Spacer(),
          Row(
            children: [
              const Icon(Icons.wifi, color: Colors.white70, size: 18),
              const SizedBox(width: 10),
              Container(
                width: 30,
                height: 14,
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

