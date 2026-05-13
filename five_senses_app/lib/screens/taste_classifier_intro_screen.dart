import 'package:flutter/material.dart';

import '../models/app_routes.dart';

class TasteClassifierIntroScreen extends StatelessWidget {
  const TasteClassifierIntroScreen({super.key});

  static const _headerColor = Color(0xFF6A59E0);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.shortestSide >= 600;

    final headerH = isTablet ? 280.0 : 220.0;
    final avatarSize = isTablet ? 180.0 : 150.0;
    final avatarBottom = -(avatarSize / 2.0);
    final scrollPaddingTop = avatarSize / 2.0 + 36.0;
    final contentPad = isTablet ? 24.0 : 18.0;
    final maxW = isTablet ? 680.0 : double.infinity;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F0FF),
      body: SafeArea(
        child: Column(
          children: [
            // ── Purple header ─────────────────────────────────────────────
            Container(
              height: headerH,
              width: double.infinity,
              color: _headerColor,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Back button
                  Positioned(
                    top: isTablet ? 22 : 16,
                    left: 8,
                    child: IconButton(
                      onPressed: () => Navigator.pushReplacementNamed(
                          context, Routes.playPick),
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                  // Title block
                  Positioned(
                    top: isTablet ? 64 : 52,
                    left: contentPad,
                    right: contentPad,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Taste Classifier',
                          style: TextStyle(
                            fontSize: isTablet ? 42 : 34,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Taste Sense 👅',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontWeight: FontWeight.w700,
                            fontSize: isTablet ? 20 : 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Hero circle avatar
                  Positioned(
                    bottom: avatarBottom,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        width: avatarSize,
                        height: avatarSize,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x20000000),
                              blurRadius: 16,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '👅',
                          style: TextStyle(fontSize: isTablet ? 72 : 58),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Scrollable content ────────────────────────────────────────
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxW),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(
                        contentPad, scrollPaddingTop, contentPad, 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'The 4 Taste Zones on your tongue:',
                          style: TextStyle(
                            fontSize: isTablet ? 24 : 20,
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF2A2A2A),
                          ),
                        ),
                        const SizedBox(height: 14),
                        _ZoneRow(
                          color: const Color(0xFFFF5F8D),
                          title: 'Sweet',
                          subtitle: 'Tip of tongue • Sugar, Honey, Fruit',
                          icon: Icons.emoji_food_beverage_rounded,
                          emoji: '🍓',
                          isTablet: isTablet,
                        ),
                        const SizedBox(height: 10),
                        _ZoneRow(
                          color: const Color(0xFFFFAB00),
                          title: 'Sour',
                          subtitle: 'Sides of tongue • Lemon, Vinegar',
                          icon: Icons.water_drop_rounded,
                          emoji: '🍋',
                          isTablet: isTablet,
                        ),
                        const SizedBox(height: 10),
                        _ZoneRow(
                          color: const Color(0xFF00ACC1),
                          title: 'Salty',
                          subtitle: 'Front sides • Chips, Pretzels',
                          icon: Icons.layers_rounded,
                          emoji: '🍟',
                          isTablet: isTablet,
                        ),
                        const SizedBox(height: 10),
                        _ZoneRow(
                          color: const Color(0xFF7C4DFF),
                          title: 'Bitter',
                          subtitle: 'Back of tongue • Coffee, Dark Choc.',
                          icon: Icons.local_drink_rounded,
                          emoji: '☕',
                          isTablet: isTablet,
                        ),
                        const SizedBox(height: 22),

                        // Fun fact card
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(isTablet ? 20 : 16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEDE7F6),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Row(
                            children: [
                              Text('🧠',
                                  style: TextStyle(
                                      fontSize: isTablet ? 28 : 22)),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Did you know? Humans have about 10,000 taste buds on their tongue!',
                                  style: TextStyle(
                                    fontSize: isTablet ? 16 : 14,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF4A3AAA),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),

                        // Start button
                        SizedBox(
                          height: isTablet ? 68 : 60,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => Navigator.pushReplacementNamed(
                                context, Routes.tasteClassifierQuestion4),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _headerColor,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text(
                              'Taste & Classify! 👅',
                              style: TextStyle(
                                fontSize: isTablet ? 22 : 20,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Center(
                          child: Text(
                            '10 foods • 90 seconds • 5 lives',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFB7B7B7),
                              fontSize: isTablet ? 16 : 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ZoneRow extends StatelessWidget {
  final Color color;
  final String title;
  final String subtitle;
  final IconData icon;
  final String emoji;
  final bool isTablet;

  const _ZoneRow({
    required this.color,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.emoji,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 14, vertical: isTablet ? 14 : 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 5,
            height: isTablet ? 56 : 46,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: isTablet ? 52 : 44,
            height: isTablet ? 52 : 44,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(emoji,
                style: TextStyle(fontSize: isTablet ? 24 : 20)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: isTablet ? 20 : 18,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF2A2A2A),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: isTablet ? 15 : 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withValues(alpha: 0.35),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              title,
              style: TextStyle(
                fontSize: isTablet ? 13 : 11,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
