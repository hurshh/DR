import 'package:flutter/material.dart';

import '../models/activity.dart';
import '../models/app_routes.dart';
import '../theme/app_theme.dart';
import '../widgets/activity_card.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/five_senses_scaffold.dart';
import '../widgets/progress_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const selectedIndex = 0; // Home

    return FiveSensesScaffold(
      selectedTabIndex: selectedIndex,
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
            Navigator.pushReplacementNamed(context, Routes.practiceQuestion2);
            break;
        }
      },
      body: LayoutBuilder(
        builder: (context, constraints) {
          final headerHeight = constraints.maxHeight * 0.23;
          return Column(
            children: [
              SizedBox(
                height: headerHeight,
                width: double.infinity,
                child: DecoratedBox(
                  decoration: const BoxDecoration(color: AppTheme.orange),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 22,
                      right: 18,
                      top: MediaQuery.of(context).padding.top + 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Hello, Explorer! 👋',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: -0.2,
                                    ),
                              ),
                            ),
                            Container(
                              width: 54,
                              height: 54,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white70,
                              ),
                              child: const Icon(Icons.face,
                                  color: AppTheme.orangeDeep, size: 28),
                            )
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'What would you like to do today?',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Colors.white.withOpacity(0.92),
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: LinearProgressBar(
                                progress: 0.5,
                                activeColor: const Color(0xFFFFE0B8),
                                inactiveColor: Colors.white.withOpacity(0.22),
                                height: 10,
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              '50% complete',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(22, 18, 22, 90),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Five Senses',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF2A2A2A),
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'Choose your activity',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF9A9A9A),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 18),
                      ...activities.map((a) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: ActivityCard(
                            stripeColor: a.stripeColor,
                            icon: a.icon,
                            title: a.title,
                            subtitle: a.subtitle,
                            onTap: () {
                              switch (a.type) {
                                case ActivityType.learn:
                                  Navigator.pushNamed(
                                    context,
                                    Routes.ourFiveSenses,
                                  );
                                  break;
                                case ActivityType.play:
                                  Navigator.pushNamed(context, Routes.playPick);
                                  break;
                                case ActivityType.practice:
                                  Navigator.pushNamed(
                                    context,
                                    Routes.practiceQuestion2,
                                  );
                                  break;
                              }
                            },
                          ),
                        );
                      }),
                      const SizedBox(height: 22),
                      Row(
                        children: [
                          const Text(
                            'Senses unlocked:',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF9A9A9A),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Wrap(
                              spacing: 14,
                              runSpacing: 14,
                              alignment: WrapAlignment.start,
                              children: const [
                                // Unlocked state is represented visually only.
                                _SenseDot(
                                  color: Color(0xFF58D3CA),
                                  icon: Icons.visibility,
                                ),
                                _SenseDot(
                                  color: Color(0xFF57C8C6),
                                  icon: Icons.hearing,
                                ),
                                _SenseDot(
                                  color: Color(0xFFF2D35B),
                                  icon: Icons.spa,
                                ),
                                _SenseDot(
                                  color: Color(0xFF6B5DE6),
                                  icon: Icons.local_drink,
                                ),
                                _SenseDot(
                                  color: Color(0xFFFF7A3B),
                                  icon: Icons.handyman,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SenseDot extends StatelessWidget {
  final Color color;
  final IconData icon;

  const _SenseDot({
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      alignment: Alignment.center,
      child: Icon(
        icon,
        color: Colors.white,
        size: 20,
      ),
    );
  }
}

