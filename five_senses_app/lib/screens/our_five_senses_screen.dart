import 'package:flutter/material.dart';

import '../models/app_routes.dart';
import '../models/sense.dart';
import '../services/app_data_service.dart';
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

  // ── Phone: 2-col rows + full-width touch ─────────────────────────────────
  // LayoutBuilder lives HERE (not inside SenseCard) so IntrinsicHeight can
  // query intrinsic dimensions without hitting the LayoutBuilder restriction.

  Widget _buildPhoneGrid(BuildContext context) {
    const sp = 14.0;
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardW       = (constraints.maxWidth - sp) / 2;
        final iconContSz  = (cardW * 0.30).clamp(52.0, 74.0);
        final iconSz      = iconContSz * 0.48;

        SenseCard card(SenseType type) =>
            _buildCard(context, type, iconContSz, iconSz);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: card(SenseType.sight)),
                  const SizedBox(width: sp),
                  Expanded(child: card(SenseType.hearing)),
                ],
              ),
            ),
            const SizedBox(height: sp),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: card(SenseType.smell)),
                  const SizedBox(width: sp),
                  Expanded(child: card(SenseType.taste)),
                ],
              ),
            ),
            const SizedBox(height: sp),
            // Touch — full width
            card(SenseType.touch),
            const SizedBox(height: sp),
            _progressPill(context),
          ],
        );
      },
    );
  }

  // ── Tablet: 3-col row + 2-col row (no empty slot) ────────────────────────

  Widget _buildTabletGrid(BuildContext context) {
    const sp = 18.0;
    return LayoutBuilder(
      builder: (context, constraints) {
        final totalW = constraints.maxWidth;

        // Row 1 cards are narrower (3-col) → smaller icon
        final card3W     = (totalW - 2 * sp) / 3;
        final iconCont3  = (card3W * 0.28).clamp(52.0, 76.0);
        final iconSz3    = iconCont3 * 0.48;

        // Row 2 cards are wider (2-col) → slightly larger icon but capped
        final card2W     = (totalW - sp) / 2;
        final iconCont2  = (card2W * 0.20).clamp(52.0, 80.0);
        final iconSz2    = iconCont2 * 0.48;

        SenseCard card3(SenseType type) =>
            _buildCard(context, type, iconCont3, iconSz3);
        SenseCard card2(SenseType type) =>
            _buildCard(context, type, iconCont2, iconSz2);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Row 1 — Sight | Hearing | Smell
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: card3(SenseType.sight)),
                  const SizedBox(width: sp),
                  Expanded(child: card3(SenseType.hearing)),
                  const SizedBox(width: sp),
                  Expanded(child: card3(SenseType.smell)),
                ],
              ),
            ),
            const SizedBox(height: sp),
            // Row 2 — Taste | Touch  (50 % each — no empty slot)
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: card2(SenseType.taste)),
                  const SizedBox(width: sp),
                  Expanded(child: card2(SenseType.touch)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _progressPill(context),
          ],
        );
      },
    );
  }

  /// Builds a [SenseCard] with explicit icon sizes determined by the
  /// LayoutBuilder in each grid method. No LayoutBuilder inside the card.
  SenseCard _buildCard(
    BuildContext context,
    SenseType type,
    double iconContainerSize,
    double iconSize,
  ) {
    final model = senses.firstWhere((s) => s.type == type);
    return SenseCard(
      title: model.title,
      subtitle: model.subtitle,
      icon: model.icon,
      cardColor: model.chipColor,
      filled: false,
      iconContainerSize: iconContainerSize,
      iconSize: iconSize,
      onTap: () => _navigateToDetail(context, type),
    );
  }

  // Legacy helper kept for any callers outside the grid builders.
  Widget _senseCard(BuildContext context, SenseType type) =>
      _buildCard(context, type, 68, 32);

  Widget _touchCard(BuildContext context) =>
      _senseCard(context, SenseType.touch);

  void _navigateToDetail(BuildContext context, SenseType type) {
    final svc = AppDataService.instance;
    switch (type) {
      case SenseType.sight:
        svc.markSenseExplored('sight');
        Navigator.pushReplacementNamed(context, Routes.sightDetail);
        break;
      case SenseType.hearing:
        svc.markSenseExplored('hearing');
        Navigator.pushReplacementNamed(context, Routes.hearingDetail);
        break;
      case SenseType.smell:
        svc.markSenseExplored('smell');
        Navigator.pushReplacementNamed(context, Routes.smellDetail);
        break;
      case SenseType.taste:
        svc.markSenseExplored('taste');
        Navigator.pushReplacementNamed(context, Routes.tasteDetail);
        break;
      case SenseType.touch:
        svc.markSenseExplored('touch');
        Navigator.pushReplacementNamed(context, Routes.touchDetail);
        break;
    }
  }

  Widget _progressPill(BuildContext context) {
    final count = AppDataService.instance.exploredSenses.length;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.orangeDeep.withOpacity(0.95),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        count == 5
            ? '5 / 5 Senses Explored ✨'
            : '$count / 5 Senses Explored',
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
