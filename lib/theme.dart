import 'package:flutter/material.dart';

ThemeData buildAppTheme() {
  const seed = Color(0xFF034278); // sky-500
  final colorScheme = ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.light);

  return ThemeData(
    colorScheme: colorScheme,
    useMaterial3: true,
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontWeight: FontWeight.w800),
      displayMedium: TextStyle(fontWeight: FontWeight.w700),
      headlineMedium: TextStyle(fontWeight: FontWeight.w700),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
  );
}
