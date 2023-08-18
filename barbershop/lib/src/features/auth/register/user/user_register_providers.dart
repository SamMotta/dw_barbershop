import 'package:barbershop/src/core/providers/application_providers.dart';
import 'package:barbershop/src/services/user_register/user_register_admin_impl.dart';
import 'package:barbershop/src/services/user_register/user_register_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_register_providers.g.dart';

@riverpod
UserRegisterAdminService userRegisterAdminService(
  UserRegisterAdminServiceRef ref,
) =>
    UserRegisterAdminServiceImpl(
      userRepo: ref.watch(userRepoProvider),
      userLoginService: ref.watch(userLoginServiceProvider),
    );
