import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends StateNotifier<bool> {
  ThemeNotifier(super.isDarkMode); // Pass initial state

  // Clean single definition each
  static final ThemeData lightMode = ThemeData(
    colorScheme: const ColorScheme.light(
      surface: Colors.white,
      primary: Color(0xffbc96b5),
      onPrimaryContainer: Color(0xff3592E7),
      secondary: Color(0x00332633),
      tertiary: Color(0x00744c6c),
      primaryContainer: Color(0xffF3F8FE),
      inversePrimary: Color(0xffB8B8B8),
      inverseSurface: Colors.black,
      tertiaryContainer: Color(0xffDF9652),
      primaryFixedDim: Color(0xff4D5652),
      tertiaryFixedDim: Color(0xffF8D675),
    ),
  );

  static final ThemeData darkMode = ThemeData(
    colorScheme: ColorScheme.dark(
      surface: Colors.black,
      primary: Colors.white,
      secondary: Colors.white,
      tertiary: const Color.fromARGB(
        255,
        180,
        180,
        180,
      ).withAlpha(51), // 0.2 * 255
      inversePrimary: Colors.grey,
      tertiaryContainer: const Color(0xff939cc4),
      primaryFixedDim: Colors.white,
    ),
  );

  ThemeData get currentTheme => state ? darkMode : lightMode;

  void toggleTheme() async {
    state = !state;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('theme', state);
  }
}

final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, bool>(
  (ref) => ThemeNotifier(false), // default to light mode if not overridden
);
