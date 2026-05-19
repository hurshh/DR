import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../models/app_routes.dart';
import '../services/audio_service.dart';

class SoundMatchRound2Screen extends StatefulWidget {
  const SoundMatchRound2Screen({super.key});

  @override
  State<SoundMatchRound2Screen> createState() => _SoundMatchRound2ScreenState();
}

class _SoundMatchRound2ScreenState extends State<SoundMatchRound2Screen> {
  static const Color _headerColor = Color(0xFF53D2C7);
  static const Color _successColor = Color(0xFF45E6C1);
  static const Color _errorColor = Color(0xFFFF6B6B);

  final AudioPlayer _audioPlayer = AudioPlayer();
  final Random _random = Random();
  int _roundIndex = 0;
  int _score = 0;
  String? _selectedAnswer;
  late final List<_SoundQuestion> _questions;

  static const List<_SoundOption> _answerPool = [
    _SoundOption(label: 'Dog', icon: Icons.pets_rounded),
    _SoundOption(label: 'Bell', icon: Icons.add_alarm_rounded),
    _SoundOption(label: 'Rain', icon: Icons.water_drop_rounded),
    _SoundOption(label: 'Piano', icon: Icons.piano_rounded),
    _SoundOption(label: 'Cat', icon: Icons.cruelty_free_rounded),
    _SoundOption(label: 'Clock', icon: Icons.access_time_filled_rounded),
    _SoundOption(label: 'Train', icon: Icons.train_rounded),
    _SoundOption(label: 'Bird', icon: Icons.flutter_dash_rounded),
    _SoundOption(label: 'Drum', icon: Icons.album_rounded),
    _SoundOption(label: 'Phone', icon: Icons.phone_android_rounded),
  ];

  static const List<_SoundItem> _soundItems = [
    _SoundItem(
      answer: 'Bell',
      assetPath: 'sounds/bell.mp3',
      prompt: 'Listen for the ringing sound.',
    ),
    _SoundItem(
      answer: 'Dog',
      assetPath: 'sounds/dog.mp3',
      prompt: 'Listen for the animal sound.',
    ),
    _SoundItem(
      answer: 'Rain',
      assetPath: 'sounds/rain.mp3',
      prompt: 'Listen for the weather sound.',
    ),
    _SoundItem(
      answer: 'Piano',
      assetPath: 'sounds/piano.mp3',
      prompt: 'Listen for the music sound.',
    ),
    _SoundItem(
      answer: 'Cat',
      assetPath: 'sounds/cat.mp3',
      prompt: 'Listen for the soft animal sound.',
    ),
    _SoundItem(
      answer: 'Clock',
      assetPath: 'sounds/clock.mp3',
      prompt: 'Listen for the ticking sound.',
    ),
    _SoundItem(
      answer: 'Train',
      assetPath: 'sounds/train-modified.mp3',
      prompt: 'Listen for the moving vehicle sound.',
    ),
    _SoundItem(
      answer: 'Bird',
      assetPath: 'sounds/bird.mp3',
      prompt: 'Listen for the chirping sound.',
    ),
    _SoundItem(
      answer: 'Drum',
      assetPath: 'sounds/drum.mp3',
      prompt: 'Listen for the beat.',
    ),
    _SoundItem(
      answer: 'Phone',
      assetPath: 'sounds/phone.mp3',
      prompt: 'Listen for the ringing device.',
    ),
  ];

  _SoundQuestion get _currentQuestion => _questions[_roundIndex];
  bool get _answered => _selectedAnswer != null;
  bool get _isCorrect => _selectedAnswer == _currentQuestion.answer;

  @override
  void initState() {
    super.initState();
    _questions = _buildQuestions();
    Future.delayed(const Duration(milliseconds: 400), () {
      AudioService.instance.speak(
        "Welcome to Sound Match! Listen to each sound and tap the object that makes it. Good luck!",
      );
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  List<_SoundQuestion> _buildQuestions() {
    final shuffledItems = List<_SoundItem>.of(_soundItems)..shuffle(_random);

    return [
      for (final item in shuffledItems)
        _SoundQuestion(
          answer: item.answer,
          assetPath: item.assetPath,
          prompt: item.prompt,
          options: _buildOptionsFor(item.answer),
        ),
    ];
  }

  List<_SoundOption> _buildOptionsFor(String answer) {
    final correctOption = _answerPool.firstWhere(
      (option) => option.label == answer,
    );
    final distractors =
        _answerPool.where((option) => option.label != answer).toList()
          ..shuffle(_random);

    return [correctOption, ...distractors.take(3)]..shuffle(_random);
  }

  Future<void> _playCurrentSound() async {
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(_currentQuestion.assetPath));
  }

  void _selectAnswer(String answer) {
    if (_answered) {
      return;
    }

    final correct = answer == _currentQuestion.answer;
    setState(() {
      _selectedAnswer = answer;
      if (correct) {
        _score += 1;
      }
    });
    if (correct) {
      AudioService.instance.speak("AWESOME! ${_currentQuestion.answer} makes that sound!");
    } else {
      AudioService.instance.speak("So close! It was ${_currentQuestion.answer}. Keep it up!");
    }
  }

  void _goToNextRound() {
    if (_roundIndex == _questions.length - 1) {
      Navigator.pushReplacementNamed(context, Routes.gameResult);
      return;
    }

    setState(() {
      _roundIndex += 1;
      _selectedAnswer = null;
    });
    _playCurrentSound();
  }

  @override
  Widget build(BuildContext context) {
    final question = _currentQuestion;

    return Scaffold(
      backgroundColor: const Color(0xFFE6FAFC),
      body: SafeArea(
        child: Column(
          children: [
            _GameHeader(
              round: _roundIndex + 1,
              totalRounds: _questions.length,
              score: _score,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(18, 16, 18, 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SoundPlayerCard(
                      prompt: question.prompt,
                      onPlaySound: _playCurrentSound,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Which object makes this sound?',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF2A2A2A),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Tap the matching object.',
                      style: TextStyle(
                        color: Color(0xFF2A2A2A),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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
                            isWrongSelection:
                                _selectedAnswer == option.label &&
                                option.label != question.answer,
                            onTap: () => _selectAnswer(option.label),
                          ),
                      ],
                    ),
                    if (_answered) ...[
                      const SizedBox(height: 16),
                      _FeedbackBanner(
                        correct: _isCorrect,
                        answer: question.answer,
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        width: double.infinity,
                        height: 58,
                        child: ElevatedButton(
                          onPressed: _goToNextRound,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _headerColor,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                          ),
                          child: Text(
                            _roundIndex == _questions.length - 1
                                ? 'See Results'
                                : 'Next Round',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
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

Future<void> _showQuitDialog(BuildContext context) async {
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
  if (quit == true && context.mounted) {
    Navigator.pushReplacementNamed(context, Routes.playPick);
  }
}

class _GameHeader extends StatelessWidget {
  final int round;
  final int totalRounds;
  final int score;

  const _GameHeader({
    required this.round,
    required this.totalRounds,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      color: _SoundMatchRound2ScreenState._headerColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 14, 8, 10),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Sound Match',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const Icon(Icons.waves_rounded, color: Colors.white, size: 26),
                const SizedBox(width: 4),
                IconButton(
                  onPressed: () => _showQuitDialog(context),
                  icon: const Icon(Icons.close_rounded, color: Colors.white),
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
                  'Round $round / $totalRounds',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.auto_awesome_rounded,
                  color: Color(0xFFFFD54A),
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  '$score',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          LinearProgressIndicator(
            value: round / totalRounds,
            minHeight: 4,
            backgroundColor: Colors.white.withValues(alpha: 0.24),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFFD54A)),
          ),
        ],
      ),
    );
  }
}

class _SoundPlayerCard extends StatelessWidget {
  final String prompt;
  final VoidCallback onPlaySound;

  const _SoundPlayerCard({required this.prompt, required this.onPlaySound});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(32),
            onTap: onPlaySound,
            child: Container(
              width: 62,
              height: 62,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: _SoundMatchRound2ScreenState._headerColor,
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.play_arrow_rounded,
                size: 32,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tap play to hear the sound',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF2A2A2A),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  prompt,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF8A8A8A),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FeedbackBanner extends StatelessWidget {
  final bool correct;
  final String answer;

  const _FeedbackBanner({required this.correct, required this.answer});

  @override
  Widget build(BuildContext context) {
    final color = correct
        ? _SoundMatchRound2ScreenState._successColor
        : _SoundMatchRound2ScreenState._errorColor;
    final message = correct
        ? 'Correct! $answer makes that sound.'
        : 'Good try! The answer is $answer.';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(
            correct ? Icons.check_rounded : Icons.lightbulb_rounded,
            color: Colors.white,
            size: 26,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 18,
              ),
            ),
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
        ? _SoundMatchRound2ScreenState._errorColor
        : active
        ? _SoundMatchRound2ScreenState._headerColor
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
                  Icon(
                    option.icon,
                    size: 44,
                    color: active || isWrongSelection
                        ? Colors.white
                        : const Color(0xFF2A2A2A),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    option.label,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: active || isWrongSelection
                          ? Colors.white
                          : const Color(0xFF2A2A2A),
                    ),
                  ),
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
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    isWrongSelection
                        ? Icons.close_rounded
                        : Icons.check_rounded,
                    color: isWrongSelection
                        ? _SoundMatchRound2ScreenState._errorColor
                        : _SoundMatchRound2ScreenState._headerColor,
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

class _SoundQuestion {
  final String answer;
  final String assetPath;
  final String prompt;
  final List<_SoundOption> options;

  const _SoundQuestion({
    required this.answer,
    required this.assetPath,
    required this.prompt,
    required this.options,
  });
}

class _SoundItem {
  final String answer;
  final String assetPath;
  final String prompt;

  const _SoundItem({
    required this.answer,
    required this.assetPath,
    required this.prompt,
  });
}

class _SoundOption {
  final String label;
  final IconData icon;

  const _SoundOption({required this.label, required this.icon});
}
