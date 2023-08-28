import 'package:asyncstate/widget/async_state_builder.dart';

import 'package:barbershop/src/core/ui/global/barbershop_nav_key.dart';
import 'package:barbershop/src/core/ui/theme/theme.dart';
import 'package:barbershop/src/core/ui/widgets/barbershop_loader.dart';
import 'package:barbershop/src/features/auth/login/login_page.dart';
import 'package:barbershop/src/features/auth/register/barbershop/barbershop_register_page.dart';
import 'package:barbershop/src/features/auth/register/user/user_register_page.dart';
import 'package:barbershop/src/features/employee/register/employee_register_page.dart';
import 'package:barbershop/src/features/employee/schedule/employee_schedule_page.dart';
import 'package:barbershop/src/features/home/admin/home_admin_page.dart';
import 'package:barbershop/src/features/schedule/schedule_page.dart';
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
        navigatorKey: BarbershopNavKey.instance.navKey,
        title: 'Barbershop',
        theme: BarbershopTheme.themeData,
        navigatorObservers: [asyncNavigatorObserver],
        routes: {
          '/': (_) => const SplashPage(),
          '/auth/login': (_) => const LoginPage(),
          '/auth/register/user': (_) => const UserRegisterPage(),
          '/auth/register/barbershop': (_) => const BarbershopRegisterPage(),
          '/home/admin': (_) => const HomeAdminPage(),
          '/home/employee': (_) => const Text('EMPLOYEE'),
          '/employee/register': (_) => const EmployeeRegisterPage(),
          '/employee/schedule': (_) => const EmployeeSchedulePage(),
          '/schedule': (_) => const SchedulePage(),
        },
      ),
    );
  }
}
