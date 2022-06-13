import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const mainGradient = LinearGradient(colors: [Color(0xFF00EECF), Color(0xFF0A789B)], begin: Alignment.topLeft, end: Alignment.bottomRight);
const white = Color(0xFFFFFFFF);
const black = Color(0xFF202020);
const middleGrey = Color(0xFF9E9E9E);
const darkGrey = Color(0xFF666666);
const bgGrey = Color(0xFFF7F7F7);
const primaryBlue = Color(0xFF1CA0BD);
const darkBlue = Color(0xFF147185);
const whiteBlue = Color(0xFFF2F4FA);
const primaryRed = Color(0xFFE74F4F);
const whiteRed = Color(0xFFFFF5F5);
const alphaBlack = Color(0x1A140009);

const cardShadow = BoxShadow(color: Color(0x14140009), offset: Offset(0, 3), blurRadius: 20);
const upShadow = BoxShadow(color: Color(0x0A140009), offset: Offset(0, -5), blurRadius: 8);
const downShadow = BoxShadow(color: Color(0x0A140009), offset: Offset(0, 3), blurRadius: 12);

const buttonTextStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w600, height: 20 / 16, letterSpacing: -0.24);

final border = OutlineInputBorder(
  borderRadius: BorderRadius.circular(12),
  borderSide: const BorderSide(color: Color(0x00000000)),
);

final lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: white,
  cupertinoOverrideTheme: const CupertinoThemeData(brightness: Brightness.dark),
  textTheme: const TextTheme(
    headline1: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, height: 26 / 24, color: darkGrey),
    headline3: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, height: 24 / 18, letterSpacing: -0.24, color: black),
    headline4: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, height: 24 / 18, letterSpacing: -0.24, color: black),
    headline5: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, height: 20 / 16, letterSpacing: -0.24),
    headline6: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, height: 20 / 14, letterSpacing: -0.15, color: black),
    bodyText1: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, height: 20 / 14, letterSpacing: -0.15, color: black),
    bodyText2: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, height: 20 / 14, letterSpacing: -0.15, color: middleGrey),
    subtitle1: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, height: 20 / 14, letterSpacing: -0.15, color: black),
    subtitle2: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, height: 12 / 10, letterSpacing: 0.12, color: darkGrey),
    caption: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, height: 14 / 12, letterSpacing: -0.4),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(Colors.white),
      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      fixedSize: MaterialStateProperty.all(const Size(double.maxFinite, 56)),
      shadowColor: MaterialStateProperty.all(const Color(0x20010C0D)),
      elevation: MaterialStateProperty.all(1.2),
      textStyle: MaterialStateProperty.all(buttonTextStyle),
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return primaryBlue.withOpacity(0.70);
        } else {
          return primaryBlue;
        }
      }),
    ),
  ),
  bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.transparent),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      fixedSize: const Size(double.maxFinite, 56),
      side: const BorderSide(color: primaryBlue, width: 1.5),
      primary: primaryBlue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: buttonTextStyle,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    isDense: true,
    filled: true,
    fillColor: bgGrey,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: primaryBlue),
    ),
    enabledBorder: border,
    disabledBorder: border,
    border: border,
    contentPadding: const EdgeInsets.fromLTRB(16, 34, 16, 12),
    hintStyle: const TextStyle(
      fontSize: 14,
      height: 20 / 14,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.25,
      color: middleGrey,
    ),
  ),
);
