import 'package:flutter/material.dart';

abstract class CColors {
  static const Color primary = Color(0xFF68C0E4);
  static const Color white = Color(0xFFFFFFFF);
  static const Color title = Color(0xFF0F2833);
  static const Color fakeWhite = Color(0xFFF0F9FC);
  static const Color gray = Color(0xFF585858);
  static const Color red = Color(0xFFFF4343);
  static const Color green = Color(0xFF4BB543);

  static MaterialColor primarySwatch = _getMaterialColor(primary);

  static MaterialColor _getMaterialColor(Color color) {
    return MaterialColor(color.value, {
      50: Color.fromRGBO(color.red, color.blue, color.green, 0.1),
      100: Color.fromRGBO(color.red, color.blue, color.green, 0.2),
      200: Color.fromRGBO(color.red, color.blue, color.green, 0.3),
      300: Color.fromRGBO(color.red, color.blue, color.green, 0.4),
      400: Color.fromRGBO(color.red, color.blue, color.green, 0.5),
      500: Color.fromRGBO(color.red, color.blue, color.green, 0.6),
      600: Color.fromRGBO(color.red, color.blue, color.green, 0.7),
      700: Color.fromRGBO(color.red, color.blue, color.green, 0.8),
      800: Color.fromRGBO(color.red, color.blue, color.green, 0.9),
      900: Color.fromRGBO(color.red, color.blue, color.green, 1),
    });
  }

  static BoxShadow shadow = BoxShadow(
    blurRadius: 4,
    spreadRadius: 0,
    color: Colors.black.withOpacity(0.15),
    offset: const Offset(0, 0),
  );
}
