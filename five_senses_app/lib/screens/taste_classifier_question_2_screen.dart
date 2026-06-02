import 'package:flutter/material.dart';

import '../models/app_routes.dart';
import '../models/game_carry.dart';
import '../services/audio_service.dart';

// ─── Data ─────────────────────────────────────────────────────────────────────

class _FoodItem {
  final String name, emoji, correctTaste, funFact;
  final Color cardBg;
  const _FoodItem(
      {required this.name,
      required this.emoji,
      required this.correctTaste,
      required this.cardBg,
      required this.funFact});
}

class _TasteDef {
  final String label, subtitle, emoji;
  final Color color, lightBg;
  const _TasteDef(
      {required this.label,
      required this.subtitle,
      required this.color,
      required this.lightBg,
      required this.emoji});
}

const List<_FoodItem> _foods = [
  _FoodItem(
    name: 'Coffee', emoji: '☕', correctTaste: 'Bitter', cardBg: Color(0xFFEFEBE9),
    funFact: 'Caffeine in coffee is what makes it taste BITTER!',
  ),
  _FoodItem(
    name: 'Watermelon', emoji: '🍉', correctTaste: 'Sweet', cardBg: Color(0xFFFCE4EC),
    funFact: 'Watermelon is 92% water and bursting with SWEETNESS!',
  ),
  _FoodItem(
    name: 'Lime', emoji: '🍈', correctTaste: 'Sour', cardBg: Color(0xFFF1F8E9),
    funFact: 'Lime juice is even SOURER than lemon juice!',
  ),
];

const List<_TasteDef> _tastes = [
  _TasteDef(label: 'Sweet',  subtitle: 'Tip of tongue',   color: Color(0xFFFF5F8D), lightBg: Color(0xFFFFEBF0), emoji: '🍓'),
  _TasteDef(label: 'Sour',   subtitle: 'Sides of tongue', color: Color(0xFFFFAB00), lightBg: Color(0xFFFFF8E1), emoji: '🍋'),
  _TasteDef(label: 'Salty',  subtitle: 'Front sides',     color: Color(0xFF00ACC1), lightBg: Color(0xFFE0F7FA), emoji: '🍟'),
  _TasteDef(label: 'Bitter', subtitle: 'Back of tongue',  color: Color(0xFF7C4DFF), lightBg: Color(0xFFEDE7F6), emoji: '☕'),
];

// ─── Screen ───────────────────────────────────────────────────────────────────

class TasteClassifierQuestion2Screen extends StatefulWidget {
  const TasteClassifierQuestion2Screen({super.key});

  @override
  State<TasteClassifierQuestion2Screen> createState() =>
      _TasteClassifierQuestion2ScreenState();
}

class _TasteClassifierQuestion2ScreenState
    extends State<TasteClassifierQuestion2Screen> {
  static const _headerColor = Color(0xFF6A59E0);

  int _currentIndex = 0;
  String? _selectedTaste;
  bool _showFeedback = false;
  bool _isCorrect = false;
  int _score = 0;
  int _lives = 5;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 400), () {
      AudioService.instance.speak(
        'Round 2! More foods to classify. Keep going!',
      );
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
      }
    });
    AudioService.instance.speak(correct ? 'Nailed it!' : 'Not quite! You\'ve got this!');
  }

  void _onNext() {
    if (_lives <= 0 || _currentIndex >= _foods.length - 1) {
      final args = ModalRoute.of(context)?.settings.arguments;
      final carry = args is GameCarry ? args : null;
      Navigator.pushReplacementNamed(
        context,
        Routes.tasteClassifierQuestion3,
        arguments: GameCarry(
          scoreSoFar: (carry?.scoreSoFar ?? 0) + _score,
          correctSoFar: (carry?.correctSoFar ?? 0) + _score ~/ 200,
          totalSoFar: (carry?.totalSoFar ?? 0) + _foods.length,
          startTime: carry?.startTime ?? DateTime.now(),
        ),
      );
      return;
    }
    setState(() {
      _currentIndex++;
      _selectedTaste = null;
      _showFeedback = false;
      _isCorrect = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.shortestSide >= 600;
    final food = _foods[_currentIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFF3F0FF),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(isTablet),
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: isTablet ? 680.0 : double.infinity),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(
                        isTablet ? 24 : 18, 16, isTablet ? 24 : 18, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('How does this food taste?',
                            style: TextStyle(
                                fontSize: isTablet ? 22 : 18,
                                fontWeight: FontWeight.w900,
                                color: const Color(0xFF2A2A2A))),
                        const SizedBox(height: 12),
                        _buildFoodCard(food, isTablet),
                        const SizedBox(height: 12),
                        Text('Tap the taste it belongs to 👇',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFB7B7B7),
                                fontSize: isTablet ? 17 : 15)),
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

  Widget _buildHeader(bool isTablet) {
    final progress = (_currentIndex + 1) / _foods.length;
    return Container(
      height: isTablet ? 160.0 : 130.0,
      width: double.infinity,
      color: _headerColor,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(8, isTablet ? 22 : 16, 18, 0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pushReplacementNamed(
                      context, Routes.tasteClassifierQuestion1),
                  icon: const Icon(Icons.arrow_back_ios_rounded,
                      color: Colors.white, size: 22),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(width: 6),
                Text('Taste Classifier',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: isTablet ? 26 : 20)),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(20)),
                  child: const Text('Round 2 / 4',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 13)),
                ),
                const SizedBox(width: 8),
                Row(children: [
                  const Icon(Icons.auto_awesome_rounded, color: Color(0xFFFFD54A), size: 18),
                  const SizedBox(width: 4),
                  Text('$_score',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 15)),
                ]),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () => Navigator.pushReplacementNamed(context, Routes.playPick),
                  icon: const Icon(Icons.close_rounded, color: Colors.white),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          Positioned(
            left: 18,
            bottom: 20,
            child: Text('Food ${_currentIndex + 1} of ${_foods.length}',
                style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontWeight: FontWeight.w700,
                    fontSize: isTablet ? 16 : 14)),
          ),
          Positioned(
            left: 0, right: 0, bottom: 0,
            child: LinearProgressIndicator(
              value: progress, minHeight: 5,
              backgroundColor: Colors.white.withValues(alpha: 0.25),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFFD54A)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodCard(_FoodItem food, bool isTablet) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: isTablet ? 28 : 20, horizontal: 16),
      decoration: BoxDecoration(
        color: food.cardBg,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 14, offset: Offset(0, 5))],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(food.emoji, style: TextStyle(fontSize: isTablet ? 70 : 56)),
          const SizedBox(height: 10),
          Text(food.name,
              style: TextStyle(
                  fontSize: isTablet ? 26 : 20,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF2A2A2A))),
        ],
      ),
    );
  }

  Widget _buildTasteGrid(_FoodItem food, bool isTablet) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isTablet ? 4 : 2,
        crossAxisSpacing: 12, mainAxisSpacing: 12,
        childAspectRatio: isTablet ? 0.75 : 0.9,
      ),
      itemCount: _tastes.length,
      itemBuilder: (_, i) {
        final taste = _tastes[i];
        final isSelected = _selectedTaste == taste.label;
        final isCorrectAnswer = taste.label == food.correctTaste;
        Color bg; Color borderColor; double bw;
        if (!_showFeedback) {
          bg = isSelected ? taste.lightBg : Colors.white;
          borderColor = isSelected ? taste.color : const Color(0xFFEAEAEA);
          bw = isSelected ? 2.5 : 1.5;
        } else if (isSelected && _isCorrect) {
          bg = taste.lightBg; borderColor = taste.color; bw = 2.5;
        } else if (!_isCorrect && isCorrectAnswer) {
          bg = const Color(0xFFE8F5E9); borderColor = const Color(0xFF43A047); bw = 2.5;
        } else if (isSelected && !_isCorrect) {
          bg = const Color(0xFFFFEBEE); borderColor = Colors.red.shade300; bw = 2.5;
        } else {
          bg = Colors.white; borderColor = const Color(0xFFEAEAEA); bw = 1.5;
        }
        Widget? badge;
        if (_showFeedback && isSelected && _isCorrect) {
          badge = _CircleBadge(icon: Icons.check_rounded, bg: taste.color);
        } else if (_showFeedback && isSelected && !_isCorrect) {
          badge = const _CircleBadge(icon: Icons.close_rounded, bg: Colors.red);
        } else if (_showFeedback && !_isCorrect && isCorrectAnswer) {
          badge = const _CircleBadge(icon: Icons.check_rounded, bg: Color(0xFF43A047));
        }
        return GestureDetector(
          onTap: () => _onTasteTapped(taste),
          child: Stack(children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: bg, borderRadius: BorderRadius.circular(18),
                border: Border.all(color: borderColor, width: bw),
                boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 8, offset: Offset(0, 3))],
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(taste.emoji, style: TextStyle(fontSize: isTablet ? 28.0 : 26.0)),
                  const SizedBox(height: 8),
                  Text(taste.label, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: Color(0xFF2A2A2A))),
                  const SizedBox(height: 2),
                  Text(taste.subtitle, textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFFB7B7B7))),
                ],
              ),
            ),
            if (badge != null) Positioned(top: 8, right: 8, child: badge),
          ]),
        );
      },
    );
  }

  Widget _buildFeedbackBanner(_FoodItem food, bool isTablet) {
    final titleFs = isTablet ? 18.0 : 16.0;
    final bodyFs = isTablet ? 15.0 : 13.0;
    if (_isCorrect) {
      return _FeedbackCard(
        bg: const Color(0xFFE8F5E9), border: const Color(0xFF81C784),
        children: [
          Text('✅ Correct! +200 points!',
              style: TextStyle(fontWeight: FontWeight.w900, color: const Color(0xFF2E7D32), fontSize: titleFs)),
          const SizedBox(height: 4),
          Text(food.funFact,
              style: TextStyle(fontWeight: FontWeight.w600, color: const Color(0xFF388E3C), fontSize: bodyFs)),
        ],
      );
    }
    return _FeedbackCard(
      bg: const Color(0xFFFFEBEE), border: Colors.red.shade300,
      children: [
        Text('❌ Not quite! -1 life  ($_lives left)',
            style: TextStyle(fontWeight: FontWeight.w900, color: Colors.red.shade800, fontSize: titleFs)),
        const SizedBox(height: 4),
        Text('${food.name} is ${food.correctTaste}! ${food.funFact}',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.red.shade700, fontSize: bodyFs)),
      ],
    );
  }

  Widget _buildNextButton(bool isTablet) {
    final isLast = _currentIndex >= _foods.length - 1 || _lives <= 0;
    return SizedBox(
      height: isTablet ? 64 : 56, width: double.infinity,
      child: ElevatedButton(
        onPressed: _onNext,
        style: ElevatedButton.styleFrom(
          backgroundColor: _headerColor, foregroundColor: Colors.white, elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        ),
        child: Text(isLast ? 'Round 3 →' : 'Next Food →',
            style: TextStyle(fontSize: isTablet ? 20 : 18, fontWeight: FontWeight.w900)),
      ),
    );
  }

  Widget _buildLivesRow(bool isTablet) {
    final sz = isTablet ? 28.0 : 22.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (i) {
        final filled = i < _lives;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: isTablet ? 8 : 5),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Icon(
              filled ? Icons.favorite_rounded : Icons.favorite_border_rounded,
              key: ValueKey(filled),
              color: filled ? const Color(0xFFFF7C93) : const Color(0xFFDDDDDD),
              size: sz,
            ),
          ),
        );
      }),
    );
  }
}

class _CircleBadge extends StatelessWidget {
  final IconData icon; final Color bg;
  const _CircleBadge({required this.icon, required this.bg});
  @override
  Widget build(BuildContext context) => Container(
    width: 26, height: 26,
    decoration: BoxDecoration(shape: BoxShape.circle, color: bg),
    alignment: Alignment.center,
    child: Icon(icon, color: Colors.white, size: 16),
  );
}

class _FeedbackCard extends StatelessWidget {
  final Color bg, border; final List<Widget> children;
  const _FeedbackCard({required this.bg, required this.border, required this.children});
  @override
  Widget build(BuildContext context) => AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(18), border: Border.all(color: border, width: 1.5)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
  );
}
