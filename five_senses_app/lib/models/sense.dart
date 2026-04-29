import 'package:flutter/material.dart';

enum SenseType { sight, hearing, smell, taste, touch }

class SenseModel {
  final SenseType type;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color headerColor;
  final Color chipColor;

  const SenseModel({
    required this.type,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.headerColor,
    required this.chipColor,
  });
}

const List<SenseModel> senses = [
  SenseModel(
    type: SenseType.sight,
    title: 'Sight',
    subtitle: 'Your eyes like cameras',
    icon: Icons.visibility_outlined,
    headerColor: Color(0xFF58D3CA),
    chipColor: Color(0xFF58D3CA),
  ),
  SenseModel(
    type: SenseType.hearing,
    title: 'Hearing',
    subtitle: 'Sounds to your brain',
    icon: Icons.hearing_outlined,
    headerColor: Color(0xFF57C8C6),
    chipColor: Color(0xFF57C8C6),
  ),
  SenseModel(
    type: SenseType.smell,
    title: 'Smell',
    subtitle: 'Smell sorter categories',
    icon: Icons.spa_outlined,
    headerColor: Color(0xFFF2D35B),
    chipColor: Color(0xFFF2D35B),
  ),
  SenseModel(
    type: SenseType.taste,
    title: 'Taste',
    subtitle: 'Sweet, sour, salty, bitter',
    icon: Icons.local_drink_outlined,
    headerColor: Color(0xFF6B5DE6),
    chipColor: Color(0xFF6B5DE6),
  ),
  SenseModel(
    type: SenseType.touch,
    title: 'Touch',
    subtitle: 'Feel textures',
    icon: Icons.handyman_outlined,
    headerColor: Color(0xFFFF7A3B),
    chipColor: Color(0xFFFF7A3B),
  ),
];

