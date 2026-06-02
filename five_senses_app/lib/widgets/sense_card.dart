import 'package:flutter/material.dart';

/// A tappable sense card whose icon, text and padding all scale
/// with the [iconContainerSize] passed in by the parent.
/// The parent (not this widget) is responsible for sizing decisions
/// so that IntrinsicHeight can query intrinsic dimensions normally.
class SenseCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color cardColor;
  final VoidCallback? onTap;
  final bool filled;
  final double? width;

  /// Diameter of the circular icon background. Drives all other sizes.
  final double iconContainerSize;

  /// Size of the icon glyph inside the circle.
  final double iconSize;

  const SenseCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.cardColor,
    this.onTap,
    this.filled = false,
    this.width,
    this.iconContainerSize = 68,
    this.iconSize = 32,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(18);

    // All other sizes derived from iconContainerSize — no LayoutBuilder needed.
    final hPad       = (iconContainerSize * 0.21).clamp(10.0, 20.0);
    final vPad       = (iconContainerSize * 0.21).clamp(10.0, 20.0);
    final titleSz    = (iconContainerSize * 0.27).clamp(13.0, 20.0);
    final subtitleSz = (iconContainerSize * 0.20).clamp(10.5, 15.0);
    final iconGap    = (iconContainerSize * 0.14).clamp(8.0, 14.0);

    final cardContent = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ── Top colour stripe ─────────────────────────────────────────────
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
        // ── Body ──────────────────────────────────────────────────────────
        Padding(
          padding: EdgeInsets.fromLTRB(hPad, vPad, hPad, vPad + 2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon circle
              Container(
                width: iconContainerSize,
                height: iconContainerSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: filled
                      ? cardColor
                      : cardColor.withValues(alpha: 0.18),
                ),
                alignment: Alignment.center,
                child: Icon(
                  icon,
                  size: iconSize,
                  color: filled ? Colors.white : cardColor,
                ),
              ),
              SizedBox(height: iconGap),
              // Title
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: titleSz,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF1D2630),
                ),
              ),
              const SizedBox(height: 4),
              // Subtitle
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: subtitleSz,
                  color: const Color(0xFF8C8C8C),
                  height: 1.2,
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
            child: cardContent,
          ),
        ),
      ),
    );
  }
}
