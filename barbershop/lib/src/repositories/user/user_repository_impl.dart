import 'dart:developer';
import 'dart:io';

import 'package:barbershop/src/core/client/rest_client.dart';
import 'package:barbershop/src/core/exceptions/auth_exception.dart';
import 'package:barbershop/src/core/exceptions/repository_exception.dart';

import 'package:barbershop/src/core/fp/either.dart';
import 'package:barbershop/src/core/fp/nil.dart';
import 'package:barbershop/src/models/user_model.dart';
import 'package:barbershop/src/repositories/user/user_repository.dart';
import 'package:dio/dio.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this.restClient);

  final RestClient restClient;

  @override
  Future<Either<BaseAuthException, String>> login(
    String email,
    String password,
  ) async {
    try {
      final Response(:data) =
          await restClient.unauth.post<Map<String, Object?>>(
        '/auth',
        data: {
          'email': email,
          'password': password,
        },
      );

      return Success(data!['access_token']! as String);
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

  @override
  Future<Either<RepositoryException, UserModel>> me() async {
    try {
      final Response(:data) = await restClient.auth.get('/me');

      return Success(UserModel.fromMap(data as Map<String, Object?>));
    } on DioException catch (err, stackTrace) {
      log('Erro ao buscar usuário logado.', error: err, stackTrace: stackTrace);
      return Failure(RepositoryException('Erro ao buscar usuário logado.'));
    } on ArgumentError catch (err, stackTrace) {
      log(err.message.toString(), error: err, stackTrace: stackTrace);
      return Failure(RepositoryException(err.message.toString()));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> registerAdmin(
    ({String email, String name, String password}) userData,
  ) async {
    try {
      await restClient.unauth.post<void>(
        '/users',
        data: {
          'name': userData.name,
          'email': userData.email,
          'password': userData.password,
          'profile': 'ADM',
        },
      );

      return Success(nil);
    } on DioException catch (error, stackTrace) {
      log(
        error.message ?? 'Ocorreu um erro ao registrar um administrador.',
        error: error,
        stackTrace: stackTrace,
      );
      return Failure(
        RepositoryException('Ocorreu um erro ao registrar um administrador.'),
      );
    }
  }

  @override
  Future<Either<RepositoryException, List<UserModel>>> getEmployees(
    int barbershopId,
  ) async {
    try {
      final Response(:List<dynamic> data) = await restClient.auth.get(
        '/users',
        queryParameters: {
          'barbershop_id': barbershopId,
        },
      );

      final employees = data
          .map(
            (e) => UserModel.fromMap(e as Map<String, Object?>),
          )
          .toList();

      return Success(employees);
    } on DioException catch (e, s) {
      log('Ocorreu um erro ao buscar colaboradores.', error: e, stackTrace: s);
      return Failure(
        RepositoryException('Ocorreu um erro ao buscar colaboradores.'),
      );
    } on ArgumentError catch (e, s) {
      log(
        'Ocorreu um erro ao tratar os dados dos colaboradores. (Invalid JSON)',
        error: e,
        stackTrace: s,
      );
      return Failure(
        RepositoryException(
          'Ocorreu um erro ao tratar os dados '
          'dos colaboradores. (Invalid JSON)',
        ),
      );
    }
  }
}
