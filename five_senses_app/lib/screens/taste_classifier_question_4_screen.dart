import 'package:flutter/material.dart';

import '../models/app_routes.dart';

class TasteClassifierQuestion4Screen extends StatelessWidget {
  const TasteClassifierQuestion4Screen({super.key});

  @override
  Widget build(BuildContext context) {
    const headerColor = Color(0xFF6A59E0);

    return Scaffold(
      backgroundColor: const Color(0xFFF3F0FF),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 150,
              width: double.infinity,
              color: headerColor,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 22, 18, 0),
                    child: Row(
                      children: [
                        const Text(
                          'Taste Classifier',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 26,
                          ),
                        ),
                        const Spacer(),
                        const Icon(Icons.timer_outlined,
                            color: Colors.white70, size: 20),
                        const SizedBox(width: 8),
                        const Text(
                          '2:05',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Icon(Icons.auto_awesome_rounded,
                            color: Color(0xFFFFD54A), size: 20),
                        const SizedBox(width: 6),
                        const Text(
                          '9',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 18,
                    bottom: 10,
                    right: 18,
                    child: Row(
                      children: const [
                        Text(
                          'Food 4 / 10',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 4,
                      color: const Color(0xFFFF7A3B).withOpacity(0.0),
                      child: const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFFF7A3B),
                              Color(0xFFFFD54A),
                              Color(0xFF6A59E0),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(18, 12, 18, 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'How does this food taste?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF2A2A2A),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      height: 170,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9DD63),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        children: [
                          const Spacer(),
                          Container(
                            width: 110,
                            height: 110,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            alignment: Alignment.center,
                            child: const Icon(Icons.local_florist_rounded,
                                size: 62, color: Color(0xFF86A10D)),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Lemon',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF2A2A2A),
                            ),
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              CircleAvatar(
                                radius: 6,
                                backgroundColor: Color(0xFFFF7C93),
                              ),
                              SizedBox(width: 18),
                              CircleAvatar(
                                radius: 6,
                                backgroundColor: Color(0xFF6A59E0),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Tap the taste it belongs to 👇',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFB7B7B7),
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 14),
                    GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: 1 / 1.05,
                      children: [
                        _TasteOption(
                          label: 'Sweet',
                          icon: Icons.emoji_food_beverage_rounded,
                          selected: false,
                          subtitle: 'Tip of tongue',
                        ),
                        _TasteOption(
                          label: 'Sour',
                          icon: Icons.water_drop_rounded,
                          selected: true,
                          subtitle: 'Sides of tongue',
                        ),
                        _TasteOption(
                          label: 'Salty',
                          icon: Icons.layers_rounded,
                          selected: false,
                          subtitle: 'Front sides',
                        ),
                        _TasteOption(
                          label: 'Bitter',
                          icon: Icons.local_drink_rounded,
                          selected: false,
                          subtitle: 'Back of tongue',
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFD85A),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Text(
                        '🍋 Yes! Lemon is SOUR! +2 ✨',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF2A2A2A),
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      height: 58,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pushReplacementNamed(
                          context,
                          Routes.gameResult,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: headerColor,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                        child: const Text(
                          'Next Food →',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.favorite_rounded,
                            color: Color(0xFFFF7C93), size: 22),
                        SizedBox(width: 10),
                        Icon(Icons.favorite_rounded,
                            color: Color(0xFFFF7C93), size: 22),
                        SizedBox(width: 10),
                        Icon(Icons.favorite_rounded,
                            color: Color(0xFFFF7C93), size: 22),
                        SizedBox(width: 10),
                        Icon(Icons.favorite_rounded,
                            color: Color(0xFFFF7C93), size: 22),
                        SizedBox(width: 10),
                        Icon(Icons.favorite_rounded,
                            color: Color(0xFFFF7C93), size: 22),
                      ],
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

class _TasteOption extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final String subtitle;

  const _TasteOption({
    required this.label,
    required this.icon,
    required this.selected,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final bg =
        selected ? const Color(0xFFFFD85A) : Colors.white.withOpacity(0.95);
    final border = selected
        ? Colors.transparent
        : const Color(0xFFEAEAEA);

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: border),
          ),
          padding: const EdgeInsets.all(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  size: 44,
                  color: selected ? const Color(0xFF6A59E0) : const Color(0xFF2A2A2A)),
              const SizedBox(height: 10),
              Text(
                label,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF2A2A2A),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFB7B7B7),
                ),
              ),
            ],
          ),
        ),
        if (selected)
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              width: 28,
              height: 28,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.check_rounded,
                  color: Color(0xFF6A59E0), size: 18),
            ),
          ),
      ],
    );
  }
}

