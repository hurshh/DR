import 'package:flutter/material.dart';

import '../models/app_routes.dart';
import '../theme/app_theme.dart';

class SoundMatchIntroScreen extends StatelessWidget {
  const SoundMatchIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const headerColor = Color(0xFF5AD2C7);

    return Scaffold(
      backgroundColor: const Color(0xFFF3FBFC),
      body: SafeArea(
        child: Stack(
          children: [
            // Decorative background bubbles.
            Positioned(
              top: -120,
              left: -120,
              child: _Bubble(color: Colors.white.withOpacity(0.12), size: 260),
            ),
            Positioned(
              top: -70,
              right: -90,
              child: _Bubble(color: Colors.white.withOpacity(0.10), size: 230),
            ),
            Positioned(
              bottom: -160,
              left: -110,
              child: _Bubble(color: Colors.white.withOpacity(0.09), size: 300),
            ),
            Column(
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  color: headerColor,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 10,
                        left: 14,
                        right: 14,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () => Navigator.pushReplacementNamed(
                                  context, Routes.playPick),
                              icon: const Icon(
                                Icons.arrow_back_ios_rounded,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Spacer(),
                            const Icon(Icons.wifi, color: Colors.white70, size: 18),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 56,
                        left: 22,
                        right: 22,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Sound Match',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                height: 1.0,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Hearing Sense 🧠',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white.withOpacity(0.9),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: -54,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.hearing,
                              size: 60,
                              color: Color(0xFFF4B000),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 70),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(18, 0, 18, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'What you\'ll practice:',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w900,
                                color: const Color(0xFF2A2A2A),
                              ),
                        ),
                        const SizedBox(height: 12),
                        _PracticeRow(
                          icon: Icons.music_note_rounded,
                          title: 'Recognise sounds by ear',
                        ),
                        const SizedBox(height: 10),
                        _PracticeRow(
                          icon: Icons.spatial_tracking_rounded,
                          title: 'Match sound to its source',
                        ),
                        const SizedBox(height: 10),
                        _PracticeRow(
                          icon: Icons.flash_on_rounded,
                          title: 'Beat the clock!',
                        ),
                        const SizedBox(height: 18),
                        const Text(
                          'Difficulty:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF2A2A2A),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            _DifficultyPill(
                              text: 'Easy',
                              active: true,
                              color: headerColor,
                            ),
                            const SizedBox(width: 14),
                            _DifficultyPill(
                              text: 'Medium',
                              active: false,
                              color: const Color(0xFFE4E4E4),
                            ),
                            const SizedBox(width: 14),
                            _DifficultyPill(
                              text: 'Hard',
                              active: false,
                              color: const Color(0xFFE4E4E4),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: headerColor.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Icon(Icons.volume_up_rounded, color: Color(0xFF2B6B69)),
                              SizedBox(height: 10),
                              Text(
                                'How to Play',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                  color: Color(0xFF0F3B3A),
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                'Listen to the sound, then tap the matching object from the grid below!',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF0F3B3A),
                                  height: 1.25,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        SizedBox(
                          height: 60,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: headerColor,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 0,
                            ),
                            onPressed: () => Navigator.pushReplacementNamed(
                              context,
                              Routes.soundMatchRound2,
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.play_arrow_rounded, size: 26),
                                SizedBox(width: 10),
                                Text(
                                  'Start Game',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Center(
                          child: Text(
                            'Best: ★★★★ High Score: 840',
                            style: TextStyle(
                              color: Color(0xFF9A9A9A),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
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

class _PracticeRow extends StatelessWidget {
  final IconData icon;
  final String title;

  const _PracticeRow({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF45E6C1), size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2A2A2A),
              ),
              maxLines: 2,
            ),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.check_rounded, color: Color(0xFF45E6C1)),
        ],
      ),
    );
  }
}

class _DifficultyPill extends StatelessWidget {
  final String text;
  final bool active;
  final Color color;

  const _DifficultyPill({
    required this.text,
    required this.active,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
      decoration: BoxDecoration(
        color: active ? color : const Color(0xFFE9E9E9),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w900,
          color: active ? Colors.white : const Color(0xFFB3B3B3),
        ),
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  final Color color;
  final double size;
  const _Bubble({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}

