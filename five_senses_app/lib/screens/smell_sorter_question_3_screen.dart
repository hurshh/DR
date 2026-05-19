import 'package:flutter/material.dart';

import '../models/app_routes.dart';

class SmellSorterQuestion3Screen extends StatelessWidget {
  const SmellSorterQuestion3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    const headerColor = Color(0xFFF5D457);
    final isCorrect = true;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F0B7),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 84,
              width: double.infinity,
              color: headerColor,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: LinearProgressIndicator(
                      value: 3 / 8,
                      minHeight: 6,
                      backgroundColor: const Color(0xFFECE1A7),
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Color(0xFFF36B3B)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 28, 18, 0),
                    child: Row(
                      children: [
                        const Text(
                          'Item 3 / 8',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                            color: Color(0xFF2A2A2A),
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            const Icon(Icons.timer_outlined,
                                size: 18, color: Color(0xFF2A2A2A)),
                            const SizedBox(width: 6),
                            const Text(
                              '1:12',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF2A2A2A),
                              ),
                            ),
                            const SizedBox(width: 18),
                            const Icon(Icons.auto_awesome_rounded,
                                size: 18, color: Colors.black54),
                            const SizedBox(width: 6),
                            const Text(
                              '6',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF2A2A2A),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(18, 14, 18, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'What does this smell like?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF2A2A2A),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 132,
                            height: 132,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFFFDD63),
                            ),
                            alignment: Alignment.center,
                            child: const Icon(Icons.local_florist_rounded,
                                size: 62, color: Colors.red),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Rose',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF2A2A2A),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Drag to the right bucket 👇',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFB0B0B0),
                      ),
                    ),
                    const SizedBox(height: 12),
                    GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: 1.0,
                      children: [
                        _BucketCard(
                          title: 'Floral',
                          bg: Colors.red.withOpacity(0.28),
                          icon: Icons.local_florist_rounded,
                          selected: true,
                          correct: isCorrect,
                        ),
                        _BucketCard(
                          title: 'Food',
                          bg: Colors.white,
                          icon: Icons.fastfood_rounded,
                          selected: false,
                          correct: false,
                        ),
                        _BucketCard(
                          title: 'Nature',
                          bg: Colors.white,
                          icon: Icons.eco_rounded,
                          selected: false,
                          correct: false,
                        ),
                        _BucketCard(
                          title: 'Fresh',
                          bg: Colors.white,
                          icon: Icons.water_drop_rounded,
                          selected: false,
                          correct: false,
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF7C93),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Text(
                        'Correct! Rose is Floral! +2 🌟',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () =>
                            Navigator.pushReplacementNamed(context, Routes.gameResult),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFDE074),
                          foregroundColor: const Color(0xFF2A2A2A),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Next Smell →',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        5,
                        (i) => const Icon(Icons.favorite_rounded,
                            color: Color(0xFFFF7C93), size: 20),
                      ),
                    ),
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

class _BucketCard extends StatelessWidget {
  final String title;
  final Color bg;
  final IconData icon;
  final bool selected;
  final bool correct;

  const _BucketCard({
    required this.title,
    required this.bg,
    required this.icon,
    required this.selected,
    required this.correct,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: selected ? Colors.transparent : const Color(0xFFEAEAEA),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 12,
            left: 12,
            child: CircleAvatar(
              radius: 22,
              backgroundColor: selected ? Colors.white : Colors.transparent,
              child: Icon(icon,
                  size: 28,
                  color: selected
                      ? const Color(0xFFFF7C93)
                      : const Color(0xFFB0B0B0)),
            ),
          ),
          Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: selected ? const Color(0xFFFF7C93) : const Color(0xFF7A7A7A),
              ),
            ),
          ),
          if (selected && correct)
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF45E6C1),
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.check_rounded,
                    color: Colors.white, size: 18),
              ),
            ),
        ],
      ),
    );
  }
}

