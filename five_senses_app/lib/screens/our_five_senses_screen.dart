import 'package:flutter/material.dart';

import '../models/app_routes.dart';
import '../models/sense.dart';
import '../theme/app_theme.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/five_senses_scaffold.dart';
import '../widgets/sense_card.dart';

class OurFiveSensesScreen extends StatelessWidget {
  const OurFiveSensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final headerColor = AppTheme.teal;

    return FiveSensesScaffold(
      selectedTabIndex: 1, // Learn
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
          case BottomTab.practice:
            Navigator.pushReplacementNamed(
              context,
              Routes.practiceQuestion2,
            );
            break;
        }
      },
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.28,
            width: double.infinity,
            child: Stack(
              children: [
                // Decorative translucent circles.
                Positioned(
                  top: -90,
                  left: -60,
                  child: _Bubble(color: Colors.white.withOpacity(0.08)),
                ),
                Positioned(
                  top: -70,
                  right: -50,
                  child: _Bubble(color: Colors.white.withOpacity(0.08)),
                ),
                Positioned(
                  bottom: -90,
                  left: -80,
                  child: _Bubble(color: Colors.white.withOpacity(0.07)),
                ),
                Positioned(
                  top: 18,
                  left: 18,
                  right: 18,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () =>
                            Navigator.pushReplacementNamed(context, Routes.home),
                        icon: const Icon(Icons.arrow_back_ios_rounded,
                            color: Colors.white),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Five Senses',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.white.withOpacity(0.95),
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 58,
                  left: 18,
                  right: 18,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Our Five Senses',
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                              fontWeight: FontWeight.w900,
                              fontSize: 34,
                              color: Colors.white,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tap a sense to explore it!',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Colors.white.withOpacity(0.82),
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                ),
                Container(color: headerColor),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 14, 18, 24),
              child: Column(
                children: [
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 1 / 1.08,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _SenseCardForType(context, type: SenseType.sight),
                      _SenseCardForType(context, type: SenseType.hearing),
                      _SenseCardForType(context, type: SenseType.smell),
                      _SenseCardForType(context, type: SenseType.taste),
                    ],
                  ),
                  const SizedBox(height: 14),
                  // Touch card spans the width.
                  _TouchCard(context),
                  const SizedBox(height: 12),
                  _ProgressPill(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _SenseCardForType(BuildContext context, {required SenseType type}) {
    final model = senses.firstWhere((s) => s.type == type);
    return SenseCard(
      title: model.title,
      subtitle: model.subtitle,
      icon: model.icon,
      cardColor: model.chipColor,
      filled: false,
      onTap: () {
        if (type == SenseType.sight) {
          Navigator.pushReplacementNamed(context, Routes.sightDetail);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('This sense is coming soon.')),
          );
        }
      },
    );
  }

  Widget _TouchCard(BuildContext context) {
    final model = senses.firstWhere((s) => s.type == SenseType.touch);
    return SizedBox(
      width: double.infinity,
      child: SenseCard(
        title: model.title,
        subtitle: model.subtitle,
        icon: model.icon,
        cardColor: model.chipColor,
        filled: false,
        width: double.infinity,
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Touch is coming soon.')),
          );
        },
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  final Color color;
  const _Bubble({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 210,
      height: 210,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}

class _ProgressPill extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.orangeDeep.withOpacity(0.95),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        '2 / 5 Senses Explored ✨',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.2,
            ),
      ),
    );
  }
}

