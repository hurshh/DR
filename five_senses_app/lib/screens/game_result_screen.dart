import 'package:flutter/material.dart';

import '../models/app_routes.dart';
import '../theme/app_theme.dart';

class GameResultScreen extends StatelessWidget {
  const GameResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F0E6),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: -120,
              left: -120,
              child: _Blob(color: Colors.teal.withOpacity(0.14), size: 260),
            ),
            Positioned(
              top: -70,
              right: -90,
              child: _Blob(color: Colors.orange.withOpacity(0.14), size: 240),
            ),
            Positioned(
              bottom: -120,
              left: -130,
              child: _Blob(color: Colors.purple.withOpacity(0.12), size: 260),
            ),
            Positioned(
              bottom: -100,
              right: -100,
              child: _Blob(color: Colors.red.withOpacity(0.10), size: 230),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 22, 18, 26),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 26,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.92),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.emoji_events_rounded,
                            size: 74, color: Color(0xFFB7791F)),
                        const SizedBox(height: 10),
                        const Text(
                          'Amazing!',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF1D2630),
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'You\'re a Sense Champion!',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF9A9A9A),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      _StatCard(
                        icon: Icons.star_rounded,
                        value: '1,240',
                        label: 'Score',
                      ),
                      const SizedBox(width: 12),
                      _StatCard(
                        icon: Icons.percent_rounded,
                        value: '90%',
                        label: 'Accuracy',
                      ),
                      const SizedBox(width: 12),
                      _StatCard(
                        icon: Icons.timer_rounded,
                        value: '1:42',
                        label: 'Time',
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Stars Earned',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF1D2630),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (i) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Icon(
                          Icons.star_rounded,
                          color: const Color(0xFFFFD54A),
                          size: 34,
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    '+4 Stars! New Record! ✨',
                    style: TextStyle(
                      color: Color(0xFFE95A2A),
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Badges Unlocked 🔒',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF1D2630),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const _Badge(
                        bg: Color(0xFF5AD0C6),
                        label: 'Sound Pro',
                        icon: Icons.volume_up_rounded,
                      ),
                      const SizedBox(width: 12),
                      const _Badge(
                        bg: Color(0xFFFF7C93),
                        label: 'Smell Expert',
                        icon: Icons.local_florist_rounded,
                      ),
                      const SizedBox(width: 12),
                      const _Badge(
                        bg: Color(0xFFFFD94A),
                        label: 'Taste Ace',
                        icon: Icons.local_drink_rounded,
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    height: 54,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.orange,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () => Navigator.pushReplacementNamed(
                        context,
                        Routes.practiceQuestion2,
                      ),
                      child: const Text(
                        'Play Again',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 54,
                    width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: AppTheme.teal,
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      onPressed: () =>
                          Navigator.pushReplacementNamed(context, Routes.home),
                      child: const Text(
                        'Go Home',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.55),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.share_rounded,
                            color: Color(0xFF2A2A2A)),
                        const SizedBox(width: 10),
                        TextButton(
                          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Share sheet coming soon.')),
                          ),
                          child: const Text(
                            'Share Score with Friends!',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF2A2A2A),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.72),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppTheme.orangeDeep, size: 26),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w900,
                color: Color(0xFF1D2630),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF9A9A9A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final Color bg;
  final String label;
  final IconData icon;

  const _Badge({
    required this.bg,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 64,
            width: 64,
            decoration: BoxDecoration(
              color: bg,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: Colors.white, size: 30),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2A2A2A),
            ),
          ),
        ],
      ),
    );
  }
}

class _Blob extends StatelessWidget {
  final Color color;
  final double size;
  const _Blob({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(width: size, height: size, decoration: BoxDecoration(shape: BoxShape.circle, color: color));
  }
}

