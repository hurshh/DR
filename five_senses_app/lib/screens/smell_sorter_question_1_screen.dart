import 'package:flutter/material.dart';

import '../models/app_routes.dart';
import '../models/game_carry.dart';
import '../services/audio_service.dart';

// ─── Data ─────────────────────────────────────────────────────────────────────

class _SmellQ {
  final String name;
  final String emoji;
  final String category;
  final Color bg;
  const _SmellQ(this.name, this.emoji, this.category, this.bg);
}

const List<_SmellQ> _items = [
  _SmellQ('Rose',  '🌹', 'Floral',  Color(0xFFFFEBEE)),
  _SmellQ('Pizza', '🍕', 'Food',    Color(0xFFFFF8E1)),
  _SmellQ('Pine',  '🌲', 'Nature',  Color(0xFFE8F5E9)),
  _SmellQ('Mint',  '🌿', 'Fresh',   Color(0xFFE8F5E9)),
];

const List<_CatDef> _cats = [
  _CatDef('Floral',  Icons.local_florist_rounded, Colors.red,        Color(0xFFFFEBEE)),
  _CatDef('Food',    Icons.fastfood_rounded,      Colors.orange,     Color(0xFFFFF8E1)),
  _CatDef('Nature',  Icons.eco_rounded,           Colors.teal,       Color(0xFFE8F5E9)),
  _CatDef('Fresh',   Icons.water_drop_rounded,    Colors.lightGreen, Color(0xFFE0F7FA)),
];

class _CatDef {
  final String label;
  final IconData icon;
  final Color color;
  final Color lightBg;
  const _CatDef(this.label, this.icon, this.color, this.lightBg);
}

// ─── Screen ───────────────────────────────────────────────────────────────────

class SmellSorterQuestion1Screen extends StatefulWidget {
  const SmellSorterQuestion1Screen({super.key});

  @override
  State<SmellSorterQuestion1Screen> createState() =>
      _SmellSorterQuestion1ScreenState();
}

class _SmellSorterQuestion1ScreenState
    extends State<SmellSorterQuestion1Screen> {
  static const _headerColor = Color(0xFFF5D457);

  int _index = 0;
  int _score = 0;
  String? _selected;
  bool _answered = false;
  late final DateTime _startTime;

  _SmellQ get _current => _items[_index];
  bool get _isCorrect => _selected == _current.category;

  @override
  void initState() {
    super.initState();
    _startTime = DateTime.now();
    Future.delayed(const Duration(milliseconds: 400), () {
      AudioService.instance.speak(
        'Warm up round! Sort each smell into Floral, Food, Nature, or Fresh.',
      );
    });
    Future.delayed(const Duration(seconds: 5), _speakPrompt);
  }

  @override
  void dispose() {
    AudioService.instance.stop();
    super.dispose();
  }

  void _speakPrompt() {
    AudioService.instance.speak('What does ${_current.name} smell like?');
  }

  void _onCategory(String cat) {
    if (_answered) return;
    final correct = cat == _current.category;
    setState(() {
      _selected = cat;
      _answered = true;
      if (correct) _score++;
    });
    if (correct) {
      AudioService.instance.speak('Correct! ${_current.name} is $cat!');
    } else {
      AudioService.instance.speak(
          'Not quite! ${_current.name} is ${_current.category}.');
    }
  }

  void _onNext() {
    AudioService.instance.stop();
    if (_index >= _items.length - 1) {
      Navigator.pushReplacementNamed(
        context,
        Routes.smellSorterQuestion2,
        arguments: GameCarry(
          scoreSoFar: 0,
          correctSoFar: _score, // _score = count of correct answers
          totalSoFar: _items.length,
          startTime: _startTime,
        ),
      );
      return;
    }
    setState(() {
      _index++;
      _selected = null;
      _answered = false;
    });
    Future.delayed(const Duration(milliseconds: 300), _speakPrompt);
  }

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
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                    isTablet ? 24 : 18, 16, isTablet ? 24 : 18, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSmellCard(),
                    const SizedBox(height: 14),
                    const Text('Tap the right category 👇',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFB0B0B0))),
                    const SizedBox(height: 12),
                    GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.3,
                      children: _cats
                          .map((cat) => _BucketTile(
                                cat: cat,
                                selected: _selected == cat.label,
                                correct: _answered &&
                                    _selected == cat.label &&
                                    _isCorrect,
                                wrong: _answered &&
                                    _selected == cat.label &&
                                    !_isCorrect,
                                isAnswer:
                                    _answered && cat.label == _current.category,
                                onTap: () => _onCategory(cat.label),
                              ))
                          .toList(),
                    ),
                    if (_answered) ...[
                      const SizedBox(height: 16),
                      _buildFeedback(),
                      const SizedBox(height: 14),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: _onNext,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _headerColor,
                            foregroundColor: const Color(0xFF2A2A2A),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          child: Text(
                            _index >= _items.length - 1
                                ? 'Round 2 →'
                                : 'Next Smell →',
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
                    Navigator.pushReplacementNamed(context, Routes.smellSorterIntro),
              ),
              const Text('Smell Sorter',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF2A2A2A))),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(20)),
                child: Text('Warm-up · ${_index + 1}/${_items.length}',
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF2A2A2A))),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.close_rounded,
                    color: Colors.black54, size: 20),
                tooltip: 'End Game',
                onPressed: () => Navigator.pushReplacementNamed(
                    context, Routes.playPick),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: (_index + 1) / _items.length,
                minHeight: 6,
                backgroundColor: const Color(0xFFECE1A7),
                valueColor:
                    const AlwaysStoppedAnimation<Color>(Color(0xFFF36B3B)),
              ),
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
        color: _current.bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withOpacity(0.06)),
      ),
      child: Column(
        children: [
          const Text('What does this smell like?',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF2A2A2A))),
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
                    offset: const Offset(0, 4))
              ],
            ),
            alignment: Alignment.center,
            child:
                Text(_current.emoji, style: const TextStyle(fontSize: 54)),
          ),
          const SizedBox(height: 12),
          Text(_current.name,
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF2A2A2A))),
        ],
      ),
    );
  }

  Widget _buildFeedback() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
      decoration: BoxDecoration(
        color: _isCorrect
            ? const Color(0xFF45E6C1)
            : const Color(0xFFFF7C93),
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
                  ? 'Correct! ${_current.name} is ${_current.category}! ⭐'
                  : '${_current.name} is actually ${_current.category}!',
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Bucket tile ──────────────────────────────────────────────────────────────

class _BucketTile extends StatelessWidget {
  final _CatDef cat;
  final bool selected;
  final bool correct;
  final bool wrong;
  final bool isAnswer;
  final VoidCallback onTap;

  const _BucketTile({
    required this.cat,
    required this.selected,
    required this.correct,
    required this.wrong,
    required this.isAnswer,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color bg;
    if (correct || (isAnswer && !selected)) {
      bg = cat.lightBg;
    } else if (wrong) {
      bg = const Color(0xFFFFEBEE);
    } else {
      bg = Colors.white;
    }

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: correct || (isAnswer && !selected)
                ? cat.color.withOpacity(0.6)
                : wrong
                    ? Colors.redAccent.withOpacity(0.4)
                    : const Color(0xFFEAEAEA),
            width: (correct || wrong || (isAnswer && !selected)) ? 2 : 1,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundColor: cat.color.withOpacity(0.15),
                    radius: 26,
                    child: Icon(cat.icon, size: 28, color: cat.color),
                  ),
                  const SizedBox(height: 8),
                  Text(cat.label,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: correct || (isAnswer && !selected)
                              ? cat.color
                              : wrong
                                  ? Colors.redAccent
                                  : const Color(0xFF5A5A5A))),
                ],
              ),
            ),
            if (correct)
              Positioned(
                top: 8,
                right: 8,
                child: _Badge(icon: Icons.check_rounded, bg: const Color(0xFF45E6C1)),
              ),
            if (wrong)
              Positioned(
                top: 8,
                right: 8,
                child: _Badge(icon: Icons.close_rounded, bg: Colors.redAccent),
              ),
          ],
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final IconData icon;
  final Color bg;
  const _Badge({required this.icon, required this.bg});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(shape: BoxShape.circle, color: bg),
      alignment: Alignment.center,
      child: Icon(icon, color: Colors.white, size: 16),
    );
  }
}
