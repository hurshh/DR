import 'package:shared_preferences/shared_preferences.dart';

/// Singleton that wraps SharedPreferences for lightweight persistent storage.
///
/// Call [init] once in main() before [runApp] so that all subsequent reads
/// are synchronous via the cached [_prefs] instance.
class AppDataService {
  AppDataService._();
  static final AppDataService instance = AppDataService._();

  late SharedPreferences _prefs;

  static const _keyUserName = 'user_name';
  static const _keyExploredSenses = 'explored_senses';
  static const _keyCompletedGames = 'completed_games';

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ── User name ──────────────────────────────────────────────────────────────

  String get userName => _prefs.getString(_keyUserName) ?? '';

  Future<void> saveUserName(String name) =>
      _prefs.setString(_keyUserName, name);

  // ── Explored senses ────────────────────────────────────────────────────────
  // IDs: 'sight' | 'hearing' | 'smell' | 'taste' | 'touch'

  Set<String> get exploredSenses =>
      (_prefs.getStringList(_keyExploredSenses) ?? []).toSet();

  Future<void> markSenseExplored(String senseId) async {
    final current = exploredSenses;
    if (current.contains(senseId)) return; // already stored — no write needed
    current.add(senseId);
    await _prefs.setStringList(_keyExploredSenses, current.toList());
  }

  // ── Completed games ────────────────────────────────────────────────────────
  // IDs: 'spot_difference' | 'sound_match' | 'smell_sorter' |
  //      'taste_classifier' | 'texture_match'

  Set<String> get completedGames =>
      (_prefs.getStringList(_keyCompletedGames) ?? []).toSet();

  Future<void> markGameCompleted(String gameId) async {
    final current = completedGames;
    if (current.contains(gameId)) return;
    current.add(gameId);
    await _prefs.setStringList(_keyCompletedGames, current.toList());
  }

  // ── Best star ratings ──────────────────────────────────────────────────────
  // Stored on the 1–5 scale from GameResultData.stars.
  // Only saved when the new value beats the previous best.

  int getBestStars(String gameId) =>
      _prefs.getInt('game_stars_$gameId') ?? 0;

  Future<void> saveGameStars(String gameId, int stars) async {
    if (stars > getBestStars(gameId)) {
      await _prefs.setInt('game_stars_$gameId', stars);
    }
  }

  // ── Full reset ─────────────────────────────────────────────────────────────

  /// Wipes every key — user name, explored senses, completed games, stars.
  /// After this the initial route will be onboarding.
  Future<void> resetAll() => _prefs.clear();
}
