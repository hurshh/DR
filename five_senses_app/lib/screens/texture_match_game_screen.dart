import 'dart:async';

import 'package:flutter/material.dart';

import '../models/app_routes.dart';
import '../models/game_result_data.dart';
import '../services/app_data_service.dart';
import '../services/audio_service.dart';

// ─── Data ─────────────────────────────────────────────────────────────────────

class _TextureObject {
  final String name, emoji, correctTexture, funFact;
  final Color cardBg;
  const _TextureObject({
    required this.name,
    required this.emoji,
    required this.correctTexture,
    required this.cardBg,
    required this.funFact,
  });
}

class _TextureDef {
  final String label, subtitle, emoji;
  final Color color, lightBg;
  const _TextureDef({
    required this.label,
    required this.subtitle,
    required this.color,
    required this.lightBg,
    required this.emoji,
  });
}

const List<_TextureObject> _objects = [
  _TextureObject(
    name: 'Sandpaper',   emoji: '📄', correctTexture: 'Rough',
    cardBg: Color(0xFFF5F0EB),
    funFact: 'Sandpaper is coated in millions of tiny sharp mineral grains!',
  ),
  _TextureObject(
    name: 'Mirror',      emoji: '🪞', correctTexture: 'Smooth',
    cardBg: Color(0xFFE3F2FD),
    funFact: 'Mirrors are polished glass — perfectly flat to reflect light!',
  ),
  _TextureObject(
    name: 'Teddy Bear',  emoji: '🧸', correctTexture: 'Soft',
    cardBg: Color(0xFFFCE4EC),
    funFact: 'Teddy bears are made from ultra-soft plush fabric — great for hugging!',
  ),
  _TextureObject(
    name: 'Brick',       emoji: '🧱', correctTexture: 'Rough',
    cardBg: Color(0xFFFBE9E7),
    funFact: 'Bricks are made of fired clay with a gritty, rough surface!',
  ),
  _TextureObject(
    name: 'Ice',         emoji: '🧊', correctTexture: 'Smooth',
    cardBg: Color(0xFFE1F5FE),
    funFact: 'Ice is smooth because water molecules pack tightly as they freeze!',
  ),
  _TextureObject(
    name: 'Cotton Ball', emoji: '☁️', correctTexture: 'Soft',
    cardBg: Color(0xFFF3E5F5),
    funFact: 'Cotton is made from natural plant fibers — fluffy and super soft!',
  ),
  _TextureObject(
    name: 'Orange Peel', emoji: '🍊', correctTexture: 'Bumpy',
    cardBg: Color(0xFFFFF3E0),
    funFact: 'Orange peels have tiny oil pockets that create a bumpy surface!',
  ),
  _TextureObject(
    name: 'Marble',      emoji: '💎', correctTexture: 'Smooth',
    cardBg: Color(0xFFE8EAF6),
    funFact: 'Marble is polished stone — incredibly smooth and cool to touch!',
  ),
  _TextureObject(
    name: 'Pillow',      emoji: '🛏️', correctTexture: 'Soft',
    cardBg: Color(0xFFE8F5E9),
    funFact: 'Pillows are stuffed with soft filling to cushion your head as you sleep!',
  ),
  _TextureObject(
    name: 'Cobblestone', emoji: '🪨', correctTexture: 'Bumpy',
    cardBg: Color(0xFFF1F8E9),
    funFact: 'Cobblestones are uneven rounded rocks — very bumpy to walk on!',
  ),
];

const List<_TextureDef> _textures = [
  _TextureDef(label: 'Rough',  subtitle: 'Gritty & uneven',  color: Color(0xFF8D6E63), lightBg: Color(0xFFEFEBE9), emoji: '🪨'),
  _TextureDef(label: 'Smooth', subtitle: 'Flat & polished',  color: Color(0xFF29B6F6), lightBg: Color(0xFFE1F5FE), emoji: '💧'),
  _TextureDef(label: 'Soft',   subtitle: 'Fluffy & gentle',  color: Color(0xFFEC407A), lightBg: Color(0xFFFCE4EC), emoji: '🌸'),
  _TextureDef(label: 'Bumpy',  subtitle: 'Uneven & lumpy',   color: Color(0xFF66BB6A), lightBg: Color(0xFFE8F5E9), emoji: '🫧'),
];

// ─── Screen ───────────────────────────────────────────────────────────────────

class TextureMatchGameScreen extends StatefulWidget {
  const TextureMatchGameScreen({super.key});

  @override
  State<TextureMatchGameScreen> createState() =>
      _TextureMatchGameScreenState();
}

class _TextureMatchGameScreenState extends State<TextureMatchGameScreen> {
  static const _headerColor = Color(0xFFFF7A3B);
  static const _totalSeconds = 90;
  static const _maxLives = 5;

  int _index = 0;
  int _score = 0;
  int _lives = _maxLives;
  int _secondsLeft = _totalSeconds;
  String? _selectedTexture;
  bool _answered = false;
  Timer? _timer;

  _TextureObject get _current => _objects[_index];
  bool get _isCorrect => _selectedTexture == _current.correctTexture;

  @override
  void initState() {
    super.initState();
    _startTimer();
    Future.delayed(const Duration(milliseconds: 400), () {
      AudioService.instance.speak(
        'Welcome to Texture Match! Look at each object and decide if it feels Rough, Smooth, Soft, or Bumpy. You have 5 lives and 90 seconds. Let\'s go!',
      );
    });
    Future.delayed(const Duration(seconds: 8), _speakPrompt);
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
    AudioService.instance.speak(
        'What texture does ${_current.name} have?');
  }

  void _onTextureTapped(_TextureDef texture) {
    if (_answered || _lives <= 0) return;
    final correct = texture.label == _current.correctTexture;
    setState(() {
      _selectedTexture = texture.label;
      _answered = true;
      if (correct) {
        _score += 200;
      } else {
        _lives = (_lives - 1).clamp(0, _maxLives);
        if (_lives == 0) _timer?.cancel();
      }
    });
    if (correct) {
      AudioService.instance.speak('Correct! ${_current.name} is ${_current.correctTexture}!');
    } else {
      AudioService.instance.speak('Not quite! ${_current.name} is ${_current.correctTexture}.');
    }
  }

  void _onNext() {
    AudioService.instance.stop();
    if (_lives <= 0 || _index >= _objects.length - 1) {
      _navigateToResult();
      return;
    }
    setState(() {
      _index++;
      _selectedTexture = null;
      _answered = false;
    });
    Future.delayed(const Duration(milliseconds: 300), _speakPrompt);
  }

  void _navigateToResult() {
    _timer?.cancel();
    AppDataService.instance.markGameCompleted('texture_match');
    final secondsUsed = _totalSeconds - _secondsLeft;
    final correct = _score ~/ 200;
    final data = GameResultData(
      gameTitle: 'Texture Match',
      gameEmoji: '🤚',
      score: _score,
      correct: correct,
      total: _objects.length,
      secondsUsed: secondsUsed,
    );
    AppDataService.instance.saveGameStars('texture_match', data.stars);
    Navigator.pushReplacementNamed(context, Routes.gameResult, arguments: data);
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

  Future<void> _showQuitDialog() async {
    final quit = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title:
            const Text('End Game?', style: TextStyle(fontWeight: FontWeight.w900)),
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.shortestSide >= 600;
    final obj = _current;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF4EF),
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
                        Text('What does this feel like?',
                            style: TextStyle(
                                fontSize: isTablet ? 22 : 18,
                                fontWeight: FontWeight.w900,
                                color: const Color(0xFF2A2A2A))),
                        const SizedBox(height: 12),
                        _buildObjectCard(obj, isTablet),
                        const SizedBox(height: 12),
                        Text('Tap the texture it belongs to 👇',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFB7B7B7),
                                fontSize: isTablet ? 17 : 15)),
                        const SizedBox(height: 12),
                        _buildTextureGrid(obj, isTablet),
                        const SizedBox(height: 14),
                        if (_answered) ...[
                          _buildFeedbackBanner(obj, isTablet),
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

  Widget _buildHeader(bool isTablet) {
    final progress = (_index + 1) / _objects.length;
    return Container(
      height: isTablet ? 180.0 : 150.0,
      width: double.infinity,
      color: _headerColor,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(8, isTablet ? 26 : 18, 18, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => Navigator.pushReplacementNamed(
                      context, Routes.textureMatchIntro),
                  icon: const Icon(Icons.arrow_back_ios_rounded,
                      color: Colors.white, size: 22),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(width: 6),
                Text('Texture Match',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: isTablet ? 28 : 22)),
                const Spacer(),
                // Timer
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 300),
                  style: TextStyle(
                      color: _timerColor,
                      fontWeight: FontWeight.w900,
                      fontSize: isTablet ? 18 : 15),
                  child: Row(children: [
                    Icon(Icons.timer_outlined,
                        color: _timerColor, size: isTablet ? 22 : 18),
                    const SizedBox(width: 4),
                    Text(_timerLabel),
                  ]),
                ),
                const SizedBox(width: 16),
                // Score
                Row(children: [
                  Icon(Icons.auto_awesome_rounded,
                      color: const Color(0xFFFFD54A),
                      size: isTablet ? 22 : 18),
                  const SizedBox(width: 4),
                  Text('$_score',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: isTablet ? 18 : 15)),
                ]),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: _showQuitDialog,
                  icon: const Icon(Icons.close_rounded, color: Colors.white),
                  tooltip: 'End Game',
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          Positioned(
            left: 18,
            bottom: 22,
            child: Text('Object ${_index + 1} of ${_objects.length}',
                style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontWeight: FontWeight.w700,
                    fontSize: isTablet ? 16 : 14)),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 5,
              backgroundColor: Colors.white.withValues(alpha: 0.25),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Color(0xFFFFD54A)),
            ),
          ),
        ],
      ),
    );
  }

  // ── Object card ───────────────────────────────────────────────────────────

  Widget _buildObjectCard(_TextureObject obj, bool isTablet) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          vertical: isTablet ? 30 : 22, horizontal: 16),
      decoration: BoxDecoration(
        color: obj.cardBg,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
              color: Color(0x14000000),
              blurRadius: 14,
              offset: Offset(0, 5))
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(obj.emoji,
              style: TextStyle(fontSize: isTablet ? 72.0 : 58.0)),
          const SizedBox(height: 10),
          Text(obj.name,
              style: TextStyle(
                  fontSize: isTablet ? 26.0 : 20.0,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF2A2A2A))),
        ],
      ),
    );
  }

  // ── Texture option grid ───────────────────────────────────────────────────

  Widget _buildTextureGrid(_TextureObject obj, bool isTablet) {
    final colCount = isTablet ? 4 : 2;
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: colCount,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: isTablet ? 0.75 : 0.9,
      ),
      itemCount: _textures.length,
      itemBuilder: (_, i) {
        final tex = _textures[i];
        final isSelected = _selectedTexture == tex.label;
        final isCorrectAnswer = tex.label == obj.correctTexture;

        Color bg;
        Color borderColor;
        double bw;
        if (!_answered) {
          bg = isSelected ? tex.lightBg : Colors.white;
          borderColor = isSelected ? tex.color : const Color(0xFFEAEAEA);
          bw = isSelected ? 2.5 : 1.5;
        } else if (isSelected && _isCorrect) {
          bg = tex.lightBg;
          borderColor = tex.color;
          bw = 2.5;
        } else if (!_isCorrect && isCorrectAnswer) {
          bg = const Color(0xFFE8F5E9);
          borderColor = const Color(0xFF43A047);
          bw = 2.5;
        } else if (isSelected && !_isCorrect) {
          bg = const Color(0xFFFFEBEE);
          borderColor = Colors.red.shade300;
          bw = 2.5;
        } else {
          bg = Colors.white;
          borderColor = const Color(0xFFEAEAEA);
          bw = 1.5;
        }

        Widget? badge;
        if (_answered && isSelected && _isCorrect) {
          badge = _CircleBadge(icon: Icons.check_rounded, bg: tex.color);
        } else if (_answered && isSelected && !_isCorrect) {
          badge =
              const _CircleBadge(icon: Icons.close_rounded, bg: Colors.red);
        } else if (_answered && !_isCorrect && isCorrectAnswer) {
          badge = const _CircleBadge(
              icon: Icons.check_rounded, bg: Color(0xFF43A047));
        }

        return GestureDetector(
          onTap: () => _onTextureTapped(tex),
          child: Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: borderColor, width: bw),
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0x0A000000),
                        blurRadius: 8,
                        offset: Offset(0, 3))
                  ],
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(tex.emoji,
                        style: TextStyle(
                            fontSize: isTablet ? 28.0 : 26.0)),
                    const SizedBox(height: 8),
                    Text(tex.label,
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF2A2A2A))),
                    const SizedBox(height: 2),
                    Text(tex.subtitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFB7B7B7))),
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

  // ── Feedback ──────────────────────────────────────────────────────────────

  Widget _buildFeedbackBanner(_TextureObject obj, bool isTablet) {
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
                  fontSize: titleFs)),
          const SizedBox(height: 4),
          Text('${obj.name} is ${obj.correctTexture}! ${obj.funFact}',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.red.shade700,
                  fontSize: bodyFs)),
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
                  fontSize: titleFs)),
          const SizedBox(height: 4),
          Text(obj.funFact,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF388E3C),
                  fontSize: bodyFs)),
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
                fontSize: titleFs)),
        const SizedBox(height: 4),
        Text('${obj.name} is ${obj.correctTexture}! ${obj.funFact}',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.red.shade700,
                fontSize: bodyFs)),
      ],
    );
  }

  Widget _buildNextButton(bool isTablet) {
    final isLast = _index >= _objects.length - 1 || _lives <= 0;
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
          isLast ? 'See Results 🏆' : 'Next Object →',
          style: TextStyle(
              fontSize: isTablet ? 20 : 18,
              fontWeight: FontWeight.w900),
        ),
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
              filled
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              key: ValueKey(filled),
              color: filled
                  ? const Color(0xFFFF7C93)
                  : const Color(0xFFDDDDDD),
              size: sz,
            ),
          ),
        );
      }),
    );
  }
}

// ─── Small shared widgets ─────────────────────────────────────────────────────

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
  const _FeedbackCard(
      {required this.bg, required this.border, required this.children});

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
          crossAxisAlignment: CrossAxisAlignment.start, children: children),
    );
  }
}
