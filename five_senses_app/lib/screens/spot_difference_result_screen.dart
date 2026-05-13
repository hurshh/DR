import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../models/app_routes.dart';
import '../theme/app_theme.dart';

// ── Round data ────────────────────────────────────────────────────────────────

class _RoundData {
  final String name;
  final String emoji;
  final String hint;
  final String funFact;
  final String funFactLabel;
  final List<String> labels;
  final List<List<double>> zones; // [left, top, width, height] normalised 0..1

  const _RoundData({
    required this.name,
    required this.emoji,
    required this.hint,
    required this.funFact,
    required this.funFactLabel,
    required this.labels,
    required this.zones,
  });
}

const List<_RoundData> _kRounds = [
  // ── 1. Garden ──────────────────────────────────────────────────────────────
  _RoundData(
    name: 'Garden',
    emoji: '🌻',
    hint: 'Look at the sun, cloud, tree, house and flower!',
    funFactLabel: 'Plant Power!',
    funFact:
        'Plants use sunlight, water and air to make their own food — '
        'a process called photosynthesis. Without plants, animals '
        'could not survive on Earth!',
    labels: ['Sun color', 'Cloud missing', 'Tree size', 'House color', 'Flower color'],
    zones: [
      [0.02, 0.02, 0.28, 0.30],
      [0.56, 0.04, 0.42, 0.26],
      [0.30, 0.26, 0.28, 0.50],
      [0.60, 0.36, 0.38, 0.50],
      [0.04, 0.60, 0.26, 0.36],
    ],
  ),
  // ── 2. Ocean ───────────────────────────────────────────────────────────────
  _RoundData(
    name: 'Ocean',
    emoji: '🌊',
    hint: 'Check the sun, fish, boat, crab and seaweed!',
    funFactLabel: 'Ocean Amazing!',
    funFact:
        'The ocean covers about 71 % of Earth\'s surface and is home '
        'to more than 230 000 known species of animals. Scientists '
        'think millions more are still waiting to be discovered!',
    labels: ['Sun color', 'Fish color', 'Boat color', 'Crab missing', 'Extra seaweed'],
    zones: [
      [0.02, 0.02, 0.26, 0.28],
      [0.04, 0.50, 0.34, 0.30],
      [0.46, 0.24, 0.50, 0.30],
      [0.62, 0.66, 0.34, 0.30],
      [0.24, 0.66, 0.26, 0.30],
    ],
  ),
  // ── 3. Farm ────────────────────────────────────────────────────────────────
  _RoundData(
    name: 'Farm',
    emoji: '🐄',
    hint: 'Look at the barn, cow, chick, cloud and fence!',
    funFactLabel: 'Farm Facts!',
    funFact:
        'Cows have four stomach compartments that help them '
        'digest tough grass. They spend about 8 hours a day '
        'chewing — that\'s more than humans sleep!',
    labels: ['Barn color', 'Extra cloud', 'Cow spots', 'Chick color', 'Fence post'],
    zones: [
      [0.52, 0.18, 0.46, 0.62],
      [0.48, 0.02, 0.48, 0.24],
      [0.02, 0.46, 0.36, 0.42],
      [0.36, 0.58, 0.24, 0.32],
      [0.00, 0.80, 1.00, 0.18],
    ],
  ),
  // ── 4. Space ───────────────────────────────────────────────────────────────
  _RoundData(
    name: 'Space',
    emoji: '🚀',
    hint: 'Look at the moon, rocket, Saturn\'s rings, stars and Earth!',
    funFactLabel: 'Space Wow!',
    funFact:
        'Light travels so fast it goes around Earth 7.5 times in '
        'just ONE second! Yet even at that speed, sunlight still '
        'takes about 8 minutes to reach us from the Sun.',
    labels: ['Moon color', 'Rocket flipped', 'Ring color', 'Extra star', 'Earth spots'],
    zones: [
      [0.02, 0.04, 0.28, 0.30],
      [0.34, 0.28, 0.30, 0.50],
      [0.62, 0.06, 0.36, 0.36],
      [0.62, 0.44, 0.36, 0.30],
      [0.04, 0.62, 0.28, 0.34],
    ],
  ),
  // ── 5. Kitchen ─────────────────────────────────────────────────────────────
  _RoundData(
    name: 'Kitchen',
    emoji: '🍎',
    hint: 'Look at the apple, banana, cup, bowl and orange!',
    funFactLabel: 'Food Facts!',
    funFact:
        'Apples and roses are part of the same plant family! '
        'Strawberries and pears are cousins too. Eating a '
        'rainbow of colourful fruits gives your body different '
        'vitamins and keeps you healthy.',
    labels: ['Apple color', 'Banana missing', 'Cup color', 'Bowl size', 'Orange missing'],
    zones: [
      [0.04, 0.36, 0.24, 0.40],
      [0.30, 0.28, 0.26, 0.44],
      [0.68, 0.10, 0.28, 0.36],
      [0.34, 0.60, 0.32, 0.36],
      [0.64, 0.46, 0.30, 0.40],
    ],
  ),
  // ── 6. Safari ──────────────────────────────────────────────────────────────
  _RoundData(
    name: 'Safari',
    emoji: '🦒',
    hint: 'Look at the elephant, giraffe spots, tree, sun and bird!',
    funFactLabel: 'Animal Wow!',
    funFact:
        'Giraffes and humans both have exactly 7 neck bones — '
        'but each giraffe bone can be over 25 cm long! '
        'A giraffe\'s tongue is dark blue and can be 45 cm long.',
    labels: ['Elephant color', 'Giraffe spots', 'Tree size', 'Sun color', 'Bird missing'],
    zones: [
      [0.00, 0.34, 0.34, 0.58],
      [0.36, 0.18, 0.34, 0.72],
      [0.68, 0.10, 0.30, 0.60],
      [0.66, 0.02, 0.30, 0.24],
      [0.28, 0.02, 0.26, 0.22],
    ],
  ),
];

// ── Screen ────────────────────────────────────────────────────────────────────

class SpotDifferenceResultScreen extends StatefulWidget {
  const SpotDifferenceResultScreen({super.key});

  @override
  State<SpotDifferenceResultScreen> createState() => _SDState();
}

class _SDState extends State<SpotDifferenceResultScreen> {
  int _round = 0;
  int _lives = 3;
  int _seconds = 0;
  int _score = 0;
  bool _hintUsed = false;
  Timer? _timer;
  String? _toast;
  bool _toastGood = true;

  final List<Set<int>> _found =
      List.generate(_kRounds.length, (_) => <int>{});

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() => _seconds++);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  _RoundData get _rd => _kRounds[_round];
  Set<int> get _cf => _found[_round];
  bool get _roundDone => _cf.length == _rd.zones.length;
  bool get _gameDone => _round == _kRounds.length - 1 && _roundDone;

  String get _timerStr {
    final m = _seconds ~/ 60;
    final s = _seconds % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }

  bool _isTablet(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide >= 600;

  double _imageHeight(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return _isTablet(context) ? h * 0.38 : h * 0.25;
  }

  void _onTapB(TapDownDetails d, Size sz) {
    if (_roundDone || _lives <= 0) return;
    final fx = d.localPosition.dx / sz.width;
    final fy = d.localPosition.dy / sz.height;

    for (int i = 0; i < _rd.zones.length; i++) {
      if (_cf.contains(i)) continue;
      final z = _rd.zones[i];
      if (fx >= z[0] && fx <= z[0] + z[2] && fy >= z[1] && fy <= z[1] + z[3]) {
        setState(() {
          _cf.add(i);
          _score += 10;
          _toast = '✅ +10 pts · Found: ${_rd.labels[i]}!';
          _toastGood = true;
        });
        return;
      }
    }
    setState(() {
      if (_lives > 0) _lives--;
      _score = (_score - 2).clamp(0, 9999);
      _toast = _lives > 0 ? '❌ Not quite! $_lives ❤️ left' : '💀 No lives left!';
      _toastGood = false;
    });
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final tablet = _isTablet(context);
    return Scaffold(
      backgroundColor: AppTheme.dark,
      body: SafeArea(
        child: Column(
          children: [
            _header(context, tablet),
            _tabs(tablet),
            Expanded(child: tablet ? _tabletBody(context) : _phoneBody(context)),
          ],
        ),
      ),
    );
  }

  // ── Phone layout ──────────────────────────────────────────────────────────

  Widget _phoneBody(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _progressRow(),
          const SizedBox(height: 12),
          _imagesRow(context),
          const SizedBox(height: 12),
          if (_toast != null) ...[_toastBanner(), const SizedBox(height: 12)],
          _chipRow(),
          const SizedBox(height: 16),
          if (_roundDone) _roundDoneCard(context) else _actionRow(),
        ],
      ),
    );
  }

  // ── Tablet layout ─────────────────────────────────────────────────────────

  Widget _tabletBody(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 55,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 16, 12, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _progressRow(),
                const SizedBox(height: 14),
                _imagesRow(context),
                if (_toast != null) ...[const SizedBox(height: 14), _toastBanner()],
              ],
            ),
          ),
        ),
        Container(width: 1, color: Colors.white10),
        Expanded(
          flex: 45,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('DIFFERENCES TO FIND',
                    style: TextStyle(
                        color: Colors.white38,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2)),
                const SizedBox(height: 10),
                _chipRow(),
                const SizedBox(height: 24),
                if (_roundDone) _roundDoneCard(context) else _actionRow(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ── Widgets ───────────────────────────────────────────────────────────────

  Widget _header(BuildContext context, bool tablet) {
    return Container(
      height: tablet ? 68 : 58,
      color: AppTheme.dark,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white, size: 20),
            padding: EdgeInsets.zero,
            onPressed: () => Navigator.pushReplacementNamed(context, Routes.home),
          ),
          if (tablet) ...[
            const SizedBox(width: 4),
            const Text('Spot the Difference',
                style: TextStyle(
                    color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900)),
          ],
          const Spacer(),
          // Score badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFFFD04D).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFFFD04D).withValues(alpha: 0.4)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star_rounded, color: Color(0xFFFFD04D), size: 13),
                const SizedBox(width: 3),
                Text('$_score',
                    style: const TextStyle(
                        color: Color(0xFFFFD04D),
                        fontWeight: FontWeight.w900,
                        fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.timer_outlined, color: Colors.white60, size: 14),
          const SizedBox(width: 3),
          Text(_timerStr,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w800, fontSize: 14)),
          const SizedBox(width: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              3,
              (i) => Icon(Icons.favorite_rounded,
                  size: tablet ? 20 : 14,
                  color: i < _lives ? Colors.red : Colors.white24),
            ),
          ),
          const SizedBox(width: 4),
        ],
      ),
    );
  }

  Widget _tabs(bool tablet) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 0, 16, tablet ? 6 : 4),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(_kRounds.length, (i) {
            final done = _found[i].length == _kRounds[i].zones.length;
            final active = i == _round;
            return GestureDetector(
              onTap: () => setState(() => _round = i),
              child: Container(
                margin: const EdgeInsets.only(right: 6),
                padding: EdgeInsets.symmetric(
                    horizontal: 14, vertical: tablet ? 10 : 7),
                decoration: BoxDecoration(
                  color: active
                      ? const Color(0xFF45E6C1)
                      : (done ? Colors.white12 : Colors.white10),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(_kRounds[i].emoji, style: TextStyle(fontSize: tablet ? 15 : 13)),
                    const SizedBox(width: 5),
                    if (done) ...[
                      Icon(Icons.check_circle,
                          color: active ? Colors.black54 : Colors.white,
                          size: tablet ? 14 : 12),
                      const SizedBox(width: 3),
                    ],
                    Text(
                      _kRounds[i].name,
                      style: TextStyle(
                        color: active ? Colors.black87 : Colors.white70,
                        fontWeight: FontWeight.w800,
                        fontSize: tablet ? 14 : 12,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _progressRow() {
    final remaining = _rd.zones.length - _cf.length;
    return Row(
      children: [
        const Icon(Icons.search_rounded, color: Color(0xFF45E6C1), size: 16),
        const SizedBox(width: 6),
        Text(
          '${_cf.length} / ${_rd.zones.length} found',
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w800, fontSize: 14),
        ),
        const SizedBox(width: 8),
        if (remaining > 0)
          Text(
            '· $remaining left',
            style: const TextStyle(color: Colors.white38, fontSize: 13),
          ),
        const Spacer(),
        Text(_rd.emoji,
            style: const TextStyle(fontSize: 16)),
        const SizedBox(width: 4),
        Text(_rd.name,
            style: const TextStyle(
                color: Colors.white54, fontSize: 13, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _imagesRow(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      final imageW = (constraints.maxWidth - 10) / 2;
      final imageH = _imageHeight(context);
      final sz = Size(imageW, imageH);

      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image A
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: SizedBox(
                  width: imageW,
                  height: imageH,
                  child: CustomPaint(
                    painter: _ScenePainter(scene: _round, isB: false),
                    child: const Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text('Image A', style: _labelStyle),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Image B — tappable
              GestureDetector(
                onTapDown: (d) => _onTapB(d, sz),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: SizedBox(
                    width: imageW,
                    height: imageH,
                    child: Stack(
                      children: [
                        CustomPaint(
                          painter: _ScenePainter(scene: _round, isB: true),
                          child: const Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Text('Image B · Tap to find!',
                                  style: _labelStyle),
                            ),
                          ),
                        ),
                        ..._cf.map((i) {
                          final z = _rd.zones[i];
                          return Positioned(
                            left: z[0] * imageW,
                            top: z[1] * imageH,
                            width: z[2] * imageW,
                            height: z[3] * imageH,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color(0xFF45E6C1), width: 2.5),
                                borderRadius: BorderRadius.circular(8),
                                color: const Color(0xFF45E6C1).withValues(alpha: 0.18),
                              ),
                              child: const Center(
                                child: Icon(Icons.check_rounded,
                                    color: Color(0xFF45E6C1), size: 18),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: _cf.length / _rd.zones.length,
              minHeight: 4,
              backgroundColor: Colors.white10,
              valueColor: const AlwaysStoppedAnimation(Color(0xFF45E6C1)),
            ),
          ),
        ],
      );
    });
  }

  static const _labelStyle =
      TextStyle(color: Colors.black26, fontSize: 10, fontWeight: FontWeight.w700);

  Widget _toastBanner() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
      decoration: BoxDecoration(
        color: _toastGood ? const Color(0xFF45E6C1) : const Color(0xFFFF5252),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(_toast!,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w800, fontSize: 14)),
    );
  }

  Widget _chipRow() {
    return Wrap(
      spacing: 7,
      runSpacing: 7,
      children: List.generate(_rd.zones.length, (i) {
        final ok = _cf.contains(i);
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
          decoration: BoxDecoration(
            color: ok ? const Color(0xFF45E6C1) : Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: ok
                  ? const Color(0xFF45E6C1)
                  : Colors.white.withValues(alpha: 0.12),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(ok ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
                  size: 14, color: ok ? Colors.white : Colors.white38),
              const SizedBox(width: 5),
              Text(_rd.labels[i],
                  style: TextStyle(
                      color: ok ? Colors.white : Colors.white38,
                      fontSize: 12,
                      fontWeight: FontWeight.w700)),
            ],
          ),
        );
      }),
    );
  }

  Widget _roundDoneCard(BuildContext context) {
    final nextRound = (_round + 1).clamp(0, _kRounds.length - 1);
    final starsEarned = _lives == 3 ? 3 : _lives == 2 ? 2 : 1;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Completion banner
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF2BC7B7), Color(0xFF45E6C1)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Text('${_rd.emoji}  Round Complete!',
                  style: const TextStyle(
                      color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900)),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (i) => Icon(
                    i < starsEarned ? Icons.star_rounded : Icons.star_outline_rounded,
                    color: i < starsEarned
                        ? const Color(0xFFFFD54A)
                        : Colors.white38,
                    size: 28,
                  ),
                ),
              ),
              if (!_hintUsed) ...[
                const SizedBox(height: 6),
                const Text('🎯 Bonus: no hint used! +20 pts',
                    style: TextStyle(
                        color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
              ],
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Fun fact card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.07),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.lightbulb_rounded,
                      color: Color(0xFFFFD04D), size: 18),
                  const SizedBox(width: 6),
                  Text(_rd.funFactLabel,
                      style: const TextStyle(
                          color: Color(0xFFFFD04D),
                          fontWeight: FontWeight.w900,
                          fontSize: 14)),
                ],
              ),
              const SizedBox(height: 8),
              Text(_rd.funFact,
                  style: const TextStyle(
                      color: Colors.white70, fontSize: 13, height: 1.55)),
            ],
          ),
        ),
        const SizedBox(height: 14),
        if (!_gameDone)
          _btn(
            label: 'Next: ${_kRounds[nextRound].emoji} ${_kRounds[nextRound].name} →',
            color: const Color(0xFF45E6C1),
            textColor: Colors.black87,
            onTap: () => setState(() {
              _round = nextRound;
              _hintUsed = false;
            }),
          )
        else
          _btn(
            label: '🏆 See Final Results!',
            color: const Color(0xFFFFD04D),
            textColor: Colors.black87,
            onTap: () => Navigator.pushReplacementNamed(context, Routes.gameResult),
          ),
        const SizedBox(height: 8),
        _btn(
          label: '🏠 Go Home',
          color: Colors.white.withValues(alpha: 0.08),
          textColor: Colors.white70,
          onTap: () => Navigator.pushReplacementNamed(context, Routes.home),
        ),
      ],
    );
  }

  Widget _actionRow() {
    return Row(
      children: [
        Expanded(
          child: _DarkPill(
            icon: Icons.lightbulb_outline_rounded,
            text: 'Hint',
            onTap: () => setState(() {
              _toast = '💡 ${_rd.hint}';
              _toastGood = true;
              _hintUsed = true;
            }),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _DarkPill(
            icon: Icons.skip_next_rounded,
            text: 'Skip Round',
            onTap: () {
              if (_round < _kRounds.length - 1) {
                setState(() {
                  _round++;
                  _hintUsed = false;
                });
              } else {
                Navigator.pushReplacementNamed(context, Routes.home);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _btn({
    required String label,
    required Color color,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
        child: Text(label,
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15)),
      ),
    );
  }
}

// ── Dark pill button ──────────────────────────────────────────────────────────

class _DarkPill extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const _DarkPill({required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 16),
        label: Text(text,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white.withValues(alpha: 0.08),
          foregroundColor: Colors.white70,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }
}

// ── Scene painter ─────────────────────────────────────────────────────────────

class _ScenePainter extends CustomPainter {
  final int scene;
  final bool isB;

  const _ScenePainter({required this.scene, required this.isB});

  @override
  void paint(Canvas canvas, Size size) {
    switch (scene) {
      case 0: _garden(canvas, size);
      case 1: _ocean(canvas, size);
      case 2: _farm(canvas, size);
      case 3: _space(canvas, size);
      case 4: _kitchen(canvas, size);
      case 5: _safari(canvas, size);
      default: break;
    }
  }

  // ── 1. GARDEN ──────────────────────────────────────────────────────────────
  // B diffs: sun yellow→orange | cloud vanishes | tree smaller |
  //          house orange→blue | flower pink→red

  void _garden(Canvas canvas, Size s) {
    final w = s.width; final h = s.height;
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h * 0.72), Paint()..color = const Color(0xFFBBE8FF));
    canvas.drawRect(Rect.fromLTWH(0, h * 0.72, w, h * 0.28), Paint()..color = const Color(0xFF5BBD5B));

    // Sun — diff 0
    final sunC = isB ? const Color(0xFFFF8C00) : const Color(0xFFFFD700);
    _circle(canvas, w * 0.16, h * 0.16, w * 0.10, sunC);
    _rays(canvas, w * 0.16, h * 0.16, w * 0.12, w * 0.17, 8, sunC);

    // Cloud — diff 1
    if (!isB) _cloud(canvas, w * 0.74, h * 0.13, w * 0.10, Colors.white);

    // Decorative small cloud always
    _cloud(canvas, w * 0.44, h * 0.08, w * 0.07, Colors.white.withValues(alpha: 0.80));

    // Tree — diff 2
    _rect(canvas, w * 0.40, h * 0.52, w * 0.04, h * 0.20, const Color(0xFF8D6E63));
    _circle(canvas, w * 0.42, h * 0.44, isB ? w * 0.09 : w * 0.14, const Color(0xFF3CBB5A));

    // House — diff 3
    _house(canvas, w * 0.76, h * 0.58, w * 0.22, h * 0.28,
        isB ? const Color(0xFF4A90D9) : const Color(0xFFFF8C42));

    // Flower — diff 4
    _flower(canvas, w * 0.16, h * 0.76, w * 0.07,
        isB ? const Color(0xFFE53935) : const Color(0xFFEC407A));

    // Extra small flower (always)
    _flower(canvas, w * 0.28, h * 0.82, w * 0.05, const Color(0xFFFDD835));
  }

  // ── 2. OCEAN ───────────────────────────────────────────────────────────────
  // B diffs: sun yellow→pink | fish orange→blue | boat white→yellow |
  //          crab vanishes | extra seaweed

  void _ocean(Canvas canvas, Size s) {
    final w = s.width; final h = s.height;
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h * 0.42), Paint()..color = const Color(0xFF87CEEB));
    canvas.drawRect(Rect.fromLTWH(0, h * 0.42, w, h * 0.58), Paint()..color = const Color(0xFF1A7DBB));

    // Shimmer
    final shim = Paint()..color = Colors.white.withValues(alpha: 0.10)..strokeWidth = 1.5;
    for (int i = 0; i < 4; i++) {
      canvas.drawLine(Offset(0, h * (0.52 + i * 0.10)), Offset(w, h * (0.52 + i * 0.10)), shim);
    }

    // Sun — diff 0
    _circle(canvas, w * 0.15, h * 0.15, w * 0.09,
        isB ? const Color(0xFFFF80AB) : const Color(0xFFFFD700));

    // Clouds (always)
    _cloud(canvas, w * 0.60, h * 0.10, w * 0.08, Colors.white);

    // Boat — diff 2
    _boat(canvas, w * 0.70, h * 0.42, w * 0.24, h * 0.14,
        isB ? const Color(0xFFFFD700) : Colors.white);

    // Fish — diff 1
    _fish(canvas, w * 0.18, h * 0.62, w * 0.24,
        isB ? const Color(0xFF42A5F5) : const Color(0xFFFF7043));

    // Small fish (always)
    _fish(canvas, w * 0.55, h * 0.74, w * 0.14, const Color(0xFFAB47BC));

    // Seaweed — diff 4
    _seaweed(canvas, w * 0.38, h * 0.92);
    if (isB) _seaweed(canvas, w * 0.50, h * 0.92);

    // Crab — diff 3
    if (!isB) _crab(canvas, w * 0.80, h * 0.80);
  }

  // ── 3. FARM ────────────────────────────────────────────────────────────────
  // B diffs: barn red→blue | extra cloud | cow loses spots |
  //          chick yellow→orange | extra fence post

  void _farm(Canvas canvas, Size s) {
    final w = s.width; final h = s.height;
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h * 0.65), Paint()..color = const Color(0xFFBBE8FF));
    canvas.drawRect(Rect.fromLTWH(0, h * 0.65, w, h * 0.35), Paint()..color = const Color(0xFF6ACC6A));
    canvas.drawRect(Rect.fromLTWH(w * 0.36, h * 0.65, w * 0.18, h * 0.35),
        Paint()..color = const Color(0xFFD4A86A));

    _cloud(canvas, w * 0.18, h * 0.11, w * 0.09, Colors.white);
    if (isB) _cloud(canvas, w * 0.72, h * 0.10, w * 0.09, Colors.white); // diff 1
    _barn(canvas, w * 0.75, h * 0.42, w * 0.24, h * 0.42,
        isB ? const Color(0xFF4A90D9) : const Color(0xFFD32F2F));
    _cow(canvas, w * 0.17, h * 0.64, w * 0.26, h * 0.28, hasSpots: !isB);
    _chick(canvas, w * 0.46, h * 0.72, w * 0.07,
        isB ? const Color(0xFFFF8C00) : const Color(0xFFFFD700));
    _fence(canvas, s, isB ? 4 : 3);
  }

  // ── 4. SPACE ───────────────────────────────────────────────────────────────
  // B diffs: moon grey→yellow | rocket flipped | Saturn ring yellow→blue |
  //          extra star cluster | Earth loses green patches

  void _space(Canvas canvas, Size s) {
    final w = s.width; final h = s.height;

    // Background — deep space gradient approximation
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), Paint()..color = const Color(0xFF0A0E2A));

    // Stars (always)
    final starP = Paint()..color = Colors.white;
    final rng = math.Random(42);
    for (int i = 0; i < 40; i++) {
      final sx = rng.nextDouble() * w;
      final sy = rng.nextDouble() * h;
      final sr = rng.nextDouble() * 1.4 + 0.4;
      canvas.drawCircle(Offset(sx, sy), sr, starP);
    }

    // Extra bright star cluster in B — diff 3
    if (isB) {
      final clusterP = Paint()..color = const Color(0xFFFFFFAA);
      for (int i = 0; i < 7; i++) {
        final sx = w * (0.70 + rng.nextDouble() * 0.26);
        final sy = h * (0.46 + rng.nextDouble() * 0.26);
        canvas.drawCircle(Offset(sx, sy), 2.2, clusterP);
      }
    }

    // Moon — diff 0: grey (A) → yellow (B)
    _circle(canvas, w * 0.16, h * 0.18, w * 0.10,
        isB ? const Color(0xFFFFD700) : const Color(0xFFD0D0D0));
    // Moon craters (always)
    _circle(canvas, w * 0.12, h * 0.14, w * 0.025,
        isB ? const Color(0xFFFFB300) : const Color(0xFFB0B0B0));
    _circle(canvas, w * 0.20, h * 0.22, w * 0.018,
        isB ? const Color(0xFFFFB300) : const Color(0xFFB0B0B0));

    // Rocket — diff 1: upright (A) → flipped (B)
    _rocket(canvas, w * 0.47, h * 0.50, w * 0.12, h * 0.36, flipped: isB);

    // Saturn — diff 2: ring yellow (A) → blue (B)
    _saturn(canvas, w * 0.79, h * 0.22, w * 0.13,
        ringColor: isB ? const Color(0xFF42A5F5) : const Color(0xFFFFD04D));

    // Earth — diff 4: with green patches (A) → solid blue (B)
    _earth(canvas, w * 0.16, h * 0.78, w * 0.11, showLand: !isB);
  }

  // ── 5. KITCHEN ─────────────────────────────────────────────────────────────
  // B diffs: apple red→green | banana missing | cup blue→red |
  //          bowl smaller | orange missing

  void _kitchen(Canvas canvas, Size s) {
    final w = s.width; final h = s.height;

    // Background — warm cream walls
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), Paint()..color = const Color(0xFFFFF8F0));

    // Window top-center
    _kitchenWindow(canvas, w * 0.36, h * 0.04, w * 0.28, h * 0.26);

    // Shelf/counter
    canvas.drawRect(Rect.fromLTWH(0, h * 0.76, w, h * 0.24),
        Paint()..color = const Color(0xFFD4A86A));
    canvas.drawRect(Rect.fromLTWH(0, h * 0.74, w, h * 0.03),
        Paint()..color = const Color(0xFF8D6E63));

    // Apple — diff 0: red (A) → green (B)
    _apple(canvas, w * 0.16, h * 0.60, w * 0.11,
        isB ? const Color(0xFF66BB6A) : const Color(0xFFEF5350));

    // Banana — diff 1: present (A) → gone (B)
    if (!isB) _banana(canvas, w * 0.42, h * 0.54, w * 0.14);

    // Cup — diff 2: blue (A) → red (B)
    _cup(canvas, w * 0.80, h * 0.32, w * 0.14, h * 0.26,
        isB ? const Color(0xFFEF5350) : const Color(0xFF42A5F5));

    // Bowl — diff 3: normal size (A) → small (B)
    _bowl(canvas, w * 0.50, h * 0.72, isB ? w * 0.10 : w * 0.16,
        const Color(0xFFFFECB3));

    // Orange — diff 4: present (A) → gone (B)
    if (!isB) {
      _circle(canvas, w * 0.78, h * 0.68, w * 0.09, const Color(0xFFFF9800));
      _circle(canvas, w * 0.78, h * 0.68, w * 0.04,
          const Color(0xFFFFA726).withValues(alpha: 0.50));
    }

    // Cookies on shelf (always)
    for (int i = 0; i < 3; i++) {
      _circle(canvas, w * (0.24 + i * 0.18), h * 0.90, w * 0.05,
          const Color(0xFFD4956A));
      _circle(canvas, w * (0.24 + i * 0.18), h * 0.90, w * 0.015,
          const Color(0xFF6D4C41));
    }
  }

  // ── 6. SAFARI ──────────────────────────────────────────────────────────────
  // B diffs: elephant grey→purple | giraffe spots orange→red |
  //          tree smaller | sun yellow→blue | bird missing

  void _safari(Canvas canvas, Size s) {
    final w = s.width; final h = s.height;

    // Warm amber sky
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h * 0.62),
        Paint()..color = const Color(0xFFFFCC80));
    // Ground — savanna tan
    canvas.drawRect(Rect.fromLTWH(0, h * 0.62, w, h * 0.38),
        Paint()..color = const Color(0xFFD4A84A));
    // Grass tufts
    final grassP = Paint()..color = const Color(0xFF8BC34A)..strokeWidth = 2;
    for (int i = 0; i < 8; i++) {
      final gx = w * (0.05 + i * 0.12);
      canvas.drawLine(Offset(gx, h * 0.62), Offset(gx - 3, h * 0.55), grassP);
      canvas.drawLine(Offset(gx, h * 0.62), Offset(gx + 3, h * 0.55), grassP);
    }

    // Sun — diff 3
    final sunC = isB ? const Color(0xFF42A5F5) : const Color(0xFFFFD700);
    _circle(canvas, w * 0.82, h * 0.12, w * 0.09, sunC);
    _rays(canvas, w * 0.82, h * 0.12, w * 0.11, w * 0.15, 6, sunC);

    // Bird — diff 4: present (A) → missing (B)
    if (!isB) _bird(canvas, w * 0.40, h * 0.10, w * 0.08);

    // Acacia tree — diff 2: large (A) → smaller (B)
    _rect(canvas, w * 0.80 - w * 0.02, h * 0.36, w * 0.04, h * 0.26,
        const Color(0xFF5D4037));
    _circle(canvas, w * 0.80, h * 0.32, isB ? w * 0.09 : w * 0.14,
        const Color(0xFF689F38));

    // Giraffe — diff 1: spot color
    _giraffe(canvas, w * 0.52, h * 0.68, w * 0.20, h * 0.50,
        spotColor: isB ? const Color(0xFFE53935) : const Color(0xFFFF8F00));

    // Elephant — diff 0
    _elephant(canvas, w * 0.16, h * 0.74, w * 0.28, h * 0.30,
        bodyColor: isB ? const Color(0xFF9575CD) : const Color(0xFF9E9E9E));
  }

  // ── Shared drawing helpers ─────────────────────────────────────────────────

  void _circle(Canvas canvas, double cx, double cy, double r, Color color) =>
      canvas.drawCircle(Offset(cx, cy), r, Paint()..color = color);

  void _rect(Canvas canvas, double x, double y, double w, double h, Color color) =>
      canvas.drawRect(Rect.fromLTWH(x, y, w, h), Paint()..color = color);

  void _rays(Canvas canvas, double cx, double cy, double r1, double r2, int count, Color color) {
    final p = Paint()..color = color..strokeWidth = 2..strokeCap = StrokeCap.round;
    for (int i = 0; i < count; i++) {
      final a = i * math.pi * 2 / count;
      canvas.drawLine(
        Offset(cx + math.cos(a) * r1, cy + math.sin(a) * r1),
        Offset(cx + math.cos(a) * r2, cy + math.sin(a) * r2),
        p,
      );
    }
  }

  void _cloud(Canvas canvas, double cx, double cy, double r, Color color) {
    final p = Paint()..color = color;
    canvas.drawCircle(Offset(cx, cy), r, p);
    canvas.drawCircle(Offset(cx - r * 0.85, cy + r * 0.22), r * 0.70, p);
    canvas.drawCircle(Offset(cx + r * 0.85, cy + r * 0.22), r * 0.70, p);
    canvas.drawRect(
        Rect.fromCenter(center: Offset(cx, cy + r * 0.58), width: r * 2.8, height: r * 0.85), p);
  }

  void _flower(Canvas canvas, double cx, double cy, double r, Color petal) {
    canvas.drawLine(Offset(cx, cy), Offset(cx, cy + r * 2.0),
        Paint()..color = const Color(0xFF4CAF50)..strokeWidth = 2.5..strokeCap = StrokeCap.round);
    final p = Paint()..color = petal;
    canvas.drawOval(Rect.fromCenter(center: Offset(cx, cy - r * 0.85), width: r * 0.80, height: r * 1.0), p);
    canvas.drawOval(Rect.fromCenter(center: Offset(cx, cy + r * 0.85), width: r * 0.80, height: r * 1.0), p);
    canvas.drawOval(Rect.fromCenter(center: Offset(cx - r * 0.85, cy), width: r * 1.0, height: r * 0.80), p);
    canvas.drawOval(Rect.fromCenter(center: Offset(cx + r * 0.85, cy), width: r * 1.0, height: r * 0.80), p);
    _circle(canvas, cx, cy, r * 0.38, const Color(0xFFFFD700));
  }

  void _house(Canvas canvas, double cx, double cy, double w, double h, Color wall) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(
          Rect.fromCenter(center: Offset(cx, cy + h * 0.14), width: w, height: h * 0.70),
          const Radius.circular(3)),
      Paint()..color = wall,
    );
    final roof = Path()
      ..moveTo(cx - w * 0.55, cy - h * 0.10)
      ..lineTo(cx + w * 0.55, cy - h * 0.10)
      ..lineTo(cx, cy - h * 0.50)
      ..close();
    canvas.drawPath(roof, Paint()..color = const Color(0xFFB71C1C));
    canvas.drawRRect(
      RRect.fromRectAndRadius(
          Rect.fromCenter(center: Offset(cx, cy + h * 0.34), width: w * 0.24, height: h * 0.28),
          const Radius.circular(3)),
      Paint()..color = const Color(0xFF6D4C41),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
          Rect.fromCenter(center: Offset(cx - w * 0.22, cy + h * 0.08), width: w * 0.20, height: w * 0.20),
          const Radius.circular(3)),
      Paint()..color = const Color(0xFFB3E5FC),
    );
  }

  void _boat(Canvas canvas, double cx, double cy, double w, double h, Color color) {
    final hull = Path()
      ..moveTo(cx - w * 0.50, cy)
      ..lineTo(cx + w * 0.50, cy)
      ..lineTo(cx + w * 0.36, cy + h)
      ..lineTo(cx - w * 0.36, cy + h)
      ..close();
    canvas.drawPath(hull, Paint()..color = color);
    canvas.drawLine(Offset(cx - w * 0.06, cy), Offset(cx - w * 0.06, cy - h * 1.30),
        Paint()..color = const Color(0xFF8D6E63)..strokeWidth = 2);
    final sail = Path()
      ..moveTo(cx - w * 0.06, cy - h * 1.30)
      ..lineTo(cx + w * 0.38, cy - h * 0.30)
      ..lineTo(cx - w * 0.06, cy - h * 0.08)
      ..close();
    canvas.drawPath(sail, Paint()..color = Colors.white.withValues(alpha: 0.90));
  }

  void _fish(Canvas canvas, double cx, double cy, double w, Color color) {
    final fh = w * 0.46;
    canvas.drawOval(Rect.fromCenter(center: Offset(cx, cy), width: w, height: fh),
        Paint()..color = color);
    final tail = Path()
      ..moveTo(cx + w * 0.46, cy)
      ..lineTo(cx + w * 0.78, cy - fh * 0.60)
      ..lineTo(cx + w * 0.78, cy + fh * 0.60)
      ..close();
    canvas.drawPath(tail, Paint()..color = color);
    _circle(canvas, cx - w * 0.28, cy - fh * 0.10, w * 0.07, Colors.white);
    _circle(canvas, cx - w * 0.28, cy - fh * 0.10, w * 0.035, Colors.black87);
  }

  void _seaweed(Canvas canvas, double cx, double bottom) {
    final p = Paint()..color = const Color(0xFF2E7D32)..strokeWidth = 3..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(cx, bottom), Offset(cx - 5, bottom - 18), p);
    canvas.drawLine(Offset(cx - 5, bottom - 18), Offset(cx + 4, bottom - 32), p);
    canvas.drawLine(Offset(cx + 4, bottom - 32), Offset(cx - 4, bottom - 44), p);
  }

  void _crab(Canvas canvas, double cx, double cy) {
    canvas.drawOval(Rect.fromCenter(center: Offset(cx, cy), width: 22, height: 14),
        Paint()..color = const Color(0xFFE53935));
    final cp = Paint()..color = const Color(0xFFE53935)..strokeWidth = 2.5..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(cx - 11, cy), Offset(cx - 20, cy - 8), cp);
    canvas.drawLine(Offset(cx - 20, cy - 8), Offset(cx - 25, cy - 4), cp);
    canvas.drawLine(Offset(cx + 11, cy), Offset(cx + 20, cy - 8), cp);
    canvas.drawLine(Offset(cx + 20, cy - 8), Offset(cx + 25, cy - 4), cp);
    for (int i = -1; i <= 1; i++) {
      canvas.drawLine(Offset(cx + i * 5, cy + 7), Offset(cx + i * 5 - 5, cy + 16), cp);
      canvas.drawLine(Offset(cx + i * 5, cy + 7), Offset(cx + i * 5 + 5, cy + 16), cp);
    }
    _circle(canvas, cx - 5, cy - 9, 2.5, Colors.white);
    _circle(canvas, cx + 5, cy - 9, 2.5, Colors.white);
  }

  void _barn(Canvas canvas, double cx, double cy, double w, double h, Color color) {
    canvas.drawRect(
        Rect.fromCenter(center: Offset(cx, cy + h * 0.14), width: w, height: h * 0.72),
        Paint()..color = color);
    final roof = Path()
      ..moveTo(cx - w * 0.54, cy - h * 0.18)
      ..lineTo(cx + w * 0.54, cy - h * 0.18)
      ..lineTo(cx + w * 0.54, cy - h * 0.30)
      ..lineTo(cx, cy - h * 0.58)
      ..lineTo(cx - w * 0.54, cy - h * 0.30)
      ..close();
    canvas.drawPath(roof, Paint()..color = const Color(0xFF4E342E));
    canvas.drawRect(
        Rect.fromCenter(center: Offset(cx, cy + h * 0.28), width: w * 0.40, height: h * 0.38),
        Paint()..color = const Color(0xFF4E342E));
    final dp = Paint()..color = Colors.white24..strokeWidth = 1.5;
    canvas.drawLine(Offset(cx - w * 0.20, cy + h * 0.09), Offset(cx + w * 0.20, cy + h * 0.47), dp);
    canvas.drawLine(Offset(cx + w * 0.20, cy + h * 0.09), Offset(cx - w * 0.20, cy + h * 0.47), dp);
  }

  void _cow(Canvas canvas, double cx, double cy, double w, double h, {required bool hasSpots}) {
    final body = Paint()..color = Colors.white;
    final outline = Paint()
      ..color = Colors.black12
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawOval(Rect.fromCenter(center: Offset(cx, cy), width: w, height: h * 0.60), body);
    canvas.drawOval(Rect.fromCenter(center: Offset(cx, cy), width: w, height: h * 0.60), outline);
    canvas.drawOval(Rect.fromCenter(center: Offset(cx - w * 0.46, cy - h * 0.08), width: w * 0.30, height: h * 0.42), body);
    canvas.drawOval(Rect.fromCenter(center: Offset(cx - w * 0.46, cy - h * 0.08), width: w * 0.30, height: h * 0.42), outline);
    _circle(canvas, cx - w * 0.56, cy - h * 0.28, w * 0.06, const Color(0xFFF48FB1));
    _circle(canvas, cx - w * 0.52, cy - h * 0.18, w * 0.025, Colors.black87);
    canvas.drawOval(Rect.fromCenter(center: Offset(cx - w * 0.52, cy + h * 0.02), width: w * 0.10, height: h * 0.10),
        Paint()..color = const Color(0xFFF48FB1));
    final legP = Paint()..color = Colors.white..strokeWidth = w * 0.09..strokeCap = StrokeCap.round;
    final legO = Paint()..color = Colors.black12..strokeWidth = w * 0.09..strokeCap = StrokeCap.round..style = PaintingStyle.stroke;
    for (final dx in [-0.28, -0.10, 0.10, 0.28]) {
      canvas.drawLine(Offset(cx + w * dx, cy + h * 0.28), Offset(cx + w * dx, cy + h * 0.58), legP);
      canvas.drawLine(Offset(cx + w * dx, cy + h * 0.28), Offset(cx + w * dx, cy + h * 0.58), legO);
    }
    if (hasSpots) {
      final sp = Paint()..color = Colors.black87;
      canvas.drawOval(Rect.fromCenter(center: Offset(cx + w * 0.12, cy - h * 0.08), width: w * 0.18, height: h * 0.18), sp);
      canvas.drawOval(Rect.fromCenter(center: Offset(cx - w * 0.06, cy + h * 0.06), width: w * 0.12, height: h * 0.12), sp);
    }
  }

  void _chick(Canvas canvas, double cx, double cy, double r, Color color) {
    _circle(canvas, cx, cy, r, color);
    _circle(canvas, cx, cy - r * 1.22, r * 0.65, color);
    final beak = Path()
      ..moveTo(cx + r * 0.56, cy - r * 1.22)
      ..lineTo(cx + r * 0.90, cy - r * 1.08)
      ..lineTo(cx + r * 0.56, cy - r * 0.94)
      ..close();
    canvas.drawPath(beak, Paint()..color = const Color(0xFFFF8F00));
    _circle(canvas, cx - r * 0.16, cy - r * 1.32, r * 0.12, Colors.black87);
  }

  void _fence(Canvas canvas, Size s, int posts) {
    final w = s.width; final h = s.height;
    final p = Paint()..color = const Color(0xFF8D6E63)..strokeWidth = 2.8..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(0, h * 0.87), Offset(w, h * 0.87), p);
    canvas.drawLine(Offset(0, h * 0.93), Offset(w, h * 0.93), p);
    for (int i = 0; i < posts; i++) {
      final x = w * (i + 0.5) / posts;
      canvas.drawLine(Offset(x, h * 0.82), Offset(x, h * 0.98), p);
    }
  }

  // Space helpers
  void _rocket(Canvas canvas, double cx, double cy, double w, double h, {required bool flipped}) {
    canvas.save();
    canvas.translate(cx, cy);
    if (flipped) canvas.rotate(math.pi);
    // Body
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromCenter(center: Offset.zero, width: w, height: h * 0.55), const Radius.circular(6)),
      Paint()..color = const Color(0xFFEEEEEE),
    );
    // Nose cone
    final nose = Path()
      ..moveTo(-w * 0.50, -h * 0.275)
      ..lineTo(w * 0.50, -h * 0.275)
      ..lineTo(0, -h * 0.50)
      ..close();
    canvas.drawPath(nose, Paint()..color = const Color(0xFFEF5350));
    // Window
    _circle(canvas, 0, -h * 0.08, w * 0.20, const Color(0xFF42A5F5));
    _circle(canvas, 0, -h * 0.08, w * 0.12, const Color(0xFF1A7DBB));
    // Left fin
    final lFin = Path()
      ..moveTo(-w * 0.50, h * 0.20)
      ..lineTo(-w * 0.80, h * 0.42)
      ..lineTo(-w * 0.50, h * 0.42)
      ..close();
    canvas.drawPath(lFin, Paint()..color = const Color(0xFFEF5350));
    // Right fin
    final rFin = Path()
      ..moveTo(w * 0.50, h * 0.20)
      ..lineTo(w * 0.80, h * 0.42)
      ..lineTo(w * 0.50, h * 0.42)
      ..close();
    canvas.drawPath(rFin, Paint()..color = const Color(0xFFEF5350));
    // Flame
    final flame = Path()
      ..moveTo(-w * 0.28, h * 0.42)
      ..lineTo(w * 0.28, h * 0.42)
      ..lineTo(0, h * 0.65)
      ..close();
    canvas.drawPath(flame, Paint()..color = const Color(0xFFFFD04D).withValues(alpha: 0.90));
    canvas.restore();
  }

  void _saturn(Canvas canvas, double cx, double cy, double r, {required Color ringColor}) {
    // Ring back
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx, cy), width: r * 3.2, height: r * 0.80),
      Paint()..color = ringColor.withValues(alpha: 0.40),
    );
    // Planet
    _circle(canvas, cx, cy, r, const Color(0xFFFFCC80));
    _circle(canvas, cx - r * 0.20, cy - r * 0.20, r * 0.35,
        const Color(0xFFFFE0B2).withValues(alpha: 0.60));
    // Ring front
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx, cy + r * 0.10), width: r * 3.2, height: r * 0.50),
      Paint()
        ..color = ringColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = r * 0.22,
    );
  }

  void _earth(Canvas canvas, double cx, double cy, double r, {required bool showLand}) {
    _circle(canvas, cx, cy, r, const Color(0xFF1A7DBB));
    if (showLand) {
      // Continent blobs
      canvas.drawOval(Rect.fromCenter(center: Offset(cx - r * 0.20, cy - r * 0.20), width: r * 0.70, height: r * 0.55),
          Paint()..color = const Color(0xFF4CAF50));
      canvas.drawOval(Rect.fromCenter(center: Offset(cx + r * 0.25, cy + r * 0.20), width: r * 0.50, height: r * 0.40),
          Paint()..color = const Color(0xFF4CAF50));
    }
    // Cloud wisps
    canvas.drawOval(Rect.fromCenter(center: Offset(cx + r * 0.10, cy - r * 0.40), width: r * 0.60, height: r * 0.18),
        Paint()..color = Colors.white.withValues(alpha: 0.55));
  }

  // Kitchen helpers
  void _kitchenWindow(Canvas canvas, double x, double y, double w, double h) {
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(x, y, w, h), const Radius.circular(4)),
        Paint()..color = const Color(0xFFB3E5FC));
    // Frame
    final fp = Paint()..color = Colors.white..strokeWidth = 2.5;
    canvas.drawLine(Offset(x + w / 2, y), Offset(x + w / 2, y + h), fp);
    canvas.drawLine(Offset(x, y + h / 2), Offset(x + w, y + h / 2), fp);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(x, y, w, h), const Radius.circular(4)),
        Paint()..color = Colors.white..style = PaintingStyle.stroke..strokeWidth = 3);
  }

  void _apple(Canvas canvas, double cx, double cy, double r, Color color) {
    _circle(canvas, cx, cy + r * 0.10, r, color);
    // Highlight
    _circle(canvas, cx - r * 0.28, cy - r * 0.22, r * 0.28,
        Colors.white.withValues(alpha: 0.35));
    // Stem
    canvas.drawLine(Offset(cx + r * 0.08, cy - r * 0.90), Offset(cx + r * 0.08, cy - r * 1.20),
        Paint()..color = const Color(0xFF5D4037)..strokeWidth = 2.5..strokeCap = StrokeCap.round);
    // Leaf
    final leaf = Path()
      ..moveTo(cx + r * 0.08, cy - r * 1.10)
      ..quadraticBezierTo(cx + r * 0.50, cy - r * 1.40, cx + r * 0.44, cy - r * 0.90)
      ..quadraticBezierTo(cx + r * 0.24, cy - r * 1.05, cx + r * 0.08, cy - r * 1.10);
    canvas.drawPath(leaf, Paint()..color = const Color(0xFF4CAF50));
  }

  void _banana(Canvas canvas, double cx, double cy, double w) {
    final h = w * 0.36;
    final p = Paint()..color = const Color(0xFFFFD700)..strokeWidth = h..strokeCap = StrokeCap.round..style = PaintingStyle.stroke;
    canvas.drawArc(Rect.fromCenter(center: Offset(cx, cy + h * 0.5), width: w * 1.4, height: h * 2.0),
        math.pi * 1.15, math.pi * 0.70, false, p);
    // Tips
    _circle(canvas, cx - w * 0.52, cy + h * 0.28, h * 0.22, const Color(0xFFFFD700));
    _circle(canvas, cx + w * 0.40, cy - h * 0.60, h * 0.22, const Color(0xFFFFD700));
  }

  void _cup(Canvas canvas, double cx, double cy, double w, double h, Color color) {
    // Trapezoid cup body
    final body = Path()
      ..moveTo(cx - w * 0.40, cy)
      ..lineTo(cx + w * 0.40, cy)
      ..lineTo(cx + w * 0.32, cy + h)
      ..lineTo(cx - w * 0.32, cy + h)
      ..close();
    canvas.drawPath(body, Paint()..color = color);
    // Rim
    canvas.drawOval(Rect.fromCenter(center: Offset(cx, cy), width: w * 0.80, height: h * 0.14),
        Paint()..color = color.withValues(alpha: 0.80));
    // Handle
    final handle = Path()
      ..moveTo(cx + w * 0.38, cy + h * 0.25)
      ..arcTo(Rect.fromCenter(center: Offset(cx + w * 0.56, cy + h * 0.50), width: w * 0.36, height: h * 0.50),
          -math.pi / 2, math.pi, false)
      ..lineTo(cx + w * 0.38, cy + h * 0.75);
    canvas.drawPath(
        handle,
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = h * 0.12
          ..strokeCap = StrokeCap.round);
    // Shine
    canvas.drawLine(Offset(cx - w * 0.20, cy + h * 0.20), Offset(cx - w * 0.14, cy + h * 0.70),
        Paint()..color = Colors.white.withValues(alpha: 0.30)..strokeWidth = h * 0.10..strokeCap = StrokeCap.round);
  }

  void _bowl(Canvas canvas, double cx, double cy, double r, Color color) {
    // Semi-circle bowl
    canvas.drawArc(Rect.fromCenter(center: Offset(cx, cy), width: r * 2.2, height: r * 1.80),
        0, math.pi, true, Paint()..color = color);
    // Rim
    canvas.drawOval(Rect.fromCenter(center: Offset(cx, cy), width: r * 2.2, height: r * 0.36),
        Paint()..color = color.withValues(alpha: 0.80));
    // Inside shadow
    canvas.drawArc(Rect.fromCenter(center: Offset(cx, cy + r * 0.10), width: r * 1.60, height: r * 1.20),
        0, math.pi, true, Paint()..color = Colors.black.withValues(alpha: 0.06));
  }

  // Safari helpers
  void _bird(Canvas canvas, double cx, double cy, double w) {
    final p = Paint()..color = const Color(0xFF1565C0)..strokeWidth = w * 0.22..strokeCap = StrokeCap.round..style = PaintingStyle.stroke;
    canvas.drawArc(Rect.fromCenter(center: Offset(cx - w * 0.28, cy), width: w * 0.60, height: w * 0.30),
        math.pi, math.pi / 2, false, p);
    canvas.drawArc(Rect.fromCenter(center: Offset(cx + w * 0.28, cy), width: w * 0.60, height: w * 0.30),
        math.pi / 2, -math.pi / 2, false, p);
  }

  void _giraffe(Canvas canvas, double cx, double cy, double w, double h,
      {required Color spotColor}) {
    final bodyC = const Color(0xFFFDD835);
    // Legs
    final legP = Paint()..color = const Color(0xFFFFCA28)..strokeWidth = w * 0.10..strokeCap = StrokeCap.round;
    for (final dx in [-0.28, -0.08, 0.08, 0.28]) {
      canvas.drawLine(Offset(cx + w * dx, cy), Offset(cx + w * dx, cy + h * 0.48), legP);
    }
    // Body
    canvas.drawOval(Rect.fromCenter(center: Offset(cx, cy - h * 0.10), width: w, height: h * 0.42), Paint()..color = bodyC);
    // Neck
    canvas.drawRRect(RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(cx - w * 0.20, cy - h * 0.50), width: w * 0.22, height: h * 0.54),
        const Radius.circular(8)), Paint()..color = bodyC);
    // Head
    canvas.drawOval(Rect.fromCenter(center: Offset(cx - w * 0.24, cy - h * 0.78), width: w * 0.30, height: h * 0.22), Paint()..color = bodyC);
    // Ossicones (horns)
    final hornP = Paint()..color = const Color(0xFFFF8F00)..strokeWidth = w * 0.05..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(cx - w * 0.16, cy - h * 0.88), Offset(cx - w * 0.14, cy - h * 0.96), hornP);
    canvas.drawLine(Offset(cx - w * 0.28, cy - h * 0.86), Offset(cx - w * 0.26, cy - h * 0.94), hornP);
    // Eye
    _circle(canvas, cx - w * 0.30, cy - h * 0.80, w * 0.035, Colors.black87);
    // Spots
    final sp = Paint()..color = spotColor;
    canvas.drawOval(Rect.fromCenter(center: Offset(cx + w * 0.12, cy - h * 0.14), width: w * 0.18, height: h * 0.12), sp);
    canvas.drawOval(Rect.fromCenter(center: Offset(cx - w * 0.14, cy - h * 0.04), width: w * 0.14, height: h * 0.10), sp);
    canvas.drawOval(Rect.fromCenter(center: Offset(cx + w * 0.02, cy - h * 0.28), width: w * 0.12, height: h * 0.09), sp);
    canvas.drawOval(Rect.fromCenter(center: Offset(cx - w * 0.16, cy - h * 0.54), width: w * 0.10, height: h * 0.08), sp);
  }

  void _elephant(Canvas canvas, double cx, double cy, double w, double h,
      {required Color bodyColor}) {
    // Legs
    final legP = Paint()..color = bodyColor..strokeWidth = w * 0.14..strokeCap = StrokeCap.round;
    for (final dx in [-0.28, -0.08, 0.10, 0.28]) {
      canvas.drawLine(Offset(cx + w * dx, cy + h * 0.18), Offset(cx + w * dx, cy + h * 0.52), legP);
    }
    // Body
    canvas.drawOval(Rect.fromCenter(center: Offset(cx, cy), width: w, height: h * 0.64), Paint()..color = bodyColor);
    // Head
    canvas.drawOval(Rect.fromCenter(center: Offset(cx - w * 0.44, cy - h * 0.14), width: w * 0.42, height: h * 0.54), Paint()..color = bodyColor);
    // Ear
    canvas.drawOval(Rect.fromCenter(center: Offset(cx - w * 0.56, cy - h * 0.10), width: w * 0.26, height: h * 0.40),
        Paint()..color = bodyColor.withValues(alpha: 0.70));
    canvas.drawOval(Rect.fromCenter(center: Offset(cx - w * 0.55, cy - h * 0.10), width: w * 0.18, height: h * 0.28),
        Paint()..color = const Color(0xFFF48FB1).withValues(alpha: 0.55));
    // Trunk
    final trunk = Path()
      ..moveTo(cx - w * 0.60, cy + h * 0.06)
      ..quadraticBezierTo(cx - w * 0.72, cy + h * 0.30, cx - w * 0.58, cy + h * 0.44);
    canvas.drawPath(trunk, Paint()..color = bodyColor..strokeWidth = w * 0.10..strokeCap = StrokeCap.round..style = PaintingStyle.stroke);
    // Tusk
    canvas.drawLine(Offset(cx - w * 0.56, cy + h * 0.08), Offset(cx - w * 0.70, cy + h * 0.22),
        Paint()..color = Colors.white..strokeWidth = w * 0.06..strokeCap = StrokeCap.round);
    // Eye
    _circle(canvas, cx - w * 0.50, cy - h * 0.22, w * 0.04, Colors.black87);
    _circle(canvas, cx - w * 0.50, cy - h * 0.22, w * 0.018, Colors.white);
  }

  @override
  bool shouldRepaint(_ScenePainter old) => old.scene != scene || old.isB != isB;
}
