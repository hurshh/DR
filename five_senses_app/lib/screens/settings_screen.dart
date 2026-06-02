import 'package:flutter/material.dart';

import '../models/app_routes.dart';
import '../services/app_data_service.dart';
import '../theme/app_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final TextEditingController _nameController;
  bool _nameSaved = false;

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: AppDataService.instance.userName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _saveName() async {
    final name = _nameController.text.trim();
    await AppDataService.instance
        .saveUserName(name.isEmpty ? 'Explorer' : name);
    if (!mounted) return;
    setState(() => _nameSaved = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _nameSaved = false);
  }

  Future<void> _confirmReset() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Reset Everything?',
            style: TextStyle(fontWeight: FontWeight.w900)),
        content: const Text(
          'This will erase your name, all explored senses, game completions '
          'and star ratings. You\'ll start fresh from onboarding.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Reset'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      await AppDataService.instance.resetAll();
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, Routes.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    final svc = AppDataService.instance;
    final exploredCount = svc.exploredSenses.length;
    final completedCount = svc.completedGames.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          // ── Header ──────────────────────────────────────────────────────────
          Container(
            color: AppTheme.orange,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding:
                    const EdgeInsets.fromLTRB(8, 10, 18, 18),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () =>
                          Navigator.pushReplacementNamed(context, Routes.home),
                      icon: const Icon(Icons.arrow_back_ios_rounded,
                          color: Colors.white),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Settings',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                    const Spacer(),
                    const Icon(Icons.settings_rounded,
                        color: Colors.white70, size: 22),
                  ],
                ),
              ),
            ),
          ),

          // ── Body ────────────────────────────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 22, 18, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Profile ────────────────────────────────────────────────
                  _sectionLabel('Your Profile'),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.fromLTRB(18, 14, 18, 18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0A000000),
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Display Name',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF9A9A9A),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _nameController,
                          textCapitalization: TextCapitalization.words,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2A2A2A),
                          ),
                          decoration: InputDecoration(
                            hintText: 'Enter your name',
                            hintStyle: TextStyle(
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.w500,
                            ),
                            prefixIcon: const Icon(
                              Icons.person_outline_rounded,
                              color: AppTheme.orange,
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF8F8F8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                          ),
                          onSubmitted: (_) => _saveName(),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _saveName,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _nameSaved
                                  ? const Color(0xFF45E6C1)
                                  : AppTheme.orange,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  _nameSaved
                                      ? Icons.check_rounded
                                      : Icons.save_rounded,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  _nameSaved ? 'Saved!' : 'Save Name',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 26),

                  // ── Progress ───────────────────────────────────────────────
                  _sectionLabel('Your Progress'),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: _StatTile(
                          icon: Icons.visibility_rounded,
                          color: AppTheme.teal,
                          value: '$exploredCount / 5',
                          label: 'Senses Explored',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _StatTile(
                          icon: Icons.sports_esports_rounded,
                          color: AppTheme.orange,
                          value: '$completedCount / 5',
                          label: 'Games Completed',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _StarSummaryCard(svc: svc),

                  const SizedBox(height: 26),

                  // ── Danger zone ────────────────────────────────────────────
                  _sectionLabel('Reset'),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0A000000),
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Erase all progress and start over from the beginning.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF9A9A9A),
                            fontWeight: FontWeight.w500,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 14),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton.icon(
                            onPressed: _confirmReset,
                            icon: const Icon(Icons.delete_forever_rounded,
                                size: 20),
                            label: const Text(
                              'Reset All Progress',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)),
                            ),
                          ),
                        ),
                      ],
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

  Widget _sectionLabel(String text) => Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w800,
          color: Color(0xFF9A9A9A),
          letterSpacing: 0.8,
        ),
      );
}

// ── Stat tile ─────────────────────────────────────────────────────────────────

class _StatTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String value;
  final String label;

  const _StatTile({
    required this.icon,
    required this.color,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              color: Color(0xFF2A2A2A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF9A9A9A),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Star summary card ─────────────────────────────────────────────────────────

class _StarSummaryCard extends StatelessWidget {
  final AppDataService svc;
  const _StarSummaryCard({required this.svc});

  static const _games = [
    ('spot_difference', '🔍', 'Spot the Diff'),
    ('sound_match', '🎵', 'Sound Match'),
    ('smell_sorter', '👃', 'Smell Sorter'),
    ('taste_classifier', '👅', 'Taste Classifier'),
    ('texture_match', '🤚', 'Texture Match'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Best Stars Per Game',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w900,
              color: Color(0xFF2A2A2A),
            ),
          ),
          const SizedBox(height: 12),
          for (final (id, emoji, name) in _games) ...[
            _GameStarRow(
              emoji: emoji,
              name: name,
              stars: svc.getBestStars(id),
            ),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}

class _GameStarRow extends StatelessWidget {
  final String emoji;
  final String name;
  final int stars; // 0–5

  const _GameStarRow(
      {required this.emoji, required this.name, required this.stars});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 18)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF3A3A3A),
            ),
          ),
        ),
        Row(
          children: List.generate(
            5,
            (i) => Icon(
              Icons.star_rounded,
              size: 16,
              color: i < stars
                  ? const Color(0xFFFFD54A)
                  : const Color(0xFFDADADA),
            ),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          stars == 0 ? 'Not played' : '$stars / 5',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: stars == 0
                ? const Color(0xFFB0B0B0)
                : const Color(0xFF9A9A9A),
          ),
        ),
      ],
    );
  }
}
