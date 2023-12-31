import 'package:barbershop/src/core/constants/constants.dart';
import 'package:flutter/material.dart';

sealed class BarbershopTheme {
  static final InputBorder _defaultOutlinedInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: ColorsConstants.grey),
  );

  static ThemeData themeData = ThemeData(
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      iconTheme: IconThemeData(color: ColorsConstants.brown),
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 18,
        color: Colors.black,
        fontFamily: FontConstants.fontFamily,
      ),
    ),
    fontFamily: FontConstants.fontFamily,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      labelStyle: const TextStyle(color: ColorsConstants.grey),
      border: _defaultOutlinedInputBorder,
      focusedBorder: _defaultOutlinedInputBorder,
      enabledBorder: _defaultOutlinedInputBorder,
      errorBorder: _defaultOutlinedInputBorder.copyWith(
        borderSide: const BorderSide(color: ColorsConstants.red),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        // minimumSize: const Size.fromHeight(56),
        foregroundColor: Colors.white,
        backgroundColor: ColorsConstants.brown,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: ColorsConstants.brown,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: ColorsConstants.brown, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );
}
