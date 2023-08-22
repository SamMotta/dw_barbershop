import 'dart:async';
import 'dart:developer';

import 'package:barbershop/src/core/constants/constants.dart';
import 'package:barbershop/src/core/ui/helpers/messages.dart';
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

  bool endAnimation = false;
  Timer? redirectTimer;

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

  void _redirect(String routeName) {
    if (!endAnimation) {
      redirectTimer?.cancel();
      redirectTimer = Timer(
        const Duration(milliseconds: 300),
        () => _redirect(routeName),
      );
    } else {
      redirectTimer?.cancel();
      Navigator.of(context).pushNamedAndRemoveUntil(
        routeName,
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(splashVMProvider, (_, status) {
      status.whenOrNull(
        data: (data) {
          switch (data) {
            case SplashState.loggedAdmin:
              _redirect('/home/admin');
            case SplashState.loggedEmployee:
              _redirect('/home/employee');
            case _:
              _redirect('/auth/login');
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
            // HACK: erro ao realizar login automático
            onEnd: () {
              setState(() {
                endAnimation = true;
              });
            },
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
