import 'package:barbershop/src/core/constants/local_storage._keys.dart';
import 'package:barbershop/src/core/exceptions/auth_exception.dart';
import 'package:barbershop/src/core/exceptions/service_exception.dart';
import 'package:barbershop/src/core/fp/either.dart';
import 'package:barbershop/src/core/fp/nil.dart';
import 'package:barbershop/src/repositories/user/user_repository.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'user_login_service.dart';

class UserLoginServiceImpl implements UserLoginService {
  final UserRepository userRepo;

  UserLoginServiceImpl(this.userRepo);

  @override
  Future<Either<ServiceException, Nil>> execute(
    String email,
    String password,
  ) async {
    final loginResult = await userRepo.login(email, password);

    switch (loginResult) {
      case Success(value: final accessToken):
        final sp = await SharedPreferences.getInstance();
        sp.setString(LocalStorageKeys.accessToken, accessToken);
        return Success(nil);
      case Failure(:final exception):
        return switch (exception) {
          AutheticationException() =>
            Failure(ServiceException('Erro ao realizar login')),
          UnauthorizedException() =>
            Failure(ServiceException('Email ou senha inválidos')),
        };
    }
  }
}
