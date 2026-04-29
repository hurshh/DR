import 'package:flutter/material.dart';

import '../models/app_routes.dart';
import '../theme/app_theme.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/five_senses_scaffold.dart';
import '../widgets/step_progress.dart';

class LearnSightStep2Screen extends StatelessWidget {
  const LearnSightStep2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    const selectedTabIndex = 1; // Learn
    final headerColor = AppTheme.teal;

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
      body: Column(
        children: [
          Container(
            height: 86,
            width: double.infinity,
            color: headerColor,
            child: SafeArea(
              bottom: false,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, Routes.learnSightStep1),
                    icon: const Icon(Icons.arrow_back_ios_rounded,
                        color: Colors.white),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.menu_book_rounded,
                      color: Colors.white, size: 26),
                  const SizedBox(width: 10),
                  Text(
                    'Learn',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 14, 18, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StepProgress(
                  totalSteps: 3,
                  currentStep: 2,
                  activeColor: headerColor,
                  inactiveColor: const Color(0xFFECECEC),
                  height: 10,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text(
                      'Step 2 of 3',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF9A9A9A),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '66%',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF4BD9CF),
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 220,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAEAEA),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.visibility_outlined,
                            size: 70, color: AppTheme.teal),
                        SizedBox(height: 10),
                        Text(
                          'Illustration',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF9A9A9A),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  Text(
                    'How Sight Works',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                          fontSize: 34,
                          color: const Color(0xFF2A2A2A),
                        ),
                  ),
                  const SizedBox(height: 14),
                  _HowStep(index: 1, text: 'Light enters your eye through the pupil.'),
                  _HowStep(index: 2, text: 'The lens focuses the light onto the retina.'),
                  _HowStep(index: 3, text: 'The retina sends signals to your brain!'),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 0, 18, 20),
            child: SizedBox(
              height: 58,
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
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, Routes.playPick),
                child: const Text(
                  'Next Step →',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HowStep extends StatelessWidget {
  final int index;
  final String text;

  const _HowStep({
    required this.index,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppTheme.teal.withOpacity(0.32),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '$index',
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                color: Color(0xFF0C9A93),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 17,
                color: Color(0xFF2A2A2A),
                fontWeight: FontWeight.w500,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

