import 'dart:async';
import 'package:flutter/material.dart';

import '../models/app_routes.dart';
import '../services/audio_service.dart';

// ─── Data models ─────────────────────────────────────────────────────────────

class _FoodItem {
  final String name;
  final String emoji;
  final String correctTaste;
  final Color cardBg;
  final String funFact;

  const _FoodItem({
    required this.name,
    required this.emoji,
    required this.correctTaste,
    required this.cardBg,
    required this.funFact,
  });
}

class _TasteDef {
  final String label;
  final String subtitle;
  final Color color;
  final Color lightBg;
  final String emoji;

  const _TasteDef({
    required this.label,
    required this.subtitle,
    required this.color,
    required this.lightBg,
    required this.emoji,
  });
}

// ─── Game content ─────────────────────────────────────────────────────────────

const List<_FoodItem> _foods = [
  _FoodItem(
    name: 'Lemon',
    emoji: '🍋',
    correctTaste: 'Sour',
    cardBg: Color(0xFFFFFDE7),
    funFact: 'Lemon is one of the SOUREST fruits on Earth!',
  ),
  _FoodItem(
    name: 'Strawberry',
    emoji: '🍓',
    correctTaste: 'Sweet',
    cardBg: Color(0xFFFFEBEE),
    funFact: 'Strawberries are packed with natural sugar — that\'s why they\'re SWEET!',
  ),
  _FoodItem(
    name: 'Chips',
    emoji: '🍟',
    correctTaste: 'Salty',
    cardBg: Color(0xFFFFF8E1),
    funFact: 'Salt makes chips super crispy and SALTY by design!',
  ),
  _FoodItem(
    name: 'Coffee',
    emoji: '☕',
    correctTaste: 'Bitter',
    cardBg: Color(0xFFEFEBE9),
    funFact: 'Caffeine in coffee is what makes it taste BITTER!',
  ),
  _FoodItem(
    name: 'Watermelon',
    emoji: '🍉',
    correctTaste: 'Sweet',
    cardBg: Color(0xFFFCE4EC),
    funFact: 'Watermelon is 92% water and bursting with SWEETNESS!',
  ),
  _FoodItem(
    name: 'Lime',
    emoji: '🍈',
    correctTaste: 'Sour',
    cardBg: Color(0xFFF1F8E9),
    funFact: 'Lime juice is even SOURER than lemon juice!',
  ),
  _FoodItem(
    name: 'Pretzel',
    emoji: '🥨',
    correctTaste: 'Salty',
    cardBg: Color(0xFFFBE9E7),
    funFact: 'Pretzels are dipped in salty water before baking — SALTY to the core!',
  ),
  _FoodItem(
    name: 'Dark Chocolate',
    emoji: '🍫',
    correctTaste: 'Bitter',
    cardBg: Color(0xFFEDE7F6),
    funFact: 'More cocoa = more BITTER. Dark chocolate is 70%+ cocoa!',
  ),
  _FoodItem(
    name: 'Honey',
    emoji: '🍯',
    correctTaste: 'Sweet',
    cardBg: Color(0xFFFFF3E0),
    funFact: 'Honey is one of the SWEETEST natural foods — made by bees! 🐝',
  ),
  _FoodItem(
    name: 'Soy Sauce',
    emoji: '🫙',
    correctTaste: 'Salty',
    cardBg: Color(0xFFE8F5E9),
    funFact: 'Soy sauce is fermented with lots of salt — super SALTY!',
  ),
];

const List<_TasteDef> _tastes = [
  _TasteDef(
    label: 'Sweet',
    subtitle: 'Tip of tongue',
    color: Color(0xFFFF5F8D),
    lightBg: Color(0xFFFFEBF0),
    emoji: '🍓',
  ),
  _TasteDef(
    label: 'Sour',
    subtitle: 'Sides of tongue',
    color: Color(0xFFFFAB00),
    lightBg: Color(0xFFFFF8E1),
    emoji: '🍋',
  ),
  _TasteDef(
    label: 'Salty',
    subtitle: 'Front sides',
    color: Color(0xFF00ACC1),
    lightBg: Color(0xFFE0F7FA),
    emoji: '🍟',
  ),
  _TasteDef(
    label: 'Bitter',
    subtitle: 'Back of tongue',
    color: Color(0xFF7C4DFF),
    lightBg: Color(0xFFEDE7F6),
    emoji: '☕',
  ),
];

// ─── Screen ──────────────────────────────────────────────────────────────────

class TasteClassifierQuestion4Screen extends StatefulWidget {
  const TasteClassifierQuestion4Screen({super.key});

  @override
  State<TasteClassifierQuestion4Screen> createState() =>
      _TasteClassifierQuestion4ScreenState();
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

class _TasteClassifierQuestion4ScreenState
    extends State<TasteClassifierQuestion4Screen> {
  static const _headerColor = Color(0xFF6A59E0);
  static const _totalSeconds = 90;

  int _currentIndex = 0;
  String? _selectedTaste;
  bool _showFeedback = false;
  bool _isCorrect = false;
  int _score = 0;
  int _lives = 5;
  int _secondsLeft = _totalSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
    Future.delayed(const Duration(milliseconds: 400), () {
      AudioService.instance.speak(
        "Welcome to Taste Classifier! Look at each food and pick if it tastes Sweet, Sour, Salty, or Bitter. You have 5 lives and 90 seconds. Let's go!",
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      if (_secondsLeft <= 0) {
        t.cancel();
        _navigateToResult();
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  void _onTasteTapped(_TasteDef taste) {
    if (_showFeedback || _lives <= 0) return;
    final correct = taste.label == _foods[_currentIndex].correctTaste;
    setState(() {
      _selectedTaste = taste.label;
      _showFeedback = true;
      _isCorrect = correct;
      if (correct) {
        _score += 200;
      } else {
        _lives = (_lives - 1).clamp(0, 5);
        if (_lives == 0) _timer?.cancel();
      }
    });
    if (correct) {
      AudioService.instance.speak("Nailed it!");
    } else {
      AudioService.instance.speak("Not quite! You've got this!");
    }
  }

  void _onNext() {
    if (_lives <= 0 || _currentIndex >= _foods.length - 1) {
      _navigateToResult();
      return;
    }
    setState(() {
      _currentIndex++;
      _selectedTaste = null;
      _showFeedback = false;
      _isCorrect = false;
    });
  }

  void _navigateToResult() {
    _timer?.cancel();
    Navigator.pushReplacementNamed(context, Routes.gameResult);
  }

  String get _timerLabel {
    final m = _secondsLeft ~/ 60;
    final s = _secondsLeft % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }

  Color get _timerColor {
    if (_secondsLeft > 30) return Colors.white;
    if (_secondsLeft > 10) return const Color(0xFFFFD54A);
    return const Color(0xFFFF7C93);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.shortestSide >= 600;
    final food = _foods[_currentIndex];

    final headerH = isTablet ? 180.0 : 150.0;
    final contentPad = isTablet ? 24.0 : 18.0;
    final maxW = isTablet ? 680.0 : double.infinity;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F0FF),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(isTablet, headerH),
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxW),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(
                        contentPad, 16, contentPad, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'How does this food taste?',
                          style: TextStyle(
                            fontSize: isTablet ? 22 : 18,
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF2A2A2A),
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildFoodCard(food, isTablet),
                        const SizedBox(height: 12),
                        Text(
                          'Tap the taste it belongs to 👇',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFB7B7B7),
                            fontSize: isTablet ? 17 : 15,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildTasteGrid(food, isTablet),
                        const SizedBox(height: 14),
                        if (_showFeedback) ...[
                          _buildFeedbackBanner(food, isTablet),
                          const SizedBox(height: 14),
                          _buildNextButton(isTablet),
                        ] else
                          _buildLivesRow(isTablet),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Header ────────────────────────────────────────────────────────────────

  Widget _buildHeader(bool isTablet, double headerH) {
    final progress = (_currentIndex + 1) / _foods.length;
    return Container(
      height: headerH,
      width: double.infinity,
      color: _headerColor,
      child: Stack(
        children: [
          // Title row
          Padding(
            padding: EdgeInsets.fromLTRB(8, isTablet ? 26 : 18, 18, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => Navigator.pushReplacementNamed(
                      context, Routes.tasteClassifierIntro),
                  icon: const Icon(Icons.arrow_back_ios_rounded,
                      color: Colors.white, size: 22),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(width: 6),
                Text(
                  'Taste Classifier',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: isTablet ? 28 : 22,
                  ),
                ),
                const Spacer(),
                // Timer
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 300),
                  style: TextStyle(
                    color: _timerColor,
                    fontWeight: FontWeight.w900,
                    fontSize: isTablet ? 18 : 15,
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.timer_outlined,
                          color: _timerColor, size: isTablet ? 22 : 18),
                      const SizedBox(width: 4),
                      Text(_timerLabel),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // Score
                Row(
                  children: [
                    Icon(Icons.auto_awesome_rounded,
                        color: const Color(0xFFFFD54A),
                        size: isTablet ? 22 : 18),
                    const SizedBox(width: 4),
                    Text(
                      '$_score',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: isTablet ? 18 : 15,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () => _showQuitDialog(context),
                  icon: const Icon(Icons.close_rounded, color: Colors.white),
                  tooltip: 'End Game',
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          // Progress label
          Positioned(
            left: 18,
            bottom: 22,
            child: Text(
              'Food ${_currentIndex + 1} of ${_foods.length}',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.9),
                fontWeight: FontWeight.w700,
                fontSize: isTablet ? 16 : 14,
              ),
            ),
          ),
          // Progress bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 5,
              backgroundColor: Colors.white.withValues(alpha: 0.25),
              valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFFFFD54A)),
            ),
          ),
        ],
      ),
    );
  }

  // ── Food card ─────────────────────────────────────────────────────────────

  Widget _buildFoodCard(_FoodItem food, bool isTablet) {
    final emojiFs = isTablet ? 72.0 : 58.0;
    final nameFs = isTablet ? 26.0 : 20.0;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isTablet ? 30 : 22,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: food.cardBg,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 14,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(food.emoji, style: TextStyle(fontSize: emojiFs)),
          const SizedBox(height: 10),
          Text(
            food.name,
            style: TextStyle(
              fontSize: nameFs,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF2A2A2A),
            ),
          ),
        ],
      ),
    );
  }

  // ── Taste option grid ──────────────────────────────────────────────────────

  Widget _buildTasteGrid(_FoodItem food, bool isTablet) {
    // On tablet: 4 columns (single row), on phone: 2x2 grid
    final colCount = isTablet ? 4 : 2;
    final iconFs = isTablet ? 28.0 : 26.0;
    final labelFs = isTablet ? 17.0 : 17.0;
    final subtitleFs = isTablet ? 12.0 : 12.0;
    // childAspectRatio = width / height
    // Phone: ~171pt wide → 0.9 → ~190pt tall (fits emoji + label + subtitle)
    // Tablet: ~148pt wide → 0.75 → ~197pt tall
    final aspectRatio = isTablet ? 0.75 : 0.9;

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: colCount,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: aspectRatio,
      ),
      itemCount: _tastes.length,
      itemBuilder: (_, i) {
        final taste = _tastes[i];
        final isSelected = _selectedTaste == taste.label;
        final isCorrectAnswer =
            taste.label == food.correctTaste;

        Color bg;
        Color borderColor;
        double borderWidth;

        if (!_showFeedback) {
          bg = isSelected ? taste.lightBg : Colors.white;
          borderColor =
              isSelected ? taste.color : const Color(0xFFEAEAEA);
          borderWidth = isSelected ? 2.5 : 1.5;
        } else {
          if (isSelected && _isCorrect) {
            bg = taste.lightBg;
            borderColor = taste.color;
            borderWidth = 2.5;
          } else if (!_isCorrect && isCorrectAnswer) {
            bg = const Color(0xFFE8F5E9);
            borderColor = const Color(0xFF43A047);
            borderWidth = 2.5;
          } else if (isSelected && !_isCorrect) {
            bg = const Color(0xFFFFEBEE);
            borderColor = Colors.red.shade300;
            borderWidth = 2.5;
          } else {
            bg = Colors.white;
            borderColor = const Color(0xFFEAEAEA);
            borderWidth = 1.5;
          }
        }

        Widget? badge;
        if (_showFeedback && isSelected && _isCorrect) {
          badge = _CircleBadge(
              icon: Icons.check_rounded, bg: taste.color);
        } else if (_showFeedback && isSelected && !_isCorrect) {
          badge = const _CircleBadge(
              icon: Icons.close_rounded, bg: Colors.red);
        } else if (_showFeedback && !_isCorrect && isCorrectAnswer) {
          badge = const _CircleBadge(
              icon: Icons.check_rounded, bg: Color(0xFF43A047));
        }

        return GestureDetector(
          onTap: () => _onTasteTapped(taste),
          child: Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                      color: borderColor, width: borderWidth),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0A000000),
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(taste.emoji,
                        style: TextStyle(fontSize: iconFs)),
                    const SizedBox(height: 8),
                    Text(
                      taste.label,
                      style: TextStyle(
                        fontSize: labelFs,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF2A2A2A),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      taste.subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: subtitleFs,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFB7B7B7),
                      ),
                    ),
                  ],
                ),
              ),
              if (badge != null)
                Positioned(top: 8, right: 8, child: badge),
            ],
          ),
        );
      },
    );
  }

  // ── Feedback banner ───────────────────────────────────────────────────────

  Widget _buildFeedbackBanner(_FoodItem food, bool isTablet) {
    final titleFs = isTablet ? 18.0 : 16.0;
    final bodyFs = isTablet ? 15.0 : 13.0;

    if (_lives <= 0 && !_isCorrect) {
      return _FeedbackCard(
        bg: const Color(0xFFFFEBEE),
        border: Colors.red.shade300,
        children: [
          Text('💔 Out of lives! Game Over!',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Colors.red.shade800,
                fontSize: titleFs,
              )),
          const SizedBox(height: 4),
          Text(
            '${food.name} is ${food.correctTaste}! ${food.funFact}',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.red.shade700,
                fontSize: bodyFs),
          ),
        ],
      );
    }

    if (_isCorrect) {
      return _FeedbackCard(
        bg: const Color(0xFFE8F5E9),
        border: const Color(0xFF81C784),
        children: [
          Text('✅ Correct! +200 points!',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: const Color(0xFF2E7D32),
                fontSize: titleFs,
              )),
          const SizedBox(height: 4),
          Text(
            food.funFact,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: const Color(0xFF388E3C),
                fontSize: bodyFs),
          ),
        ],
      );
    }

    return _FeedbackCard(
      bg: const Color(0xFFFFEBEE),
      border: Colors.red.shade300,
      children: [
        Text('❌ Not quite! -1 life  ($_lives left)',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.red.shade800,
              fontSize: titleFs,
            )),
        const SizedBox(height: 4),
        Text(
          '${food.name} is ${food.correctTaste}! ${food.funFact}',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.red.shade700,
              fontSize: bodyFs),
        ),
      ],
    );
  }

  // ── Next button ───────────────────────────────────────────────────────────

  Widget _buildNextButton(bool isTablet) {
    final isLast = _currentIndex >= _foods.length - 1 || _lives <= 0;
    return SizedBox(
      height: isTablet ? 64 : 56,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _onNext,
        style: ElevatedButton.styleFrom(
          backgroundColor: _headerColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28)),
        ),
        child: Text(
          isLast ? 'See Results 🏆' : 'Next Food →',
          style: TextStyle(
            fontSize: isTablet ? 20 : 18,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }

  // ── Lives row ─────────────────────────────────────────────────────────────

  Widget _buildLivesRow(bool isTablet) {
    final iconSize = isTablet ? 28.0 : 22.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (i) {
        final filled = i < _lives;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: isTablet ? 8 : 5),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Icon(
              filled
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              key: ValueKey(filled),
              color: filled
                  ? const Color(0xFFFF7C93)
                  : const Color(0xFFDDDDDD),
              size: iconSize,
            ),
          ),
        );
      }),
    );
  }
}

// ─── Small reusable widgets ──────────────────────────────────────────────────

class _CircleBadge extends StatelessWidget {
  final IconData icon;
  final Color bg;

  const _CircleBadge({required this.icon, required this.bg});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 26,
      height: 26,
      decoration: BoxDecoration(shape: BoxShape.circle, color: bg),
      alignment: Alignment.center,
      child: Icon(icon, color: Colors.white, size: 16),
    );
  }
}

class _FeedbackCard extends StatelessWidget {
  final Color bg;
  final Color border;
  final List<Widget> children;

  const _FeedbackCard({
    required this.bg,
    required this.border,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: border, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}
