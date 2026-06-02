import 'package:flutter/material.dart';

import '../models/app_routes.dart';
import '../services/audio_service.dart';
import '../theme/app_theme.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/five_senses_scaffold.dart';
import '../widgets/step_progress.dart';

class LearnTouchScreen extends StatefulWidget {
  const LearnTouchScreen({super.key});

  @override
  State<LearnTouchScreen> createState() => _LearnTouchScreenState();
}

class _LearnTouchScreenState extends State<LearnTouchScreen> {
  int _step = 0;

  static const _headerColor = Color(0xFFFF7A3B);

  static const _steps = [
    _StepData(
      title: 'What is Touch?',
      icon: Icons.pan_tool_outlined,
      iconBg: Color(0xFFFFF0E8),
      narrative:
          'Your skin is your body\'s largest organ and it is covered in '
          'millions of tiny sensors. Touch lets you feel the world — from a '
          'gentle breeze to a warm hug!',
      facts: [
        _Fact(Icons.sensors_outlined,
            'Your skin has about 4 million pain receptors across your body'),
        _Fact(Icons.baby_changing_station_outlined,
            'Touch is the very first sense to develop in the womb'),
        _Fact(Icons.fingerprint_outlined,
            'A single fingertip has up to 3,000 touch receptors'),
      ],
      tts:
          'What is touch? Your skin is your body\'s largest organ with millions of sensors. Touch is the very first sense you develop, and a single fingertip has up to 3 thousand touch receptors!',
    ),
    _StepData(
      title: 'How Your Skin Works',
      icon: Icons.layers_outlined,
      iconBg: Color(0xFFFBEBE0),
      narrative:
          'Your skin has several different types of sensors that each detect '
          'something different — pressure, temperature, vibration and pain. '
          'They all send information to your brain together.',
      facts: [
        _Fact(Icons.thermostat_outlined,
            'Different receptors sense pressure, heat, cold and pain'),
        _Fact(Icons.bolt_outlined,
            'Nerve signals from your fingertips reach your brain in 0.02 seconds'),
        _Fact(Icons.adjust_outlined,
            'Your lips and fingertips are the most sensitive parts of your body'),
      ],
      tts:
          'How does touch work? Your skin has different receptors for pressure, heat, cold and pain. Signals from your fingertips reach your brain in just 0.02 seconds — faster than you can blink!',
    ),
    _StepData(
      title: 'Amazing Touch Facts',
      icon: Icons.star_outline_rounded,
      iconBg: Color(0xFFFFF8E1),
      narrative:
          'Your sense of touch keeps you safe, helps you explore and even '
          'affects your mood. Here are some jaw-dropping facts about your '
          'incredible sense of touch!',
      facts: [
        _Fact(Icons.straighten_outlined,
            'Your fingertips can feel a bump as tiny as 0.006 mm high'),
        _Fact(Icons.device_thermostat_outlined,
            'Temperature receptors protect you from burns and frostbite'),
        _Fact(Icons.favorite_outlined,
            'Human touch releases oxytocin — the feel-good happiness hormone'),
      ],
      tts:
          'Amazing touch facts! Your fingertips can feel bumps as tiny as 0.006 millimetres, and touching someone releases oxytocin — the feel-good hormone that makes us happy and calm!',
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
      Navigator.pushReplacementNamed(context, Routes.touchDetail);
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
                    'Learn: Touch',
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
                          color: Color(0xFF9A9A9A)),
                    ),
                    const Spacer(),
                    Text(
                      '$pct%',
                      style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Color(0xFFFF7A3B)),
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
                  accentColor: _headerColor),
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
                    shape: BoxShape.circle, color: accentColor),
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
