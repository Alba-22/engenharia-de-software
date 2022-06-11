import 'package:flutter/material.dart';

abstract class Assets {
  static const String icons = "assets/icons";
  static const String images = "assets/images";
}

abstract class Fonts {
  static const String inter = "Inter";
}

abstract class FWeight {
  static const FontWeight thin = FontWeight.w100;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;
}

abstract class StorageKeys {
  static const String accessToken = "access_token";
  static const String username = "username";
}
