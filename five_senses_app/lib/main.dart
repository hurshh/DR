import 'package:flutter/material.dart';

import 'models/app_routes.dart';
import 'screens/game_result_screen.dart';
import 'screens/home_screen.dart';
import 'screens/learn_sight_step_1_screen.dart';
import 'screens/learn_sight_step_2_screen.dart';
import 'screens/our_five_senses_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/practice_question_2_screen.dart';
import 'screens/play_pick_screen.dart';
import 'screens/sight_detail_screen.dart';
import 'screens/smell_sorter_intro_screen.dart';
import 'screens/smell_sorter_question_3_screen.dart';
import 'screens/sound_match_intro_screen.dart';
import 'screens/sound_match_round_2_screen.dart';
import 'screens/spot_difference_result_screen.dart';
import 'screens/taste_classifier_intro_screen.dart';
import 'screens/taste_classifier_question_4_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const FiveSensesApp());
}

class FiveSensesApp extends StatelessWidget {
  const FiveSensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Five Senses',
      theme: AppTheme.light(),
      initialRoute: Routes.onboarding,
      routes: {
        Routes.onboarding: (_) => const OnboardingScreen(),
        Routes.home: (_) => const HomeScreen(),
        Routes.ourFiveSenses: (_) => const OurFiveSensesScreen(),
        Routes.sightDetail: (_) => const SightDetailScreen(),
        Routes.learnSightStep1: (_) => const LearnSightStep1Screen(),
        Routes.learnSightStep2: (_) => const LearnSightStep2Screen(),
        Routes.playPick: (_) => const PlayPickScreen(),
        Routes.practiceQuestion2: (_) => const PracticeQuestion2Screen(),
        Routes.spotDifferenceResult: (_) => const SpotDifferenceResultScreen(),
        Routes.soundMatchIntro: (_) => const SoundMatchIntroScreen(),
        Routes.soundMatchRound2: (_) => const SoundMatchRound2Screen(),
        Routes.smellSorterIntro: (_) => const SmellSorterIntroScreen(),
        Routes.smellSorterQuestion3: (_) => const SmellSorterQuestion3Screen(),
        Routes.tasteClassifierIntro: (_) => const TasteClassifierIntroScreen(),
        Routes.tasteClassifierQuestion4: (_) => const TasteClassifierQuestion4Screen(),
        Routes.gameResult: (_) => const GameResultScreen(),
      },
    );
  }
}


