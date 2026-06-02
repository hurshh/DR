import 'package:flutter/material.dart';

import '../models/activity.dart';
import '../models/app_routes.dart';
import '../services/app_data_service.dart';
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
        }
      },
      body: LayoutBuilder(
        builder: (context, constraints) {
          final headerHeight = constraints.maxHeight * 0.23;

          // ── Live data from AppDataService ──────────────────────────────────
          final svc = AppDataService.instance;
          final name = svc.userName.isEmpty ? 'Explorer' : svc.userName;
          final exploredSenses = svc.exploredSenses;
          final exploredCount = exploredSenses.length;
          final progressFraction = exploredCount / 5;
          final progressPct = (progressFraction * 100).round();

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
                                'Hello, $name! 👋',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: -0.2,
                                    ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                  context, Routes.settings),
                              child: Container(
                                width: 54,
                                height: 54,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white70,
                                ),
                                child: const Icon(Icons.face,
                                    color: AppTheme.orangeDeep, size: 28),
                              ),
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
                                progress: progressFraction,
                                activeColor: const Color(0xFFFFE0B8),
                                inactiveColor: Colors.white.withOpacity(0.22),
                                height: 10,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              '$progressPct% complete',
                              style: const TextStyle(
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
                                    Routes.playPick,
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
                          Text(
                            '$exploredCount / 5 Senses Explored',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Color(0xFF9A9A9A),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Wrap(
                            spacing: 14,
                            runSpacing: 14,
                            alignment: WrapAlignment.start,
                            children: [
                              _SenseDot(
                                activeColor: const Color(0xFF58D3CA),
                                icon: Icons.visibility,
                                explored: exploredSenses.contains('sight'),
                              ),
                              _SenseDot(
                                activeColor: const Color(0xFF57C8C6),
                                icon: Icons.hearing,
                                explored: exploredSenses.contains('hearing'),
                              ),
                              _SenseDot(
                                activeColor: const Color(0xFFF2D35B),
                                icon: Icons.spa,
                                explored: exploredSenses.contains('smell'),
                              ),
                              _SenseDot(
                                activeColor: const Color(0xFF6B5DE6),
                                icon: Icons.local_drink,
                                explored: exploredSenses.contains('taste'),
                              ),
                              _SenseDot(
                                activeColor: const Color(0xFFFF7A3B),
                                icon: Icons.handyman,
                                explored: exploredSenses.contains('touch'),
                              ),
                            ],
                          ),
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
  final Color activeColor;
  final IconData icon;
  final bool explored;

  const _SenseDot({
    required this.activeColor,
    required this.icon,
    required this.explored,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: explored ? activeColor : const Color(0xFFDADADA),
      ),
      alignment: Alignment.center,
      child: Icon(
        icon,
        color: explored ? Colors.white : const Color(0xFFAAAAAA),
        size: 20,
      ),
    );
  }
}

