import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class SenseCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color cardColor;
  final VoidCallback? onTap;
  final bool filled;
  final double? width;

  const SenseCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.cardColor,
    this.onTap,
    this.filled = false,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(18);

    final content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 6,
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
          child: Column(
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: filled ? cardColor : cardColor.withOpacity(0.18),
                ),
                alignment: Alignment.center,
                child: Icon(
                  icon,
                  size: 34,
                  color: filled ? Colors.white : cardColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF1D2630),
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF8C8C8C),
                      height: 1.1,
                    ),
              ),
            ],
          ),
        ),
      ],
    );

    return SizedBox(
      width: width ?? double.infinity,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: radius,
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: radius,
              boxShadow: const [
                BoxShadow(
                  color: Color(0x11000000),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: content,
          ),
        ),
      ),
    );
  }
}

