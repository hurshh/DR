import 'package:flutter/material.dart';

import '../models/app_routes.dart';
import '../services/audio_service.dart';
import '../theme/app_theme.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/five_senses_scaffold.dart';
import '../widgets/step_progress.dart';

class LearnSightScreen extends StatefulWidget {
  const LearnSightScreen({super.key});

  @override
  State<LearnSightScreen> createState() => _LearnSightScreenState();
}

class _LearnSightScreenState extends State<LearnSightScreen> {
  int _step = 0; // 0-based index

  static const _headerColor = AppTheme.teal;

  static const _steps = [
    _StepData(
      title: 'What is Sight?',
      icon: Icons.visibility_outlined,
      iconBg: Color(0xFFDFF5F4),
      narrative:
          'Your eyes are incredible organs that let you experience the world. '
          'They detect light and send information to your brain so you can see everything around you.',
      facts: [
        _Fact(Icons.color_lens_outlined, 'You can see over 10 million different colors'),
        _Fact(Icons.wb_sunny_outlined, 'Your eyes adjust to light in less than a second'),
        _Fact(Icons.remove_red_eye_outlined, 'Each eye has over 120 million light-sensing cells'),
      ],
      tts: 'What is sight? Your eyes are incredible organs! They can see over 10 million different colors and adjust to light in less than a second!',
    ),
    _StepData(
      title: 'How Your Eye Works',
      icon: Icons.center_focus_strong_outlined,
      iconBg: Color(0xFFE8F4FD),
      narrative:
          'Seeing is a fascinating process that happens in a split second. '
          'Your eye and brain work as a team to create the images you see.',
      facts: [
        _Fact(Icons.circle_outlined, 'Light enters your eye through the pupil'),
        _Fact(Icons.lens_outlined, 'The lens focuses the light onto the retina'),
        _Fact(Icons.bolt_outlined, 'The retina sends signals to your brain at lightning speed'),
      ],
      tts: 'How does your eye work? Light enters through your pupil, your lens focuses it onto the retina, and your brain creates the image instantly!',
    ),
    _StepData(
      title: 'Amazing Eye Facts',
      icon: Icons.star_outline_rounded,
      iconBg: Color(0xFFFFF8E1),
      narrative:
          'Your eyes are one of nature\'s greatest wonders. '
          'Here are some jaw-dropping facts that show just how powerful they really are!',
      facts: [
        _Fact(Icons.flare_outlined, 'You can spot a candle flame from 14 miles away'),
        _Fact(Icons.cached_outlined, 'You blink about 15,000 times every single day'),
        _Fact(Icons.speed_outlined, 'Your eyes can process 36,000 pieces of info per hour'),
      ],
      tts: 'Amazing eye facts! You can spot a candle flame from 14 miles away, and your eyes process 36 thousand pieces of information every hour. Incredible!',
    ),
  ];

  void _speak() {
    AudioService.instance.speak(_steps[_step].tts);
  }

  void _next(BuildContext context) {
    AudioService.instance.stop();
    if (_step < _steps.length - 1) {
      setState(() => _step++);
      Future.delayed(const Duration(milliseconds: 300), _speak);
    } else {
      Navigator.pushReplacementNamed(context, Routes.playPick);
    }
  }

  void _back(BuildContext context) {
    AudioService.instance.stop();
    if (_step > 0) {
      setState(() => _step--);
      Future.delayed(const Duration(milliseconds: 300), _speak);
    } else {
      Navigator.pushReplacementNamed(context, Routes.sightDetail);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 400), _speak);
  }

  @override
  void dispose() {
    AudioService.instance.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = _steps[_step];
    final totalSteps = _steps.length;
    final pct = ((_step + 1) / totalSteps * 100).round();

    return FiveSensesScaffold(
      selectedTabIndex: 1,
      onBottomNavTap: (tab) {
        AudioService.instance.stop();
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
          // Header
          Container(
            height: 86,
            width: double.infinity,
            color: _headerColor,
            child: SafeArea(
              bottom: false,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => _back(context),
                    icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.menu_book_rounded, color: Colors.white, size: 26),
                  const SizedBox(width: 10),
                  Text(
                    'Learn: Sight',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  const Spacer(),
                  // Replay audio button
                  IconButton(
                    onPressed: _speak,
                    icon: const Icon(Icons.volume_up_rounded, color: Colors.white),
                    tooltip: 'Listen again',
                  ),
                ],
              ),
            ),
          ),

          // Progress bar
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 14, 18, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StepProgress(
                  totalSteps: totalSteps,
                  currentStep: _step + 1,
                  activeColor: _headerColor,
                  inactiveColor: const Color(0xFFECECEC),
                  height: 10,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'Step ${_step + 1} of $totalSteps',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF9A9A9A),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '$pct%',
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF4BD9CF),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.08, 0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              ),
              child: _StepContent(key: ValueKey(_step), data: data),
            ),
          ),

          // Next button
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 0, 18, 20),
            child: SizedBox(
              height: 58,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _headerColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),
                onPressed: () => _next(context),
                child: Text(
                  _step < _steps.length - 1 ? 'Next →' : 'Start Playing!',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StepContent extends StatelessWidget {
  final _StepData data;
  const _StepContent({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(18, 0, 18, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Illustration card
          Container(
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              color: data.iconBg,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Container(
                width: 96,
                height: 96,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.teal,
                ),
                alignment: Alignment.center,
                child: Icon(data.icon, size: 50, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 22),

          // Title
          Text(
            data.title,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: const Color(0xFF2A2A2A),
                ),
          ),
          const SizedBox(height: 10),

          // Narrative
          Text(
            data.narrative,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF666666),
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 18),

          // Fact cards
          ...data.facts.map((f) => _FactCard(fact: f)),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _FactCard extends StatelessWidget {
  final _Fact fact;
  const _FactCard({super.key, required this.fact});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppTheme.teal.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(fact.icon, color: AppTheme.teal, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              fact.text,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF2A2A2A),
                fontWeight: FontWeight.w600,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StepData {
  final String title;
  final IconData icon;
  final Color iconBg;
  final String narrative;
  final List<_Fact> facts;
  final String tts;

  const _StepData({
    required this.title,
    required this.icon,
    required this.iconBg,
    required this.narrative,
    required this.facts,
    required this.tts,
  });
}

class _Fact {
  final IconData icon;
  final String text;
  const _Fact(this.icon, this.text);
}
