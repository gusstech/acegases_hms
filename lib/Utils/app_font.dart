import 'package:flutter/material.dart';

class AppFont {
  static TextStyle robotoRegular(double size,
      {Color? color, TextDecoration? decoration, TextOverflow? overflow}) {
    return TextStyle(
      // fontFamily: 'OpenSans',
      fontSize: size,
      fontWeight: FontWeight.normal,
      color: color,
      decoration: decoration,
      overflow: overflow,
    );
  }

  static TextStyle robotoBold(double size,
      {Color? color, TextDecoration? decoration, TextOverflow? overflow}) {
    return TextStyle(
      // fontFamily: 'Roboto',
      fontSize: size,
      fontWeight: FontWeight.bold,
      color: color,
      decoration: decoration,
    );
  }

  static TextStyle robotoSemiBold(double size,
      {Color? color,
      TextDecoration? decoration,
      TextOverflow? overflow,
      double? spacing}) {
    return TextStyle(
      // fontFamily: 'Roboto',
      fontSize: size,
      fontWeight: FontWeight.w600,
      color: color,
      decoration: decoration,
      wordSpacing: spacing,
      letterSpacing: spacing,
    );
  }

  static TextStyle robotoExtraBold(double size,
      {Color? color, TextDecoration? decoration, TextOverflow? overflow}) {
    return TextStyle(
      // fontFamily: 'Roboto',
      fontSize: size,
      fontWeight: FontWeight.w900,
      color: color,
      decoration: decoration,
    );
  }

  static TextStyle robotoMedium(double size,
      {Color? color,
      TextDecoration? decoration,
      TextOverflow? overflow,
      double? spacing}) {
    return TextStyle(
      // fontFamily: 'Roboto',
      fontSize: size,
      fontWeight: FontWeight.w500,
      color: color,
      wordSpacing: spacing,
      letterSpacing: spacing,
      decoration: decoration,
      overflow: overflow,
    );
  }
}
