import 'package:flutter/material.dart';

enum ActivityType { learn, play, practice }

class ActivityModel {
  final ActivityType type;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color stripeColor;

  const ActivityModel({
    required this.type,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.stripeColor,
  });
}

const List<ActivityModel> activities = [
  ActivityModel(
    type: ActivityType.learn,
    title: 'Learn',
    subtitle: 'Read & discover',
    icon: Icons.menu_book_outlined,
    stripeColor: Color(0xFF57D2C7),
  ),
  ActivityModel(
    type: ActivityType.play,
    title: 'Play',
    subtitle: 'Fun mini-games',
    icon: Icons.videogame_asset_outlined,
    stripeColor: Color(0xFF7C66EA),
  ),
  ActivityModel(
    type: ActivityType.practice,
    title: 'Practice',
    subtitle: 'Test your skills',
    icon: Icons.edit_outlined,
    stripeColor: Color(0xFFE95A2A),
  ),
];

