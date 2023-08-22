import 'dart:developer';

import 'package:barbershop/src/core/constants/constants.dart';
import 'package:barbershop/src/core/ui/helpers/messages.dart';
import 'package:barbershop/src/features/auth/login/login_page.dart';
import 'package:barbershop/src/features/splash/splash_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  var _scale = 10.0;
  var _animationOpacityLogo = 0.0;

  double get logoAnimationWidth => 100 * _scale;
  double get logoAnimationHeight => 120 * _scale;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _animationOpacityLogo = 1.0;
        _scale = 1;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(splashVMProvider, (_, status) {
      status.whenOrNull(
        data: (data) {
          switch (data) {
            case SplashState.loggedAdmin:
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/home/admin',
                (route) => false,
              );
            case SplashState.loggedEmployee:
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/auth/employee',
                (route) => false,
              );
            case _:
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/auth/login',
                (route) => false,
              );
          }
        },
        error: (error, stackTrace) {
          log(
            'Ocorreu um erro ao validar login.',
            error: error,
            stackTrace: stackTrace,
          );
          Messages.showError('Ocorreu um erro ao validar login.', context);
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/auth/login', (route) => false);
        },
      );
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageConstants.backgroundChair),
            fit: BoxFit.cover,
            opacity: 0.28,
          ),
        ),
        child: Center(
          child: AnimatedOpacity(
            onEnd: () => Navigator.of(context).pushAndRemoveUntil(
              PageRouteBuilder<void>(
                settings: const RouteSettings(name: '/auth/login'),
                transitionsBuilder: (_, animation, __, child) => FadeTransition(
                  opacity: animation,
                  child: child,
                ),
                pageBuilder: (___, __, _) => const LoginPage(),
              ),
              (route) => false,
            ),
            duration: const Duration(seconds: 1),
            curve: Curves.easeIn,
            opacity: _animationOpacityLogo,
            child: AnimatedContainer(
              duration: const Duration(seconds: 1),
              curve: Curves.linearToEaseOut,
              width: logoAnimationWidth,
              height: logoAnimationHeight,
              child: Image.asset(
                ImageConstants.logo,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
