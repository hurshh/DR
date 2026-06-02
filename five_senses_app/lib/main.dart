import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'models/app_routes.dart';
import 'services/app_data_service.dart';
import 'screens/game_result_screen.dart';
import 'screens/hearing_detail_screen.dart';
import 'screens/home_screen.dart';
import 'screens/learn_hearing_screen.dart';
import 'screens/learn_sight_screen.dart';
import 'screens/learn_smell_screen.dart';
import 'screens/learn_taste_screen.dart';
import 'screens/learn_touch_screen.dart';
import 'screens/our_five_senses_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/play_pick_screen.dart';
import 'screens/sight_detail_screen.dart';
import 'screens/smell_detail_screen.dart';
import 'screens/smell_sorter_intro_screen.dart';
import 'screens/smell_sorter_question_1_screen.dart';
import 'screens/smell_sorter_question_2_screen.dart';
import 'screens/smell_sorter_question_3_screen.dart';
import 'screens/sound_match_intro_screen.dart';
import 'screens/sound_match_round_1_screen.dart';
import 'screens/sound_match_round_2_screen.dart';
import 'screens/spot_difference_result_screen.dart';
import 'screens/taste_classifier_intro_screen.dart';
import 'screens/taste_classifier_question_1_screen.dart';
import 'screens/taste_classifier_question_2_screen.dart';
import 'screens/taste_classifier_question_3_screen.dart';
import 'screens/taste_classifier_question_4_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/texture_match_game_screen.dart';
import 'screens/texture_match_intro_screen.dart';
import 'screens/taste_detail_screen.dart';
import 'screens/touch_detail_screen.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Load persisted data before the UI renders so reads are always synchronous.
  await AppDataService.instance.init();
  try {
    await AudioPlayer.global.setAudioContext(
      AudioContext(
        iOS: AudioContextIOS(
          category: AVAudioSessionCategory.playback,
          options: {AVAudioSessionOptions.defaultToSpeaker},
        ),
      ),
    );
  } catch (_) {}
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
      initialRoute: AppDataService.instance.userName.isEmpty
          ? Routes.onboarding
          : Routes.home,
      routes: {
        Routes.onboarding: (_) => const OnboardingScreen(),
        Routes.home: (_) => const HomeScreen(),
        Routes.ourFiveSenses: (_) => const OurFiveSensesScreen(),
        Routes.sightDetail: (_) => const SightDetailScreen(),
        Routes.learnSight: (_) => const LearnSightScreen(),
        Routes.playPick: (_) => const PlayPickScreen(),
        Routes.hearingDetail: (_) => const HearingDetailScreen(),
        Routes.learnHearing: (_) => const LearnHearingScreen(),
        Routes.smellDetail: (_) => const SmellDetailScreen(),
        Routes.learnSmell: (_) => const LearnSmellScreen(),
        Routes.tasteDetail: (_) => const TasteDetailScreen(),
        Routes.learnTaste: (_) => const LearnTasteScreen(),
        Routes.touchDetail: (_) => const TouchDetailScreen(),
        Routes.learnTouch: (_) => const LearnTouchScreen(),
        Routes.spotDifferenceResult: (_) => const SpotDifferenceResultScreen(),
        Routes.soundMatchIntro: (_) => const SoundMatchIntroScreen(),
        Routes.soundMatchRound2: (_) => const SoundMatchRound2Screen(),
        Routes.smellSorterIntro: (_) => const SmellSorterIntroScreen(),
        Routes.smellSorterQuestion1: (_) => const SmellSorterQuestion1Screen(),
        Routes.smellSorterQuestion2: (_) => const SmellSorterQuestion2Screen(),
        Routes.smellSorterQuestion3: (_) => const SmellSorterQuestion3Screen(),
        Routes.soundMatchRound1: (_) => const SoundMatchRound1Screen(),
        Routes.tasteClassifierIntro: (_) => const TasteClassifierIntroScreen(),
        Routes.tasteClassifierQuestion1: (_) => const TasteClassifierQuestion1Screen(),
        Routes.tasteClassifierQuestion2: (_) => const TasteClassifierQuestion2Screen(),
        Routes.tasteClassifierQuestion3: (_) => const TasteClassifierQuestion3Screen(),
        Routes.tasteClassifierQuestion4: (_) => const TasteClassifierQuestion4Screen(),
        Routes.textureMatchIntro: (_) => const TextureMatchIntroScreen(),
        Routes.textureMatchGame: (_) => const TextureMatchGameScreen(),
        Routes.gameResult: (_) => const GameResultScreen(),
        Routes.settings: (_) => const SettingsScreen(),
      },
    );
  }
}


