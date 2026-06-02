import 'package:flutter/material.dart';

import '../models/app_routes.dart';
import '../services/audio_service.dart';
import '../theme/app_theme.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/five_senses_scaffold.dart';
import '../widgets/step_progress.dart';

class LearnHearingScreen extends StatefulWidget {
  const LearnHearingScreen({super.key});

  @override
  State<LearnHearingScreen> createState() => _LearnHearingScreenState();
}

class _LearnHearingScreenState extends State<LearnHearingScreen> {
  int _step = 0;

  static const _headerColor = Color(0xFF57C8C6);

  static const _steps = [
    _StepData(
      title: 'What is Hearing?',
      icon: Icons.hearing_outlined,
      iconBg: Color(0xFFDFF5F4),
      narrative:
          'Your ears are incredible sound detectors that let you experience '
          'the whole world of sound. They pick up tiny vibrations in the air '
          'and send them to your brain instantly.',
      facts: [
        _Fact(Icons.surround_sound_outlined,
            'You can hear sounds from many directions at the same time'),
        _Fact(Icons.self_improvement_outlined,
            'Your ears also help you keep your balance every day'),
        _Fact(Icons.speed_outlined,
            'Sound travels at 343 metres per second through air'),
      ],
      tts:
          'What is hearing? Your ears are incredible! They pick up tiny vibrations in the air and send them to your brain instantly. They can even detect sounds from all directions at once!',
    ),
    _StepData(
      title: 'How Your Ear Works',
      icon: Icons.graphic_eq_outlined,
      iconBg: Color(0xFFE8F4FD),
      narrative:
          'Hearing happens in three amazing stages inside your ear. Your '
          'outer ear, middle ear and inner ear all work as a perfect team '
          'in a fraction of a second.',
      facts: [
        _Fact(Icons.wifi_tethering_outlined,
            'Sound waves enter through your outer ear, the pinna'),
        _Fact(Icons.vibration_outlined,
            'The eardrum vibrates up to 20,000 times per second'),
        _Fact(Icons.bolt_outlined,
            'Tiny hair cells in the cochlea send signals to your brain'),
      ],
      tts:
          'How does your ear work? Sound enters your outer ear, makes your eardrum vibrate up to 20 thousand times per second, and tiny hair cells send signals to your brain — all in a fraction of a second!',
    ),
    _StepData(
      title: 'Amazing Ear Facts',
      icon: Icons.star_outline_rounded,
      iconBg: Color(0xFFFFF8E1),
      narrative:
          'Your ears are working every second of every day, even when you '
          'sleep. Here are some incredible facts that show just how powerful '
          'your sense of hearing really is!',
      facts: [
        _Fact(Icons.library_music_outlined,
            'Humans can recognise up to 400,000 different sounds'),
        _Fact(Icons.my_location_outlined,
            'You detect the direction of a sound in just 0.0006 seconds'),
        _Fact(Icons.clean_hands_outlined,
            'Ears are self-cleaning — wax traps dust and germs naturally'),
      ],
      tts:
          'Amazing ear facts! Humans can recognise up to 400 thousand different sounds and detect which direction they come from in less than a millisecond. Your ears are always on duty — even while you sleep!',
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
      Navigator.pushReplacementNamed(context, Routes.hearingDetail);
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
                    icon: const Icon(Icons.arrow_back_ios_rounded,
                        color: Colors.white),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.menu_book_rounded,
                      color: Colors.white, size: 26),
                  const SizedBox(width: 10),
                  Text(
                    'Learn: Hearing',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: _speak,
                    icon: const Icon(Icons.volume_up_rounded,
                        color: Colors.white),
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
                        color: Color(0xFF57C8C6),
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
              child: _StepContent(
                  key: ValueKey(_step), data: data, accentColor: _headerColor),
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
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Shared step widgets ───────────────────────────────────────────────────────

class _StepContent extends StatelessWidget {
  final _StepData data;
  final Color accentColor;
  const _StepContent(
      {super.key, required this.data, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(18, 0, 18, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: accentColor,
                ),
                alignment: Alignment.center,
                child: Icon(data.icon, size: 50, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 22),
          Text(
            data.title,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: const Color(0xFF2A2A2A),
                ),
          ),
          const SizedBox(height: 10),
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
          ...data.facts.map((f) => _FactCard(fact: f, accentColor: accentColor)),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _FactCard extends StatelessWidget {
  final _Fact fact;
  final Color accentColor;
  const _FactCard({super.key, required this.fact, required this.accentColor});

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
              color: accentColor.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(fact.icon, color: accentColor, size: 22),
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
