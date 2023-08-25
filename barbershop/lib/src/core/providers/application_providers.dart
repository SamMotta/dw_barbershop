import 'package:barbershop/src/core/client/rest_client.dart';
import 'package:barbershop/src/core/fp/either.dart';
import 'package:barbershop/src/core/ui/global/barbershop_nav_key.dart';
import 'package:barbershop/src/models/barbershop_model.dart';
import 'package:barbershop/src/models/user_model.dart';
import 'package:barbershop/src/repositories/barbershop/barbershop_repository.dart';
import 'package:barbershop/src/repositories/barbershop/barbershop_repository_impl.dart';
import 'package:barbershop/src/repositories/schedule/schedule_repository.dart';
import 'package:barbershop/src/repositories/schedule/schedule_repository_impl.dart';
import 'package:barbershop/src/repositories/user/user_repository.dart';
import 'package:barbershop/src/repositories/user/user_repository_impl.dart';
import 'package:barbershop/src/services/user_login/user_login_service.dart';
import 'package:barbershop/src/services/user_login/user_login_service_impl.dart';
import 'package:flutter/widgets.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'application_providers.g.dart';

@Riverpod(keepAlive: true)
RestClient restClient(RestClientRef ref) => RestClient();

@Riverpod(keepAlive: true)
UserRepository userRepo(UserRepoRef ref) =>
    UserRepositoryImpl(ref.read(restClientProvider));

@Riverpod(keepAlive: true)
UserLoginService userLoginService(UserLoginServiceRef ref) =>
    UserLoginServiceImpl(ref.read(userRepoProvider));

// Provider é inteligente e guarda em cache o valor resolvido.
@Riverpod(keepAlive: true)
Future<UserModel> getMe(GetMeRef ref) async {
  final result = await ref.watch(userRepoProvider).me();

  return switch (result) {
    Success(value: final userModel) => userModel,
    Failure(:final exception) => throw exception,
  };
}

@Riverpod(keepAlive: true)
BarbershopRepository barbershopRepo(BarbershopRepoRef ref) =>
    BarbershopRepositoryImpl(ref.watch(restClientProvider));

@Riverpod(keepAlive: true)
Future<BarbershopModel> getMyBarbershop(GetMyBarbershopRef ref) async {
  final userModel = await ref.watch(getMeProvider.future);
  final barbershopRepo = ref.watch(barbershopRepoProvider);

  final result = await barbershopRepo.getMyBarbershop(userModel);

  return switch (result) {
    Success(value: final barbershopModel) => barbershopModel,
    Failure(:final exception) => throw exception,
  };
}

@riverpod
Future<void> logout(LogoutRef ref) async {
  final sp = await SharedPreferences.getInstance();
  await sp.clear();
  ref
    ..invalidate(getMyBarbershopProvider)
    ..invalidate(getMeProvider);

  await Navigator.of(BarbershopNavKey.instance.navKey.currentContext!)
      .pushNamedAndRemoveUntil<void>('/auth/login', (route) => false);
}

@riverpod
ScheduleRepository scheduleRepository(ScheduleRepositoryRef ref) =>
    ScheduleRepositoryImpl(
      ref.read(restClientProvider),
    );
