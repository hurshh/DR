import 'dart:async';
import 'package:flutter/material.dart';

import '../models/app_routes.dart';
import '../services/audio_service.dart';

// ─── Data ────────────────────────────────────────────────────────────────────

class _SmellItem {
  final String name;
  final String emoji;
  final String category;
  final Color bgColor;
  final IconData icon;
  final Color iconColor;

  const _SmellItem({
    required this.name,
    required this.emoji,
    required this.category,
    required this.bgColor,
    required this.icon,
    required this.iconColor,
  });
}

class _Category {
  final String label;
  final IconData icon;
  final Color color;
  final Color lightBg;

  const _Category({
    required this.label,
    required this.icon,
    required this.color,
    required this.lightBg,
  });
}

const List<_SmellItem> _smells = [
  _SmellItem(name: 'Rose',     emoji: '🌹', category: 'Floral',  bgColor: Color(0xFFFFEBEE), icon: Icons.local_florist_rounded, iconColor: Colors.red),
  _SmellItem(name: 'Pizza',    emoji: '🍕', category: 'Food',    bgColor: Color(0xFFFFF8E1), icon: Icons.local_pizza_rounded,   iconColor: Colors.orange),
  _SmellItem(name: 'Pine',     emoji: '🌲', category: 'Nature',  bgColor: Color(0xFFE8F5E9), icon: Icons.park_rounded,          iconColor: Colors.teal),
  _SmellItem(name: 'Mint',     emoji: '🌿', category: 'Fresh',   bgColor: Color(0xFFE8F5E9), icon: Icons.spa_rounded,           iconColor: Colors.lightGreen),
  _SmellItem(name: 'Lavender', emoji: '💜', category: 'Floral',  bgColor: Color(0xFFEDE7F6), icon: Icons.local_florist_rounded, iconColor: Color(0xFF9B59B6)),
  _SmellItem(name: 'Garlic',   emoji: '🧄', category: 'Food',    bgColor: Color(0xFFFFF3E0), icon: Icons.fastfood_rounded,      iconColor: Colors.deepOrange),
  _SmellItem(name: 'Grass',    emoji: '🌾', category: 'Nature',  bgColor: Color(0xFFF1F8E9), icon: Icons.eco_rounded,           iconColor: Colors.green),
  _SmellItem(name: 'Soap',     emoji: '🧼', category: 'Fresh',   bgColor: Color(0xFFE0F7FA), icon: Icons.water_drop_rounded,    iconColor: Colors.cyan),
];

const List<_Category> _categories = [
  _Category(label: 'Floral',  icon: Icons.local_florist_rounded, color: Colors.red,        lightBg: Color(0xFFFFEBEE)),
  _Category(label: 'Food',    icon: Icons.fastfood_rounded,      color: Colors.orange,     lightBg: Color(0xFFFFF8E1)),
  _Category(label: 'Nature',  icon: Icons.eco_rounded,           color: Colors.teal,       lightBg: Color(0xFFE8F5E9)),
  _Category(label: 'Fresh',   icon: Icons.water_drop_rounded,    color: Colors.lightGreen, lightBg: Color(0xFFE8F5E9)),
];

// ─── Screen ──────────────────────────────────────────────────────────────────

class SmellSorterQuestion3Screen extends StatefulWidget {
  const SmellSorterQuestion3Screen({super.key});

  @override
  State<SmellSorterQuestion3Screen> createState() =>
      _SmellSorterQuestion3ScreenState();
}

class _SmellSorterQuestion3ScreenState
    extends State<SmellSorterQuestion3Screen> {
  static const _headerColor = Color(0xFFF5D457);
  static const _totalSeconds = 90;
  static const _maxLives = 5;

  int _index = 0;
  int _score = 0;
  int _lives = _maxLives;
  int _secondsLeft = _totalSeconds;
  String? _selectedCategory;
  bool _answered = false;
  Timer? _timer;

  _SmellItem get _current => _smells[_index];
  bool get _isCorrect => _selectedCategory == _current.category;

  @override
  void initState() {
    super.initState();
    _startTimer();
    Future.delayed(const Duration(milliseconds: 400), () {
      AudioService.instance.speak(
        "Welcome to Smell Sorter! Sort each smell into the right category — Floral, Food, Nature, or Fresh. Tap the correct bucket. Let's sniff it out!",
      );
    });
    // First question prompt plays after the intro finishes
    Future.delayed(const Duration(seconds: 6), _speakPrompt);
  }

  @override
  void dispose() {
    _timer?.cancel();
    AudioService.instance.stop();
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

  void _speakPrompt() {
    AudioService.instance.speak('What does ${_current.name} smell like?');
  }

  void _onCategoryTapped(String category) {
    if (_answered) return;
    final correct = category == _current.category;
    setState(() {
      _selectedCategory = category;
      _answered = true;
      if (correct) {
        _score += 2;
      } else {
        _lives = (_lives - 1).clamp(0, _maxLives);
        if (_lives == 0) _timer?.cancel();
      }
    });
    if (correct) {
      AudioService.instance.speak('Correct! ${_current.name} is ${_current.category}!');
    } else {
      AudioService.instance.speak('Not quite! ${_current.name} is ${_current.category}.');
    }
  }

  void _onNext() {
    AudioService.instance.stop();
    if (_lives <= 0 || _index >= _smells.length - 1) {
      _navigateToResult();
      return;
    }
    setState(() {
      _index++;
      _selectedCategory = null;
      _answered = false;
    });
    Future.delayed(const Duration(milliseconds: 300), _speakPrompt);
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
    if (_secondsLeft > 30) return const Color(0xFF2A2A2A);
    if (_secondsLeft > 10) return Colors.deepOrange;
    return Colors.red;
  }

  Future<void> _showQuitDialog() async {
    final quit = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('End Game?',
            style: TextStyle(fontWeight: FontWeight.w900)),
        content: const Text(
            'Are you sure you want to quit? Your progress will be lost.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Keep Playing'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
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

  List<Widget> _buildCategoryCards() => _categories
      .map((cat) => _BucketCard(
            category: cat,
            selected: _selectedCategory == cat.label,
            correct: _answered && _selectedCategory == cat.label && _isCorrect,
            wrong: _answered && _selectedCategory == cat.label && !_isCorrect,
            isAnswer: _answered && cat.label == _current.category,
            onTap: () => _onCategoryTapped(cat.label),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.shortestSide >= 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F2D2),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: isTablet
                  ? _buildTabletLayout()
                  : _buildPhoneLayout(),
            ),
          ],
        ),
      ),
    );
  }

  // ── Phone layout: stacked ────────────────────────────────────────────────

  Widget _buildPhoneLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSmellCard(),
          const SizedBox(height: 14),
          const Text('Tap the right category 👇',
              style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFFB0B0B0))),
          const SizedBox(height: 12),
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.3,
            children: _buildCategoryCards(),
          ),
          if (_answered) ..._buildFeedbackAndNext(),
        ],
      ),
    );
  }

  // ── Tablet layout: smell card left, categories right ────────────────────

  Widget _buildTabletLayout() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left: smell card + feedback
          Expanded(
            flex: 4,
            child: Column(
              children: [
                _buildSmellCard(),
                if (_answered) ...[
                  const SizedBox(height: 16),
                  _buildFeedbackBanner(),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: _buildNextButton(),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 24),
          // Right: 2x2 category grid
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Tap the right category 👇',
                    style: TextStyle(
                        fontWeight: FontWeight.w700, color: Color(0xFFB0B0B0))),
                const SizedBox(height: 12),
                GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 2.0,
                  children: _buildCategoryCards(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFeedbackAndNext() => [
        const SizedBox(height: 18),
        _buildFeedbackBanner(),
        const SizedBox(height: 14),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: _buildNextButton(),
        ),
      ];

  ElevatedButton _buildNextButton() {
    return ElevatedButton(
      onPressed: _onNext,
      style: ElevatedButton.styleFrom(
        backgroundColor: _headerColor,
        foregroundColor: const Color(0xFF2A2A2A),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: Text(
        _index >= _smells.length - 1 || _lives <= 0 ? 'See Results' : 'Next Smell →',
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: _headerColor,
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_rounded,
                    color: Colors.black87, size: 20),
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, Routes.playPick),
              ),
              const Text(
                'Smell Sorter',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF2A2A2A),
                ),
              ),
              const Spacer(),
              // Timer
              Row(
                children: [
                  Icon(Icons.timer_outlined, size: 18, color: _timerColor),
                  const SizedBox(width: 4),
                  Text(
                    _timerLabel,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: _timerColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 14),
              // Score
              Row(
                children: [
                  const Icon(Icons.auto_awesome_rounded,
                      size: 16, color: Colors.black54),
                  const SizedBox(width: 4),
                  Text(
                    '$_score',
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF2A2A2A),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8),
              // Quit
              IconButton(
                icon: const Icon(Icons.close_rounded,
                    color: Colors.black54, size: 20),
                tooltip: 'End Game',
                onPressed: _showQuitDialog,
              ),
            ],
          ),
          // Progress bar + lives
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
            child: Row(
              children: [
                Text(
                  'Item ${_index + 1} / ${_smells.length}',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF5A5A5A),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: (_index + 1) / _smells.length,
                      minHeight: 6,
                      backgroundColor: const Color(0xFFECE1A7),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFFF36B3B)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Row(
                  children: List.generate(
                    _maxLives,
                    (i) => Icon(Icons.favorite_rounded,
                        size: 16,
                        color: i < _lives
                            ? const Color(0xFFFF7C93)
                            : Colors.black12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmellCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _current.bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withOpacity(0.06)),
      ),
      child: Column(
        children: [
          const Text(
            'What does this smell like?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Color(0xFF2A2A2A),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            alignment: Alignment.center,
            child: Text(_current.emoji, style: const TextStyle(fontSize: 54)),
          ),
          const SizedBox(height: 12),
          Text(
            _current.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: Color(0xFF2A2A2A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
      decoration: BoxDecoration(
        color: _isCorrect ? const Color(0xFF45E6C1) : const Color(0xFFFF7C93),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(
            _isCorrect ? Icons.check_circle_rounded : Icons.lightbulb_rounded,
            color: Colors.white,
            size: 24,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              _isCorrect
                  ? 'Correct! ${_current.name} is ${_current.category}! +2 ⭐'
                  : '${_current.name} is actually ${_current.category}!',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Bucket Card ─────────────────────────────────────────────────────────────

class _BucketCard extends StatelessWidget {
  final _Category category;
  final bool selected;
  final bool correct;
  final bool wrong;
  final bool isAnswer;
  final VoidCallback onTap;

  const _BucketCard({
    required this.category,
    required this.selected,
    required this.correct,
    required this.wrong,
    required this.isAnswer,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color bg;
    if (correct || (isAnswer && !selected))
      bg = category.lightBg;
    else if (wrong)
      bg = const Color(0xFFFFEBEE);
    else
      bg = Colors.white;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: correct || (isAnswer && !selected)
                ? category.color.withOpacity(0.6)
                : wrong
                    ? Colors.redAccent.withOpacity(0.4)
                    : const Color(0xFFEAEAEA),
            width: (correct || wrong || (isAnswer && !selected)) ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundColor: category.color.withOpacity(0.15),
                    radius: 28,
                    child: Icon(category.icon,
                        size: 30, color: category.color),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    category.label,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: correct || (isAnswer && !selected)
                          ? category.color
                          : wrong
                              ? Colors.redAccent
                              : const Color(0xFF5A5A5A),
                    ),
                  ),
                ],
              ),
            ),
            if (correct)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF45E6C1),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(Icons.check_rounded,
                      color: Colors.white, size: 16),
                ),
              ),
            if (wrong)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.redAccent,
                  ),
                  alignment: Alignment.center,
                  child: const Icon(Icons.close_rounded,
                      color: Colors.white, size: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
