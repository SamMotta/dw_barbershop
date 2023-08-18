// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:barbershop/src/core/exceptions/service_exception.dart';
import 'package:barbershop/src/core/fp/either.dart';
import 'package:barbershop/src/core/fp/nil.dart';
import 'package:barbershop/src/repositories/user/user_repository.dart';
import 'package:barbershop/src/services/user_login/user_login_service.dart';
import 'package:barbershop/src/services/user_register/user_register_service.dart';

class UserRegisterAdminServiceImpl implements UserRegisterAdminService {
  final UserRepository userRepo;
  final UserLoginService userLoginService;

  UserRegisterAdminServiceImpl({
    required this.userRepo,
    required this.userLoginService,
  });

  @override
  Future<Either<ServiceException, Nil>> execute(
    ({String email, String name, String password}) userData,
  ) async {
    final registerResult = await userRepo.registerAdmin(userData);

    switch (registerResult) {
      case Success():
        return userLoginService.execute(userData.email, userData.password);
      case Failure(:final exception):
        return Failure(ServiceException(exception.message));
    }
  }
}
