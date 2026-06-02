import 'package:flutter/material.dart';

import '../models/app_routes.dart';
import '../models/game_result_data.dart';
import '../theme/app_theme.dart';

class GameResultScreen extends StatelessWidget {
  const GameResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Read real stats passed as route arguments; fall back gracefully if null.
    final data =
        ModalRoute.of(context)?.settings.arguments as GameResultData?;

    final scoreStr = data != null ? '${data.score}' : '—';
    final accuracyStr = data?.accuracyLabel ?? '—';
    final timeStr = data?.timeLabel ?? '—';
    final stars = data?.stars ?? 3;
    final pct = data?.accuracyPct ?? 0;

    // Dynamic headline based on accuracy.
    final headline = pct >= 90
        ? 'Amazing! 🌟'
        : pct >= 70
            ? 'Great Job! 🎉'
            : pct >= 50
                ? 'Well Done! 👍'
                : 'Keep Going! 💪';
    final subline = pct >= 90
        ? "You're a Sense Champion!"
        : pct >= 70
            ? "You're getting the hang of it!"
            : pct >= 50
                ? 'Good effort — keep exploring!'
                : 'Practice makes perfect!';

    // Badge derived from game title.
    final _BadgeInfo badge = _badgeFor(data?.gameTitle);

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
                  // ── Hero card ──────────────────────────────────────────────
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
                        Text(
                          headline,
                          style: const TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF1D2630),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          subline,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF9A9A9A),
                          ),
                        ),
                        if (data != null) ...[
                          const SizedBox(height: 10),
                          Text(
                            '${data.gameEmoji}  ${data.gameTitle}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFB0A090),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),

                  // ── Stat row ───────────────────────────────────────────────
                  Row(
                    children: [
                      _StatCard(
                        icon: Icons.star_rounded,
                        value: scoreStr,
                        label: 'Score',
                      ),
                      const SizedBox(width: 12),
                      _StatCard(
                        icon: Icons.percent_rounded,
                        value: accuracyStr,
                        label: 'Accuracy',
                      ),
                      const SizedBox(width: 12),
                      _StatCard(
                        icon: Icons.timer_rounded,
                        value: timeStr,
                        label: 'Time',
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // ── Stars ──────────────────────────────────────────────────
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
                          color: i < stars
                              ? const Color(0xFFFFD54A)
                              : const Color(0xFFDADADA),
                          size: 34,
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    stars == 5
                        ? '5 Stars! Perfect Score! ✨'
                        : '$stars / 5 Stars',
                    style: TextStyle(
                      color: stars >= 4
                          ? const Color(0xFFE95A2A)
                          : const Color(0xFF9A9A9A),
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 18),

                  // ── Badge ──────────────────────────────────────────────────
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Badge Unlocked 🏅',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF1D2630),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _Badge(
                        bg: badge.color,
                        label: badge.label,
                        icon: badge.icon,
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),

                  // ── Buttons ────────────────────────────────────────────────
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
                        Routes.playPick,
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 14),
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
                          onPressed: () =>
                              ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Share sheet coming soon.')),
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

  // ── Badge helper ─────────────────────────────────────────────────────────

  static _BadgeInfo _badgeFor(String? gameTitle) {
    switch (gameTitle) {
      case 'Spot the Difference':
        return const _BadgeInfo(
          color: Color(0xFF5AD0C6),
          label: 'Sight Pro',
          icon: Icons.visibility_rounded,
        );
      case 'Sound Match':
        return const _BadgeInfo(
          color: Color(0xFF53D2C7),
          label: 'Sound Pro',
          icon: Icons.volume_up_rounded,
        );
      case 'Smell Sorter':
        return const _BadgeInfo(
          color: Color(0xFFF5D457),
          label: 'Smell Expert',
          icon: Icons.local_florist_rounded,
        );
      case 'Taste Classifier':
        return const _BadgeInfo(
          color: Color(0xFF7C4DFF),
          label: 'Taste Ace',
          icon: Icons.local_drink_rounded,
        );
      case 'Texture Match':
        return const _BadgeInfo(
          color: Color(0xFFFF7A3B),
          label: 'Touch Master',
          icon: Icons.touch_app_rounded,
        );
      default:
        return const _BadgeInfo(
          color: Color(0xFFFFD94A),
          label: 'Explorer',
          icon: Icons.emoji_events_rounded,
        );
    }
  }
}

class _BadgeInfo {
  final Color color;
  final String label;
  final IconData icon;
  const _BadgeInfo({required this.color, required this.label, required this.icon});
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

