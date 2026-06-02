import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../models/app_routes.dart';
import '../models/game_carry.dart';
import '../services/audio_service.dart';

class SoundMatchRound1Screen extends StatefulWidget {
  const SoundMatchRound1Screen({super.key});

  @override
  State<SoundMatchRound1Screen> createState() => _SoundMatchRound1ScreenState();
}

class _SoundMatchRound1ScreenState extends State<SoundMatchRound1Screen> {
  static const Color _headerColor = Color(0xFF53D2C7);
  static const Color _successColor = Color(0xFF45E6C1);
  static const Color _errorColor = Color(0xFFFF6B6B);

  final AudioPlayer _audioPlayer = AudioPlayer();
  final Random _random = Random();
  int _roundIndex = 0;
  int _score = 0;
  String? _selectedAnswer;
  late final List<_SoundQuestion> _questions;
  late final DateTime _startTime;

  // Full pool used for building distractor options
  static const List<_SoundOption> _answerPool = [
    _SoundOption(label: 'Dog',   icon: Icons.pets_rounded),
    _SoundOption(label: 'Bell',  icon: Icons.add_alarm_rounded),
    _SoundOption(label: 'Rain',  icon: Icons.water_drop_rounded),
    _SoundOption(label: 'Cat',   icon: Icons.cruelty_free_rounded),
    _SoundOption(label: 'Bird',  icon: Icons.flutter_dash_rounded),
    // Extra distractors
    _SoundOption(label: 'Piano', icon: Icons.piano_rounded),
    _SoundOption(label: 'Clock', icon: Icons.access_time_filled_rounded),
    _SoundOption(label: 'Train', icon: Icons.train_rounded),
    _SoundOption(label: 'Drum',  icon: Icons.album_rounded),
    _SoundOption(label: 'Phone', icon: Icons.phone_android_rounded),
  ];

  // Round 1 — 5 warm-up sounds
  static const List<_SoundItem> _round1Items = [
    _SoundItem(answer: 'Bell', assetPath: 'sounds/bell.mp3',
        prompt: 'Listen for the ringing sound.'),
    _SoundItem(answer: 'Dog',  assetPath: 'sounds/dog.mp3',
        prompt: 'Listen for the animal sound.'),
    _SoundItem(answer: 'Rain', assetPath: 'sounds/rain.mp3',
        prompt: 'Listen for the weather sound.'),
    _SoundItem(answer: 'Cat',  assetPath: 'sounds/cat.mp3',
        prompt: 'Listen for the soft animal sound.'),
    _SoundItem(answer: 'Bird', assetPath: 'sounds/bird.mp3',
        prompt: 'Listen for the chirping sound.'),
  ];

  _SoundQuestion get _currentQuestion => _questions[_roundIndex];
  bool get _answered => _selectedAnswer != null;
  bool get _isCorrect => _selectedAnswer == _currentQuestion.answer;

  @override
  void initState() {
    super.initState();
    _startTime = DateTime.now();
    _questions = _buildQuestions();
    Future.delayed(const Duration(milliseconds: 400), () {
      AudioService.instance.speak(
        'Round 1! Listen to each sound and tap the matching object. Let\'s warm up!',
      );
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  List<_SoundQuestion> _buildQuestions() {
    final shuffled = List<_SoundItem>.of(_round1Items)..shuffle(_random);
    return [
      for (final item in shuffled)
        _SoundQuestion(
          answer: item.answer,
          assetPath: item.assetPath,
          prompt: item.prompt,
          options: _buildOptionsFor(item.answer),
        ),
    ];
  }

  List<_SoundOption> _buildOptionsFor(String answer) {
    final correct = _answerPool.firstWhere((o) => o.label == answer);
    final distractors =
        _answerPool.where((o) => o.label != answer).toList()..shuffle(_random);
    return [correct, ...distractors.take(3)]..shuffle(_random);
  }

  Future<void> _playCurrentSound() async {
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(_currentQuestion.assetPath));
  }

  void _selectAnswer(String answer) {
    if (_answered) return;
    final correct = answer == _currentQuestion.answer;
    setState(() {
      _selectedAnswer = answer;
      if (correct) _score++;
    });
    if (correct) {
      AudioService.instance.speak('AWESOME! ${_currentQuestion.answer} makes that sound!');
    } else {
      AudioService.instance.speak('So close! It was ${_currentQuestion.answer}. Keep it up!');
    }
  }

  void _goToNext() {
    if (_roundIndex == _questions.length - 1) {
      Navigator.pushReplacementNamed(
        context,
        Routes.soundMatchRound2,
        arguments: GameCarry(
          scoreSoFar: _score * 100,
          correctSoFar: _score,
          totalSoFar: _questions.length,
          startTime: _startTime,
        ),
      );
      return;
    }
    setState(() {
      _roundIndex++;
      _selectedAnswer = null;
    });
    _playCurrentSound();
  }

  Future<void> _showQuitDialog() async {
    final quit = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('End Game?', style: TextStyle(fontWeight: FontWeight.w900)),
        content: const Text('Are you sure you want to quit? Your progress will be lost.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Keep Playing'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Quit'),
          ),
        ],
      ),
    );
    if (quit == true && mounted) {
      Navigator.pushReplacementNamed(context, Routes.playPick);
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = _currentQuestion;
    final isLast = _roundIndex == _questions.length - 1;

    return Scaffold(
      backgroundColor: const Color(0xFFE6FAFC),
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ──────────────────────────────────────────────────────
            Container(
              color: _headerColor,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 14, 8, 6),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Sound Match',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 26,
                                      fontWeight: FontWeight.w900)),
                              SizedBox(height: 2),
                              Text('Round 1 of 2',
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ),
                        const Icon(Icons.waves_rounded,
                            color: Colors.white, size: 24),
                        const SizedBox(width: 4),
                        IconButton(
                          onPressed: _showQuitDialog,
                          icon: const Icon(Icons.close_rounded,
                              color: Colors.white),
                          tooltip: 'End Game',
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 0, 18, 10),
                    child: Row(
                      children: [
                        Text(
                          'Question ${_roundIndex + 1} / ${_questions.length}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 15),
                        ),
                        const Spacer(),
                        const Icon(Icons.auto_awesome_rounded,
                            color: Color(0xFFFFD54A), size: 17),
                        const SizedBox(width: 6),
                        Text('$_score',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900)),
                      ],
                    ),
                  ),
                  LinearProgressIndicator(
                    value: (_roundIndex + 1) / _questions.length,
                    minHeight: 4,
                    backgroundColor: Colors.white.withValues(alpha: 0.24),
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Color(0xFFFFD54A)),
                  ),
                ],
              ),
            ),

            // ── Content ─────────────────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(18, 16, 18, 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Sound player card
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Row(
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(32),
                            onTap: _playCurrentSound,
                            child: Container(
                              width: 62,
                              height: 62,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: _headerColor,
                              ),
                              alignment: Alignment.center,
                              child: const Icon(Icons.play_arrow_rounded,
                                  size: 32, color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Tap play to hear the sound',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900,
                                        color: Color(0xFF2A2A2A))),
                                const SizedBox(height: 6),
                                Text(question.prompt,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF8A8A8A))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text('Which object makes this sound?',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF2A2A2A))),
                    const SizedBox(height: 6),
                    const Text('Tap the matching object.',
                        style: TextStyle(
                            color: Color(0xFF6A6A6A),
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: 14),
                    GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: 1.05,
                      children: [
                        for (final option in question.options)
                          _AnswerCard(
                            option: option,
                            selected: _selectedAnswer == option.label,
                            revealCorrect:
                                _answered && option.label == question.answer,
                            isWrongSelection: _selectedAnswer == option.label &&
                                option.label != question.answer,
                            onTap: () => _selectAnswer(option.label),
                          ),
                      ],
                    ),
                    if (_answered) ...[
                      const SizedBox(height: 16),
                      _FeedbackBanner(
                          correct: _isCorrect, answer: question.answer),
                      const SizedBox(height: 14),
                      SizedBox(
                        width: double.infinity,
                        height: 58,
                        child: ElevatedButton(
                          onPressed: _goToNext,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _headerColor,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28)),
                          ),
                          child: Text(
                            isLast ? 'Round 2 →' : 'Next Sound',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Reusable widgets (file-private) ──────────────────────────────────────────

class _FeedbackBanner extends StatelessWidget {
  final bool correct;
  final String answer;
  const _FeedbackBanner({required this.correct, required this.answer});

  @override
  Widget build(BuildContext context) {
    final color = correct
        ? _SoundMatchRound1ScreenState._successColor
        : _SoundMatchRound1ScreenState._errorColor;
    final message = correct
        ? 'Correct! $answer makes that sound.'
        : 'Good try! The answer is $answer.';
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Icon(correct ? Icons.check_rounded : Icons.lightbulb_rounded,
              color: Colors.white, size: 26),
          const SizedBox(width: 10),
          Expanded(
            child: Text(message,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 18)),
          ),
        ],
      ),
    );
  }
}

class _AnswerCard extends StatelessWidget {
  final _SoundOption option;
  final bool selected;
  final bool revealCorrect;
  final bool isWrongSelection;
  final VoidCallback onTap;

  const _AnswerCard({
    required this.option,
    required this.selected,
    required this.revealCorrect,
    required this.isWrongSelection,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final active = selected || revealCorrect;
    final color = isWrongSelection
        ? _SoundMatchRound1ScreenState._errorColor
        : active
            ? _SoundMatchRound1ScreenState._headerColor
            : Colors.white;

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: active || isWrongSelection ? color : const Color(0xFFE5E5E5),
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 14),
                  Icon(option.icon,
                      size: 44,
                      color: active || isWrongSelection
                          ? Colors.white
                          : const Color(0xFF2A2A2A)),
                  const SizedBox(height: 12),
                  Text(option.label,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: active || isWrongSelection
                              ? Colors.white
                              : const Color(0xFF2A2A2A))),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            if (selected || revealCorrect)
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  width: 26,
                  height: 26,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  alignment: Alignment.center,
                  child: Icon(
                    isWrongSelection
                        ? Icons.close_rounded
                        : Icons.check_rounded,
                    color: isWrongSelection
                        ? _SoundMatchRound1ScreenState._errorColor
                        : _SoundMatchRound1ScreenState._headerColor,
                    size: 18,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ── Data models ───────────────────────────────────────────────────────────────

class _SoundQuestion {
  final String answer;
  final String assetPath;
  final String prompt;
  final List<_SoundOption> options;
  const _SoundQuestion(
      {required this.answer,
      required this.assetPath,
      required this.prompt,
      required this.options});
}

class _SoundItem {
  final String answer;
  final String assetPath;
  final String prompt;
  const _SoundItem(
      {required this.answer,
      required this.assetPath,
      required this.prompt});
}

class _SoundOption {
  final String label;
  final IconData icon;
  const _SoundOption({required this.label, required this.icon});
}
