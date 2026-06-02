import 'package:flutter/material.dart';

import '../models/app_routes.dart';

class SmellSorterIntroScreen extends StatelessWidget {
  const SmellSorterIntroScreen({super.key});

  static const _headerColor = Color(0xFFF5D457);
  static const _bgColor = Color(0xFFF9F2D2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      body: Column(
        children: [
          _Header(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 20, 18, 32),
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
                  const SizedBox(height: 14),
                  _CategoryRow(
                    color: Colors.red,
                    title: 'Floral',
                    subtitle: 'Rose, Lavender',
                    icon: Icons.local_florist_rounded,
                  ),
                  const SizedBox(height: 10),
                  _CategoryRow(
                    color: Colors.orange,
                    title: 'Food',
                    subtitle: 'Pizza, Garlic',
                    icon: Icons.fastfood_rounded,
                  ),
                  const SizedBox(height: 10),
                  _CategoryRow(
                    color: Colors.teal,
                    title: 'Nature',
                    subtitle: 'Grass, Pine',
                    icon: Icons.eco_rounded,
                  ),
                  const SizedBox(height: 10),
                  _CategoryRow(
                    color: Colors.lightGreen,
                    title: 'Fresh',
                    subtitle: 'Mint, Soap',
                    icon: Icons.water_drop_rounded,
                  ),
                  const SizedBox(height: 18),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _headerColor.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('💡', style: TextStyle(fontSize: 20)),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Look at the image and guess the smell, then drag it to the right category bucket!',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF2A2A2A),
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  SizedBox(
                    height: 58,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pushReplacementNamed(
                          context, Routes.smellSorterQuestion1),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _headerColor,
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
                  const SizedBox(height: 12),
                  const Center(
                    child: Text(
                      'Best: ★★★★ High Score: 1200',
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
    );
  }

  Widget _Header(BuildContext context) {
    return Container(
      width: double.infinity,
      color: _headerColor,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Back button + title row
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 8, 18, 0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pushReplacementNamed(
                        context, Routes.playPick),
                    icon: const Icon(Icons.arrow_back_ios_rounded,
                        color: Colors.black87, size: 22),
                  ),
                  const SizedBox(width: 4),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Smell Sorter',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF2A2A2A),
                        ),
                      ),
                      Text(
                        'Smell Sense 🌿',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black.withOpacity(0.55),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Hero icon — fully inside the header, not clipped
            Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.spa_rounded,
                  size: 60, color: Color(0xFF9B59B6)),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _CategoryRow extends StatelessWidget {
  final Color color;
  final String title;
  final String subtitle;
  final IconData icon;

  const _CategoryRow({
    required this.color,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(width: 12),
          CircleAvatar(
            backgroundColor: color.withOpacity(0.15),
            radius: 22,
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF2A2A2A),
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
