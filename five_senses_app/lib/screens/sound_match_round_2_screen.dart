import 'package:flutter/material.dart';

import '../models/app_routes.dart';
import '../theme/app_theme.dart';

class SoundMatchRound2Screen extends StatelessWidget {
  const SoundMatchRound2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    const headerColor = Color(0xFF53D2C7);

    return Scaffold(
      backgroundColor: const Color(0xFFE6FAFC),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 150,
              width: double.infinity,
              color: headerColor,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 14, 18, 10),
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
                        const Icon(Icons.waves_rounded,
                            color: Colors.white, size: 26),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 0, 18, 10),
                    child: Row(
                      children: [
                        const Text(
                          'Round 2 / 6',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            const Icon(Icons.timer_outlined,
                                color: Colors.white, size: 18),
                            const SizedBox(width: 8),
                            const Text(
                              '0:28',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(width: 18),
                            const Icon(Icons.auto_awesome_rounded,
                                color: Color(0xFFFFD54A), size: 18),
                            const SizedBox(width: 8),
                            const Text(
                              '12',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 4,
                    width: double.infinity,
                    color: const Color(0xFFFFD54A),
                  )
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(18, 16, 18, 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 58,
                            height: 58,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: headerColor,
                            ),
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.play_arrow_rounded,
                              size: 26,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  '••••••••••',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xFF9B9B9B),
                                  ),
                                ),
                                SizedBox(height: 6),
                                Center(
                                  child: Text(
                                    '??? Sound',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFFB1B1B1),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
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
                      'Tap the correct answer 👇',
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
                        _AnswerCard(
                          label: 'Dog',
                          icon: Icons.pets_rounded,
                          selected: false,
                        ),
                        _AnswerCard(
                          label: 'Bell',
                          icon: Icons.add_alarm_rounded,
                          selected: true,
                        ),
                        _AnswerCard(
                          label: 'Rain',
                          icon: Icons.water_drop_rounded,
                          selected: false,
                        ),
                        _AnswerCard(
                          label: 'Piano',
                          icon: Icons.spa_rounded,
                          selected: false,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 18),
                      decoration: BoxDecoration(
                        color: const Color(0xFF45E6C1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Text(
                        'Correct! A bell makes that sound!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      height: 58,
                      child: ElevatedButton(
                        onPressed: () =>
                            Navigator.pushReplacementNamed(context, Routes.gameResult),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: headerColor,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                        child: const Text(
                          'Next Round →',
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
                            color: const Color(0xFFFF6B6B), size: 20),
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

class _AnswerCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;

  const _AnswerCard({
    required this.label,
    required this.icon,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: selected ? const Color(0xFF53D2C7) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: selected ? const Color(0xFF53D2C7) : const Color(0xFFE5E5E5),
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 14),
                Icon(icon,
                    size: 44,
                    color: selected ? Colors.white : const Color(0xFF2A2A2A)),
                const SizedBox(height: 12),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: selected ? Colors.white : const Color(0xFF2A2A2A),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          if (selected)
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
                child: const Icon(Icons.check_rounded,
                    color: Color(0xFF53D2C7), size: 18),
              ),
            ),
        ],
      ),
    );
  }
}

