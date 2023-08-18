import 'package:asyncstate/asyncstate.dart';
import 'package:barbershop/src/core/fp/either.dart';
import 'package:barbershop/src/core/providers/application_providers.dart';
import 'package:barbershop/src/features/auth/register/user/user_register_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_register_vm.g.dart';

enum UserRegisterStatus {
  initial,
  success,
  error,
}

@riverpod
class UserRegisterVM extends _$UserRegisterVM {
  @override
  UserRegisterStatus build() => UserRegisterStatus.initial;

  Future<void> register(String name, String email, String password) async {
    final userRegisterAdminService = ref.watch(
      userRegisterAdminServiceProvider,
    );

    final userData = (
      name: name,
      email: email,
      password: password,
    );

    final result =
        await userRegisterAdminService.execute(userData).asyncLoader();

    switch (result) {
      case Success():
        ref.invalidate(getMeProvider);
        state = UserRegisterStatus.success;
      case Failure():
        state = UserRegisterStatus.error;
    }
  }
}
