import 'package:barbershop/src/core/constants/local_storage._keys.dart';
import 'package:barbershop/src/core/providers/application_providers.dart';
import 'package:barbershop/src/models/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'splash_vm.g.dart';

enum SplashState {
  initial,
  login,
  loggedAdmin,
  loggedEmployee,
  error,
}

@riverpod
class SplashVM extends _$SplashVM {
  @override
  Future<SplashState> build() async {
    final sp = await SharedPreferences.getInstance();

    if (sp.containsKey(LocalStorageKeys.accessToken)) {
      ref.invalidate(getMeProvider);
      // ignore: cascade_invocations
      ref.invalidate(getMyBarbershopProvider);

      try {
        final userModel = await ref.watch(getMeProvider.future);

        return switch (userModel) {
          UserModelAdmin() => SplashState.loggedAdmin,
          UserModelEmployee() => SplashState.loggedEmployee,
        };
      } catch (e) {
        return SplashState.login;
      }
    }

    return SplashState.login;
  }
}
