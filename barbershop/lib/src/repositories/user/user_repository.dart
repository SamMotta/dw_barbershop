import 'package:barbershop/src/core/exceptions/auth_exception.dart';
import 'package:barbershop/src/core/fp/either.dart';

abstract interface class UserRepository {
  Future<Either<BaseAuthException, String>> login(String email, String password);
}
