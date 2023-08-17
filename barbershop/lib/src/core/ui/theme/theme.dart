import 'package:barbershop/src/core/constants/constants.dart';
import 'package:flutter/material.dart';

sealed class BarbershopTheme {
  static final InputBorder _defaultOutlinedInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: ColorsConstants.grey),
  );

  static ThemeData themeData = ThemeData(
    useMaterial3: true,
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
        foregroundColor: Colors.white,
        backgroundColor: ColorsConstants.brown,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );
}
