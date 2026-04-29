import 'package:flutter/material.dart';

import '../models/app_routes.dart';
import '../theme/app_theme.dart';

class SpotDifferenceResultScreen extends StatelessWidget {
  const SpotDifferenceResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.dark,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 72,
              color: AppTheme.dark,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, Routes.home),
                    icon: const Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Spot the Difference',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.timer_outlined,
                      color: Colors.white70, size: 18),
                  const SizedBox(width: 8),
                  const Text(
                    '0:45',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(width: 18),
                  const Icon(Icons.favorite_rounded,
                      color: Colors.white70, size: 18),
                  const SizedBox(width: 8),
                  const Row(
                    children: [
                      Icon(Icons.favorite_rounded,
                          color: Colors.white, size: 16),
                      SizedBox(width: 6),
                      Icon(Icons.favorite_rounded,
                          color: Colors.white, size: 16),
                      SizedBox(width: 6),
                      Icon(Icons.favorite_rounded,
                          color: Colors.white, size: 16),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.auto_awesome_rounded,
                            color: Color(0xFFFFD04D), size: 18),
                        const SizedBox(width: 6),
                        const Text(
                          '2 / 5 found',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: _GameImageCard(
                            topIcon: Icons.wb_sunny_rounded,
                            tint: const Color(0xFFFF7A3B),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _GameImageCard(
                            topIcon: Icons.wb_sunny_rounded,
                            tint: const Color(0xFFFFD84D),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Differences found:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        _Dot(found: true),
                        _Dot(found: true),
                        _Dot(found: false),
                        _Dot(found: false),
                        _Dot(found: false),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        Expanded(
                          child: _DarkPillButton(
                            icon: Icons.lightbulb_outline_rounded,
                            text: 'Use a Hint',
                            onPressed: () {},
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _DarkPillButton(
                            icon: Icons.skip_next_rounded,
                            text: 'Skip Game',
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                context,
                                Routes.home,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      '👇 Tap on the difference in Image B',
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF45E6C1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.check_rounded, color: Colors.white),
                          SizedBox(width: 10),
                          Text(
                            'Found a difference! +1',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'Look carefully at the colors!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        6,
                        (i) => const Icon(
                          Icons.star_rounded,
                          size: 26,
                          color: Color(0xFFFFD54A),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () =>
                            Navigator.pushReplacementNamed(context, Routes.home),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2A333D),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 0,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.home_rounded),
                            SizedBox(width: 10),
                            Text(
                              'Go Home',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
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

class _GameImageCard extends StatelessWidget {
  final IconData topIcon;
  final Color tint;

  const _GameImageCard({
    required this.topIcon,
    required this.tint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const SizedBox(height: 18),
          CircleAvatar(
            radius: 24,
            backgroundColor: tint,
            child: Icon(topIcon, color: Colors.white, size: 22),
          ),
          const SizedBox(height: 10),
          Text(
            'Image A',
            style: TextStyle(color: Colors.white.withOpacity(0.001)),
          ),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final bool found;
  const _Dot({required this.found});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 26,
      height: 26,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: found ? const Color(0xFF45E6C1) : Colors.white.withOpacity(0.25),
        shape: BoxShape.circle,
      ),
    );
  }
}

class _DarkPillButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const _DarkPillButton({
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 18),
        label: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 16,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2A333D),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}

