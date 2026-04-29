import 'package:flutter/material.dart';

import '../models/app_routes.dart';
import '../theme/app_theme.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/feedback_banner.dart';
import '../widgets/five_senses_scaffold.dart';
import '../widgets/quiz_option_card.dart';

class PracticeQuestion2Screen extends StatelessWidget {
  const PracticeQuestion2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    const selectedTabIndex = 3; // Practice

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
          case BottomTab.practice:
            Navigator.pushReplacementNamed(context, Routes.practiceQuestion2);
            break;
        }
      },
      backgroundColor: AppTheme.lightCream,
      body: Column(
        children: [
          Container(
            height: 110,
            width: double.infinity,
            color: AppTheme.orange,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 12, 18, 12),
                child: Row(
                  children: [
                    const Icon(Icons.edit_rounded,
                        color: Colors.white, size: 28),
                    const SizedBox(width: 10),
                    Text(
                      'Practice',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.2,
                          ),
                    ),
                    const Spacer(),
                    const Icon(Icons.wifi, color: Colors.white70, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      '9:41',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 14, 18, 12),
            child: Row(
              children: [
                Text(
                  'Question 2 of 6',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF9A9A9A),
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const Spacer(),
                Row(
                  children: [
                    const Text(
                      '✨ x4',
                      style: TextStyle(
                        color: Color(0xFFE95A2A),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Question 2',
                          style: TextStyle(
                            color: Color(0xFFE95A2A),
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Which part of the body\ndo we use to HEAR?',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF2A2A2A),
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            _SenseMini(icon: Icons.hearing),
                            _SenseMini(icon: Icons.visibility_outlined),
                            _SenseMini(icon: Icons.spa_outlined),
                            _SenseMini(icon: Icons.handyman_outlined),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  QuizOptionCard(
                    letter: 'A',
                    text: 'Eyes',
                    selected: false,
                    correct: false,
                    onTap: null,
                  ),
                  const SizedBox(height: 12),
                  QuizOptionCard(
                    letter: 'B',
                    text: 'Ears',
                    selected: true,
                    correct: true,
                    onTap: null,
                  ),
                  const SizedBox(height: 12),
                  QuizOptionCard(
                    letter: 'C',
                    text: 'Nose',
                    selected: false,
                    correct: false,
                    onTap: null,
                  ),
                  const SizedBox(height: 12),
                  QuizOptionCard(
                    letter: 'D',
                    text: 'Hands',
                    selected: false,
                    correct: false,
                    onTap: null,
                  ),
                  const SizedBox(height: 18),
                  const FeedbackBanner(
                    text: 'Correct! Ears are for hearing!',
                    backgroundColor: Color(0xFF45E6C1),
                    textColor: Colors.white,
                    icon: Icons.check_rounded,
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    height: 58,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.orange,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () =>
                          Navigator.pushReplacementNamed(context, Routes.gameResult),
                      child: const Text(
                        'Next Question →',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SenseMini extends StatelessWidget {
  final IconData icon;
  const _SenseMini({required this.icon});

  @override
  Widget build(BuildContext context) {
    final color = icon == Icons.hearing
        ? const Color(0xFFF5D457)
        : icon == Icons.visibility_outlined
            ? const Color(0xFF58D3CA)
            : icon == Icons.spa_outlined
                ? const Color(0xFF9B59B6)
                : const Color(0xFFFF7A3B);

    return Container(
      width: 54,
      height: 54,
      decoration: BoxDecoration(
        color: color.withOpacity(0.14),
        borderRadius: BorderRadius.circular(16),
      ),
      alignment: Alignment.center,
      child: Icon(icon, size: 26, color: color),
    );
  }
}

