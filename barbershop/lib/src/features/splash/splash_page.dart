import 'package:barbershop/src/features/auth/login/login_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
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
    return Scaffold(
      backgroundColor: Colors.black,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_image_chair.jpg'),
            fit: BoxFit.cover,
            opacity: 0.28,
          ),
        ),
        child: Center(
          child: AnimatedOpacity(
            onEnd: () => Navigator.of(context).pushAndRemoveUntil(
              PageRouteBuilder(
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
                'assets/images/imgLogo.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
