import 'package:flutter/material.dart';

class BarbershopNavKey {
  BarbershopNavKey._();

  static BarbershopNavKey? _instance;

  final navKey = GlobalKey<NavigatorState>();

  static BarbershopNavKey get instance => _instance ??= BarbershopNavKey._();
}
