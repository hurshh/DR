import 'package:flutter/material.dart';

import '../models/app_routes.dart';

class TextureMatchIntroScreen extends StatelessWidget {
  const TextureMatchIntroScreen({super.key});

  static const _headerColor = Color(0xFFFF7A3B);
  static const _bgColor = Color(0xFFFFF4EF);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.shortestSide >= 600;

    return Scaffold(
      backgroundColor: _bgColor,
      body: Column(
        children: [
          _buildHeader(context, isTablet),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                  isTablet ? 28 : 18, 22, isTablet ? 28 : 18, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Feel 4 different textures:',
                    style: TextStyle(
                      fontSize: isTablet ? 22 : 18,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF2A2A2A),
                    ),
                  ),
                  const SizedBox(height: 14),
                  _TextureRow(
                    color: const Color(0xFF8D6E63),
                    emoji: '🪨',
                    title: 'Rough',
                    subtitle: 'Gritty • Sandpaper, Gravel, Brick',
                    isTablet: isTablet,
                  ),
                  const SizedBox(height: 10),
                  _TextureRow(
                    color: const Color(0xFF29B6F6),
                    emoji: '💧',
                    title: 'Smooth',
                    subtitle: 'Flat & polished • Glass, Marble, Ice',
                    isTablet: isTablet,
                  ),
                  const SizedBox(height: 10),
                  _TextureRow(
                    color: const Color(0xFFEC407A),
                    emoji: '🌸',
                    title: 'Soft',
                    subtitle: 'Fluffy & gentle • Cotton, Feather, Pillow',
                    isTablet: isTablet,
                  ),
                  const SizedBox(height: 10),
                  _TextureRow(
                    color: const Color(0xFF66BB6A),
                    emoji: '🫧',
                    title: 'Bumpy',
                    subtitle: 'Uneven & lumpy • Orange peel, Cobblestone',
                    isTablet: isTablet,
                  ),
                  const SizedBox(height: 22),
                  // Fun fact card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(isTablet ? 20 : 16),
                    decoration: BoxDecoration(
                      color: _headerColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: [
                        Text('👋',
                            style: TextStyle(fontSize: isTablet ? 28 : 22)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Did you know? Your fingertips have up to 3,000 touch receptors — the most sensitive part of your whole body!',
                            style: TextStyle(
                              fontSize: isTablet ? 15 : 13,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF7A3300),
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  // How to play card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(isTablet ? 20 : 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: const [
                        BoxShadow(
                            color: Color(0x0D000000),
                            blurRadius: 10,
                            offset: Offset(0, 3))
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Icon(Icons.touch_app_rounded,
                              color: _headerColor, size: isTablet ? 26 : 22),
                          const SizedBox(width: 8),
                          Text('How to Play',
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: isTablet ? 18 : 16,
                                  color: const Color(0xFF2A2A2A))),
                        ]),
                        const SizedBox(height: 10),
                        _HowToRow('Look at each object shown on screen.',
                            isTablet: isTablet),
                        _HowToRow(
                            'Imagine how it would feel if you touched it.',
                            isTablet: isTablet),
                        _HowToRow(
                            'Tap Rough, Smooth, Soft or Bumpy to classify it!',
                            isTablet: isTablet),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  SizedBox(
                    height: isTablet ? 68 : 60,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pushReplacementNamed(
                          context, Routes.textureMatchGame),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _headerColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.touch_app_rounded, size: 26),
                          const SizedBox(width: 10),
                          Text('Start Touching! 👋',
                              style: TextStyle(
                                  fontSize: isTablet ? 22 : 20,
                                  fontWeight: FontWeight.w900)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: Text(
                      '10 objects • 90 seconds • 5 lives',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFB7B7B7),
                          fontSize: isTablet ? 16 : 14),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isTablet) {
    return Container(
      width: double.infinity,
      color: _headerColor,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 8, 18, 0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pushReplacementNamed(
                        context, Routes.playPick),
                    icon: const Icon(Icons.arrow_back_ios_rounded,
                        color: Colors.white, size: 22),
                  ),
                  const SizedBox(width: 4),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Texture Match',
                          style: TextStyle(
                              fontSize: isTablet ? 28 : 24,
                              fontWeight: FontWeight.w900,
                              color: Colors.white)),
                      Text('Touch Sense 👋',
                          style: TextStyle(
                              fontSize: isTablet ? 15 : 13,
                              fontWeight: FontWeight.w700,
                              color: Colors.white.withOpacity(0.85))),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
              alignment: Alignment.center,
              child: const Icon(Icons.pan_tool_outlined,
                  size: 60, color: Color(0xFFFF7A3B)),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _TextureRow extends StatelessWidget {
  final Color color;
  final String emoji, title, subtitle;
  final bool isTablet;

  const _TextureRow({
    required this.color,
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 14, vertical: isTablet ? 14 : 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
              color: Color(0x0D000000), blurRadius: 8, offset: Offset(0, 3))
        ],
      ),
      child: Row(
        children: [
          Container(
              width: 5,
              height: isTablet ? 54 : 44,
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(12))),
          const SizedBox(width: 12),
          Container(
            width: isTablet ? 52 : 44,
            height: isTablet ? 52 : 44,
            decoration: BoxDecoration(
                color: color.withOpacity(0.12), shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Text(emoji,
                style: TextStyle(fontSize: isTablet ? 24 : 20)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontSize: isTablet ? 20 : 17,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF2A2A2A))),
                const SizedBox(height: 2),
                Text(subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: isTablet ? 14 : 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFB7B7B7))),
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(20)),
            child: Text(title,
                style: TextStyle(
                    fontSize: isTablet ? 13 : 11,
                    fontWeight: FontWeight.w800,
                    color: color)),
          ),
        ],
      ),
    );
  }
}

class _HowToRow extends StatelessWidget {
  final String text;
  final bool isTablet;
  const _HowToRow(this.text, {required this.isTablet});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline_rounded,
              size: 18, color: Color(0xFFFF7A3B)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text,
                style: TextStyle(
                    fontSize: isTablet ? 15 : 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF555555),
                    height: 1.4)),
          ),
        ],
      ),
    );
  }
}
