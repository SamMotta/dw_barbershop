import 'package:flutter/widgets.dart';

sealed class BarbershopIcons {
  static const String _fontFamily = 'dw_barbershop_icons';

  static const IconData addEmploye = IconData(0xE900, fontFamily: _fontFamily);
  static const IconData changeAvatar =
      IconData(0xE901, fontFamily: _fontFamily);
  static const IconData exit = IconData(0xE902, fontFamily: _fontFamily);
  static const IconData calendar = IconData(0xE909, fontFamily: _fontFamily);
  static const IconData search = IconData(0xE943, fontFamily: _fontFamily);
  static const IconData penEdit = IconData(0xE944, fontFamily: _fontFamily);
  static const IconData trash = IconData(0xE945, fontFamily: _fontFamily);
}
