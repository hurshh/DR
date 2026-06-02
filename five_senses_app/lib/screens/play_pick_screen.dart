import 'package:flutter/material.dart';

import '../models/app_routes.dart';
import '../services/app_data_service.dart';
import '../theme/app_theme.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/five_senses_scaffold.dart';

class PlayPickScreen extends StatelessWidget {
  const PlayPickScreen({super.key});

  /// Maps a 0–5 star rating to the 0–3 star display used by [_MiniGameCard].
  static int _displayStars(String gameId) {
    final s = AppDataService.instance.getBestStars(gameId);
    if (s >= 4) return 3;
    if (s >= 2) return 2;
    if (s >= 1) return 1;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    const selectedTabIndex = 2; // Play
    return FiveSensesScaffold(
      selectedTabIndex: selectedTabIndex,
      onBottomNavTap: (tab) {
        switch (tab) {
          case BottomTab.home:
            Navigator.pushReplacementNamed(context, Routes.home);
            break;
          case BottomTab.learn:
            Navigator.pushReplacementNamed(context, Routes.ourFiveSenses);
            break;
          case BottomTab.play:
            Navigator.pushReplacementNamed(context, Routes.playPick);
            break;
        }
      },
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.16,
            width: double.infinity,
            child: DecoratedBox(
              decoration: const BoxDecoration(color: AppTheme.purple),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 22,
                  right: 18,
                  top: MediaQuery.of(context).padding.top + 18,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.videogame_asset_rounded,
                        color: Colors.white, size: 28),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Play',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -0.2,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Pick a mini-game!',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Colors.white.withOpacity(0.86),
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 90),
              child: Column(
                children: [
                  _MiniGameCard(
                    stripeColor: const Color(0xFF57D2C7),
                    title: 'Spot the Difference',
                    subtitle: 'Sight',
                    rating: _displayStars('spot_difference'),
                    locked: false,
                    icon: Icons.search_rounded,
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        Routes.spotDifferenceResult,
                      );
                    },
                  ),
                  const SizedBox(height: 14),
                  _MiniGameCard(
                    stripeColor: const Color(0xFF57C8C6),
                    title: 'Sound Match',
                    subtitle: 'Hearing',
                    rating: _displayStars('sound_match'),
                    locked: false,
                    icon: Icons.mic_none_rounded,
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        Routes.soundMatchIntro,
                      );
                    },
                  ),
                  const SizedBox(height: 14),
                  _MiniGameCard(
                    stripeColor: const Color(0xFFF2D35B),
                    title: 'Smell Sorter',
                    subtitle: 'Smell',
                    rating: _displayStars('smell_sorter'),
                    locked: false,
                    icon: Icons.local_florist_rounded,
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        Routes.smellSorterIntro,
                      );
                    },
                  ),
                  const SizedBox(height: 14),
                  _MiniGameCard(
                    stripeColor: const Color(0xFF6B5DE6),
                    title: 'Taste Classifier',
                    subtitle: 'Taste',
                    rating: _displayStars('taste_classifier'),
                    locked: false,
                    icon: Icons.local_drink_rounded,
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        Routes.tasteClassifierIntro,
                      );
                    },
                  ),
                  const SizedBox(height: 14),
                  _MiniGameCard(
                    stripeColor: const Color(0xFFFF7A3B),
                    title: 'Texture Match',
                    subtitle: 'Touch',
                    rating: _displayStars('texture_match'),
                    locked: false,
                    icon: Icons.pan_tool_outlined,
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        Routes.textureMatchIntro,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniGameCard extends StatelessWidget {
  final Color stripeColor;
  final String title;
  final String subtitle;
  final int rating; // 0..3
  final bool locked;
  final IconData icon;
  final VoidCallback onTap;

  const _MiniGameCard({
    required this.stripeColor,
    required this.title,
    required this.subtitle,
    required this.rating,
    required this.locked,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(18);

    return InkWell(
      borderRadius: radius,
      onTap: onTap,
      child: Container(
        height: 92,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: radius,
          boxShadow: const [
            BoxShadow(
              color: Color(0x0D000000),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 8,
              decoration: BoxDecoration(
                color: stripeColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  bottomLeft: Radius.circular(18),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: stripeColor.withOpacity(0.22),
              ),
              alignment: Alignment.center,
              child: Icon(icon, size: 26, color: stripeColor),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF2A2A2A),
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF9A9A9A),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      for (int i = 0; i < 3; i++)
                        Icon(
                          Icons.star_rounded,
                          size: 18,
                          color: i < rating
                              ? const Color(0xFFFFCE47)
                              : const Color(0xFFDADADA),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  if (locked)
                    const Icon(Icons.lock_rounded, size: 20, color: Color(0xFFB7B7B7))
                  else
                    Icon(Icons.arrow_forward_ios_rounded,
                        size: 22, color: stripeColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

