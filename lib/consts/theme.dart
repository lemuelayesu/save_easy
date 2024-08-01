import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData themeData() {
  return ThemeData(
    scaffoldBackgroundColor: const Color.fromRGBO(243, 243, 243, 1),
    textTheme: GoogleFonts.plusJakartaSansTextTheme(),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromRGBO(243, 243, 243, 1),
    ),
    colorScheme: ThemeData().colorScheme.copyWith(
          primary: const Color.fromRGBO(55, 124, 200, 1),
          onPrimary: const Color.fromRGBO(70, 155, 136, 1),
          secondary: const Color.fromRGBO(226, 92, 92, 1),
          surfaceDim: const Color.fromRGBO(206, 223, 188, 1),
          onSecondary: const Color.fromRGBO(55, 124, 200, 1),
          tertiary: const Color.fromRGBO(112, 112, 112, 1),
          tertiaryContainer: const Color.fromRGBO(36, 36, 36, 1),
          primaryFixed: const Color.fromRGBO(238, 216, 104, 1),
          onPrimaryFixedVariant: const Color.fromRGBO(231, 140, 157, 1),
          secondaryFixed: const Color.fromRGBO(231, 140, 157, 1),
          surface: Colors.white,
          onSurface: Colors.black,
        ),
  );
}
