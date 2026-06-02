/// Carries the real stats from a completed mini-game to [GameResultScreen].
///
/// Pass an instance as route arguments:
/// ```dart
/// Navigator.pushReplacementNamed(
///   context,
///   Routes.gameResult,
///   arguments: GameResultData(...),
/// );
/// ```
/// Read it in the destination:
/// ```dart
/// final data = ModalRoute.of(context)?.settings.arguments as GameResultData?;
/// ```
class GameResultData {
  final String gameTitle;
  final String gameEmoji;
  final int score;
  final int correct;
  final int total;
  final int secondsUsed;

  const GameResultData({
    required this.gameTitle,
    required this.gameEmoji,
    required this.score,
    required this.correct,
    required this.total,
    required this.secondsUsed,
  });

  // ── Derived properties ─────────────────────────────────────────────────────

  int get accuracyPct =>
      total > 0 ? (correct * 100 / total).round() : 0;

  String get accuracyLabel => '$accuracyPct%';

  String get timeLabel {
    final m = secondsUsed ~/ 60;
    final s = secondsUsed % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }

  /// 1–5 stars based on accuracy percentage.
  int get stars {
    if (accuracyPct >= 90) return 5;
    if (accuracyPct >= 70) return 4;
    if (accuracyPct >= 50) return 3;
    if (accuracyPct >= 30) return 2;
    return 1;
  }
}
