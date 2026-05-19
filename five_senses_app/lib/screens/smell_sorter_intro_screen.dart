import 'package:flutter/material.dart';

import '../models/app_routes.dart';

class SmellSorterIntroScreen extends StatelessWidget {
  const SmellSorterIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const headerColor = Color(0xFFF5D457);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F2D2),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: MediaQuery.of(context).size.height * 0.22,
              child: Container(color: headerColor),
            ),
            Column(
              children: [
                Container(
                  height: 210,
                  color: headerColor,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 10 + MediaQuery.of(context).padding.top,
                        left: 16,
                        child: IconButton(
                          onPressed: () =>
                              Navigator.pushReplacementNamed(context, Routes.playPick),
                          icon: const Icon(
                            Icons.arrow_back_ios_rounded,
                            color: Colors.black87,
                            size: 24,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 26 + MediaQuery.of(context).padding.top,
                        left: 20,
                        child: const Text(
                          'Smell Sorter',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF2A2A2A),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 58 + MediaQuery.of(context).padding.top,
                        left: 20,
                        child: Text(
                          'Smell Sense 🤔',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 110,
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
                            child: const Icon(Icons.spa_rounded,
                                size: 72, color: Color(0xFF9B59B6)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(18, 12, 18, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sort smells into 4 categories:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF2A2A2A),
                          ),
                        ),
                        const SizedBox(height: 12),
                        _CategoryRow(
                          stripe: Colors.red.withOpacity(0.25),
                          color: Colors.red,
                          title: 'Floral',
                          subtitle: 'Rose, Lavender',
                          icon: Icons.local_florist_rounded,
                        ),
                        const SizedBox(height: 10),
                        _CategoryRow(
                          stripe: Colors.orange.withOpacity(0.25),
                          color: Colors.orange,
                          title: 'Food',
                          subtitle: 'Pizza, Garlic',
                          icon: Icons.fastfood_rounded,
                        ),
                        const SizedBox(height: 10),
                        _CategoryRow(
                          stripe: Colors.teal.withOpacity(0.25),
                          color: Colors.teal,
                          title: 'Nature',
                          subtitle: 'Grass, Pine',
                          icon: Icons.eco_rounded,
                        ),
                        const SizedBox(height: 10),
                        _CategoryRow(
                          stripe: Colors.lightGreen.withOpacity(0.25),
                          color: Colors.lightGreen,
                          title: 'Fresh',
                          subtitle: 'Mint, Soap',
                          icon: Icons.water_drop_rounded,
                        ),
                        const SizedBox(height: 14),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 14),
                          decoration: BoxDecoration(
                            color: headerColor.withOpacity(0.85),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: const Text(
                            '💡 Tip\nLook at the image and guess the smell, then drag it to the right category bucket!',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF2A2A2A),
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        SizedBox(
                          height: 60,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () =>
                                Navigator.pushReplacementNamed(context, Routes.smellSorterQuestion3),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: headerColor,
                              foregroundColor: Colors.black87,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              'Start Sniffing! 🔔',
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
                            'Best: ★★★★ High Score: 1200',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFB7B7B7),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryRow extends StatelessWidget {
  final Color stripe;
  final Color color;
  final String title;
  final String subtitle;
  final IconData icon;

  const _CategoryRow({
    required this.stripe,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66,
      padding: const EdgeInsets.symmetric(horizontal: 12),
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
            height: 46,
            decoration: BoxDecoration(
              color: stripe,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(width: 12),
          CircleAvatar(
            backgroundColor: color.withOpacity(0.18),
            radius: 24,
            child: Icon(icon, color: color, size: 26),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF2A2A2A),
                  ),
                ),
                Text(
                  subtitle,
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

