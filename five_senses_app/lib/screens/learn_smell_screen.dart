import 'package:flutter/material.dart';

import '../models/app_routes.dart';
import '../services/audio_service.dart';
import '../theme/app_theme.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/five_senses_scaffold.dart';
import '../widgets/step_progress.dart';

class LearnSmellScreen extends StatefulWidget {
  const LearnSmellScreen({super.key});

  @override
  State<LearnSmellScreen> createState() => _LearnSmellScreenState();
}

class _LearnSmellScreenState extends State<LearnSmellScreen> {
  int _step = 0;

  static const _headerColor = Color(0xFFF2D35B);
  static const _accentDark = Color(0xFF5C3D00);

  static const _steps = [
    _StepData(
      title: 'What is Smell?',
      icon: Icons.spa_outlined,
      iconBg: Color(0xFFFFF9E0),
      narrative:
          'Your nose is a super-powered sensor that can detect over a '
          'trillion different smells! Smell is one of the oldest and most '
          'powerful of all your five senses.',
      facts: [
        _Fact(Icons.search_outlined,
            'You can detect over 1 trillion different scents'),
        _Fact(Icons.favorite_border_outlined,
            'Smell is directly connected to memory and emotions in your brain'),
        _Fact(Icons.child_care_outlined,
            'Newborn babies can recognise their mother purely by smell'),
      ],
      tts:
          'What is smell? Your nose can detect over 1 trillion different scents and is directly linked to your memory and emotions. Even newborn babies recognise their mother just by smell!',
    ),
    _StepData(
      title: 'How Your Nose Works',
      icon: Icons.air_outlined,
      iconBg: Color(0xFFF0FDE8),
      narrative:
          'Smelling is a beautiful chemical process. Every time you breathe '
          'in, tiny scent molecules travel up your nose and trigger special '
          'cells that send a signal straight to your brain.',
      facts: [
        _Fact(Icons.science_outlined,
            'Scent molecules dissolve in nasal mucus and trigger receptors'),
        _Fact(Icons.psychology_outlined,
            'Signals go directly to your brain\'s emotion and memory centre'),
        _Fact(Icons.grain_outlined,
            'You smell best after rain — that earthy scent is called petrichor!'),
      ],
      tts:
          'How does your nose work? Scent molecules enter your nose, trigger special receptor cells, and send signals directly to the part of your brain that controls memory and emotion — all in an instant!',
    ),
    _StepData(
      title: 'Amazing Smell Facts',
      icon: Icons.star_outline_rounded,
      iconBg: Color(0xFFFFF8E1),
      narrative:
          'Your sense of smell is deeply connected to your feelings and '
          'memories. A single scent can instantly transport you back to a '
          'moment from years ago — that is real brain power!',
      facts: [
        _Fact(Icons.pets_outlined,
            'Dogs have 300 million smell receptors — humans have 6 million'),
        _Fact(Icons.history_outlined,
            'A familiar smell can unlock memories from decades ago'),
        _Fact(Icons.warning_amber_outlined,
            'You can smell danger — smoke, gas and bad food all have warning scents'),
      ],
      tts:
          'Amazing smell facts! While dogs have 300 million smell receptors, your 6 million are still powerful enough to unlock memories from decades ago and even warn you of danger!',
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
      Navigator.pushReplacementNamed(context, Routes.smellDetail);
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
                    icon: Icon(Icons.arrow_back_ios_rounded,
                        color: _accentDark),
                  ),
                  const SizedBox(width: 4),
                  Icon(Icons.menu_book_rounded,
                      color: _accentDark, size: 26),
                  const SizedBox(width: 10),
                  Text(
                    'Learn: Smell',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: _accentDark,
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: _speak,
                    icon: Icon(Icons.volume_up_rounded, color: _accentDark),
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
                  activeColor: _accentDark,
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
                          color: Color(0xFF9A9A9A)),
                    ),
                    const Spacer(),
                    Text(
                      '$pct%',
                      style: TextStyle(
                          fontWeight: FontWeight.w800, color: _accentDark),
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
                  key: ValueKey(_step),
                  data: data,
                  accentColor: _accentDark),
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
                  foregroundColor: _accentDark,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
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
                    color: const Color(0xFFF2D35B)),
                alignment: Alignment.center,
                child: Icon(data.icon, size: 50, color: accentColor),
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
          ...data.facts
              .map((f) => _FactCard(fact: f, accentColor: accentColor)),
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
              color: const Color(0xFFF2D35B).withOpacity(0.25),
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
