import 'dart:developer';
import 'dart:io';

import 'package:barbershop/src/core/client/rest_client.dart';
import 'package:barbershop/src/core/exceptions/auth_exception.dart';

import 'package:barbershop/src/core/fp/either.dart';
import 'package:dio/dio.dart';

import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final RestClient restClient;

  UserRepositoryImpl(this.restClient);

  @override
  Future<Either<BaseAuthException, String>> login(
      String email, String password) async {
    try {
      final Response(:data) = await restClient.unauth.post('/auth', data: {
        'email': email,
        'password': password,
      });

      return Success(data['access_token']);
    } on DioException catch (e, s) {
      if (e.response != null) {
        final statusCode = e.response!.statusCode;

        if (statusCode == HttpStatus.forbidden) {
          log('email ou senha inválidos.', stackTrace: s, error: e);
          return Failure(UnauthorizedException());
        }
      }

      log('Erro ao realizar login.', stackTrace: s, error: e);
      return Failure(
        AutheticationException(message: 'Erro ao realizar login.'),
      );
    }
  }
}
