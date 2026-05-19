import 'package:flutter/material.dart';

import '../models/app_routes.dart';
import '../models/sense.dart';
import '../theme/app_theme.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/five_senses_scaffold.dart';
import '../widgets/sense_card.dart';

class OurFiveSensesScreen extends StatelessWidget {
  const OurFiveSensesScreen({super.key});

  static const _headerColor = AppTheme.teal;

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.shortestSide >= 600;

    return FiveSensesScaffold(
      selectedTabIndex: 1,
      onBottomNavTap: (tab) {
        switch (tab) {
          case BottomTab.home:
            Navigator.pushReplacementNamed(context, Routes.home);
            break;
          case BottomTab.learn:
            Navigator.pushReplacementNamed(context, Routes.ourFiveSenses);
            break;
          case BottomTab.play:
            Navigator.pushReplacementNamed(context, Routes.playPick);
            break;
        }
      },
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                isTablet ? 28 : 18,
                isTablet ? 24 : 14,
                isTablet ? 28 : 18,
                24,
              ),
              child: isTablet
                  ? _buildTabletGrid(context)
                  : _buildPhoneGrid(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.shortestSide >= 600;

    return Container(
      width: double.infinity,
      color: _headerColor,
      child: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            // Decorative bubbles
            Positioned(top: -70, left: -50,
                child: _Bubble(color: Colors.white.withOpacity(0.08))),
            Positioned(top: -50, right: -40,
                child: _Bubble(color: Colors.white.withOpacity(0.08))),
            // Content
            Padding(
              padding: EdgeInsets.fromLTRB(8, 10, 18, isTablet ? 28 : 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pushReplacementNamed(
                            context, Routes.home),
                        icon: const Icon(Icons.arrow_back_ios_rounded,
                            color: Colors.white),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Five Senses',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.white.withOpacity(0.9),
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Our Five Senses',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w900,
                                fontSize: isTablet ? 40 : 32,
                                color: Colors.white,
                              ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Tap a sense to explore it!',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                color: Colors.white.withOpacity(0.82),
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Phone: 2-col grid + full-width touch card ─────────────────────────────

  Widget _buildPhoneGrid(BuildContext context) {
    return Column(
      children: [
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          childAspectRatio: 1 / 1.08,
          children: [
            _senseCard(context, SenseType.sight),
            _senseCard(context, SenseType.hearing),
            _senseCard(context, SenseType.smell),
            _senseCard(context, SenseType.taste),
          ],
        ),
        const SizedBox(height: 14),
        _touchCard(context),
        const SizedBox(height: 14),
        _progressPill(context),
      ],
    );
  }

  // ── Tablet: 3-col grid with touch card in last slot ──────────────────────

  Widget _buildTabletGrid(BuildContext context) {
    return Column(
      children: [
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          childAspectRatio: 1.1,
          children: [
            _senseCard(context, SenseType.sight),
            _senseCard(context, SenseType.hearing),
            _senseCard(context, SenseType.smell),
            _senseCard(context, SenseType.taste),
            _touchCard(context),
          ],
        ),
        const SizedBox(height: 20),
        _progressPill(context),
      ],
    );
  }

  Widget _senseCard(BuildContext context, SenseType type) {
    final model = senses.firstWhere((s) => s.type == type);
    return SenseCard(
      title: model.title,
      subtitle: model.subtitle,
      icon: model.icon,
      cardColor: model.chipColor,
      filled: false,
      onTap: () {
        if (type == SenseType.sight) {
          Navigator.pushReplacementNamed(context, Routes.sightDetail);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('This sense is coming soon.')),
          );
        }
      },
    );
  }

  Widget _touchCard(BuildContext context) {
    final model = senses.firstWhere((s) => s.type == SenseType.touch);
    return SenseCard(
      title: model.title,
      subtitle: model.subtitle,
      icon: model.icon,
      cardColor: model.chipColor,
      filled: false,
      width: double.infinity,
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Touch is coming soon.')),
        );
      },
    );
  }

  Widget _progressPill(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.orangeDeep.withOpacity(0.95),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        '2 / 5 Senses Explored ✨',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.2,
            ),
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  final Color color;
  const _Bubble({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 210,
      height: 210,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}
