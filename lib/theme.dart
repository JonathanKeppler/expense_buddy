
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  textTheme: GoogleFonts.openSansTextTheme(),
  primaryColorDark: const Color(0xFF311B92),
  primaryColorLight: const Color(0xFF9575CD),
  primaryColor: const Color(0xFF5E35B1),
  accentColor: const Color(0xFF6200EA),
  scaffoldBackgroundColor: const Color(0xFFEDE7F6),
  cursorColor: const Color(0xFF5E35B1),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
);