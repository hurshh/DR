import 'package:flutter/material.dart';

import '../models/app_routes.dart';
import '../theme/app_theme.dart';

class TasteClassifierIntroScreen extends StatelessWidget {
  const TasteClassifierIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const headerColor = Color(0xFF6A59E0);

    return Scaffold(
      backgroundColor: const Color(0xFFF3F0FF),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 220,
              width: double.infinity,
              color: headerColor,
              child: Stack(
                children: [
                  Positioned(
                    top: 18 + MediaQuery.of(context).padding.top,
                    left: 16,
                    child: IconButton(
                      onPressed: () =>
                          Navigator.pushReplacementNamed(context, Routes.playPick),
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 54,
                    left: 24,
                    right: 24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Taste Classifier',
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Taste Sense 🔥',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: -58,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        alignment: Alignment.center,
                        child: const Icon(Icons.restaurant_rounded,
                            size: 74, color: Color(0xFF6A59E0)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(18, 96, 18, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'The 4 Taste Zones on your tongue:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF2A2A2A),
                      ),
                    ),
                    const SizedBox(height: 14),
                    _ZoneRow(
                      stripe: Colors.red.withOpacity(0.35),
                      color: Colors.red,
                      title: 'Sweet',
                      subtitle: 'Tip of tongue • Sugar, Honey, Fruit',
                      icon: Icons.emoji_food_beverage_rounded,
                    ),
                    const SizedBox(height: 10),
                    _ZoneRow(
                      stripe: Colors.amber.withOpacity(0.35),
                      color: Colors.amber,
                      title: 'Sour',
                      subtitle: 'Sides of tongue • Lemon, Vinegar',
                      icon: Icons.water_drop_rounded,
                    ),
                    const SizedBox(height: 10),
                    _ZoneRow(
                      stripe: Colors.teal.withOpacity(0.35),
                      color: Colors.teal,
                      title: 'Salty',
                      subtitle: 'Front sides • Chips, Pretzels',
                      icon: Icons.layers_rounded,
                    ),
                    const SizedBox(height: 10),
                    _ZoneRow(
                      stripe: Colors.deepPurple.withOpacity(0.4),
                      color: Colors.deepPurple,
                      title: 'Bitter',
                      subtitle: 'Back of tongue • Coffee, Dark Choc.',
                      icon: Icons.local_drink_rounded,
                    ),
                    const SizedBox(height: 18),
                    Center(
                      child: SizedBox(
                        height: 46,
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            backgroundColor:
                                const Color(0xFFE7E6F6).withOpacity(0.9),
                            foregroundColor: const Color(0xFF6A59E0),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: const Text(
                            '🌙 Tongue Map',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      height: 62,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pushReplacementNamed(
                            context, Routes.tasteClassifierQuestion4),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: headerColor,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Taste & Classify!',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Center(
                      child: Text(
                        'Best: ★★★★ High Score: 1600',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFB7B7B7),
                        ),
                      ),
                    ),
                  ],
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
  final Color stripe;
  final Color color;
  final String title;
  final String subtitle;
  final IconData icon;

  const _ZoneRow({
    required this.stripe,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 8,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 6,
            decoration: BoxDecoration(
              color: stripe,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(width: 12),
          CircleAvatar(
            radius: 24,
            backgroundColor: color.withOpacity(0.15),
            child: Icon(icon, size: 26, color: color),
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
                    fontSize: 18,
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
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withOpacity(0.35),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

