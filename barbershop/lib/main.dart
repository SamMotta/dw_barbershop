import 'package:barbershop/src/barbershop_app.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await initializeDateFormatting('pt_BR');
  runApp(const ProviderScope(child: BarbershopApp()));
}
