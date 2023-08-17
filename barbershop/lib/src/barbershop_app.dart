import 'package:asyncstate/widget/async_state_builder.dart';
import 'package:barbershop/src/core/ui/theme/theme.dart';
import 'package:barbershop/src/core/ui/widgets/barbershop_loader.dart';
import 'package:barbershop/src/features/auth/login/login_page.dart';
import 'package:barbershop/src/features/splash/splash_page.dart';
import 'package:flutter/material.dart';

class BarbershopApp extends StatelessWidget {
  const BarbershopApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Para abrir widgets de loading
    return AsyncStateBuilder(
      customLoader: const BarbershopLoader(),
      builder: (asyncNavigatorObserver) => MaterialApp(
        title: 'Barbershop',
        theme: BarbershopTheme.themeData,
        navigatorObservers: [asyncNavigatorObserver],
        routes: {
          '/': (_) => const SplashPage(),
          '/auth/login': (_) => const LoginPage(),
        },
      ),
    );
  }
}
