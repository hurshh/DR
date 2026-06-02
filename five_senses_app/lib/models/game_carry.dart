/// Carries accumulated multi-round game progress between screen transitions.
///
/// Pass as route arguments when navigating to the next round:
/// ```dart
/// Navigator.pushReplacementNamed(
///   context, Routes.nextRound,
///   arguments: GameCarry(...)
/// );
/// ```
/// Read on the receiving screen:
/// ```dart
/// final args = ModalRoute.of(context)?.settings.arguments;
/// final carry = args is GameCarry ? args : null;
/// ```
class GameCarry {
  /// Raw points accumulated in all previous rounds (for the score display).
  final int scoreSoFar;

  /// Number of correct answers across all previous rounds.
  final int correctSoFar;

  /// Total questions answered across all previous rounds.
  final int totalSoFar;

  /// When the very first round started — used for accurate total elapsed time.
  final DateTime startTime;

  const GameCarry({
    required this.scoreSoFar,
    required this.correctSoFar,
    required this.totalSoFar,
    required this.startTime,
  });
}
