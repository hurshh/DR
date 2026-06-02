import 'package:flutter/material.dart';

import '../models/app_routes.dart';
import '../models/sense.dart';
import '../theme/app_theme.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/five_senses_scaffold.dart';

class TouchDetailScreen extends StatelessWidget {
  const TouchDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const headerColor = Color(0xFFFF7A3B);

    return FiveSensesScaffold(
      selectedTabIndex: 1,
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
      backgroundColor: AppTheme.lightCream,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.36,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Positioned(
                          top: -100, left: -70,
                          child: Container(
                            width: 220, height: 220,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.08),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Positioned(
                          top: -110, right: -80,
                          child: Container(
                            width: 240, height: 240,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.08),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Container(color: headerColor),
                        Positioned(
                          top: MediaQuery.of(context).padding.top + 12,
                          left: 18, right: 18,
                          child: Row(
                            children: [
                              IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                icon: const Icon(Icons.arrow_back_ios_rounded,
                                    color: Colors.white, size: 26),
                                onPressed: () => Navigator.pushReplacementNamed(
                                    context, Routes.ourFiveSenses),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Senses',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                              ),
                              const Spacer(),
                              Text(
                                '5 / 5',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 0, right: 0, top: 110,
                          child: Center(
                            child: Container(
                              width: 220, height: 220,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              alignment: Alignment.center,
                              child: Icon(
                                senses
                                    .firstWhere(
                                        (s) => s.type == SenseType.touch)
                                    .icon,
                                size: 88,
                                color: const Color(0xFF7A3300),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 26),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Touch',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 40,
                                  color: const Color(0xFF1D2630)),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Did You Know? ✨',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: const Color(0xFFE95A2A)),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Your skin is your body\'s largest sense organ! It is covered in millions of tiny receptors that can feel pressure, heat, cold and texture — all at the same time. Touch is the very first sense you develop!',
                          style: TextStyle(
                              fontSize: 18,
                              height: 1.45,
                              color: Color(0xFF2A2A2A),
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                              color: headerColor,
                              borderRadius: BorderRadius.circular(18)),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                Icon(Icons.lightbulb,
                                    color: Colors.white70, size: 20),
                                SizedBox(width: 10),
                                Text('Fun Fact',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                        fontSize: 16)),
                              ]),
                              SizedBox(height: 6),
                              Text(
                                'A single fingertip has up to 3,000 touch receptors — making it one of the most sensitive spots on your body!',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.orange,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28)),
                              elevation: 0,
                            ),
                            onPressed: () => Navigator.pushReplacementNamed(
                                context, Routes.learnTouch),
                            child: const Text('Start Learning →',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w900)),
                          ),
                        ),
                      ],
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
}
