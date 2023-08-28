import 'dart:developer';

import 'package:barbershop/src/core/client/rest_client.dart';
import 'package:barbershop/src/core/exceptions/repository_exception.dart';
import 'package:barbershop/src/core/fp/either.dart';
import 'package:barbershop/src/core/fp/nil.dart';
import 'package:barbershop/src/models/schedule_model.dart';
import 'package:barbershop/src/repositories/schedule/schedule_repository.dart';
import 'package:dio/dio.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  ScheduleRepositoryImpl(this.restClient);

  final RestClient restClient;

  @override
  Future<Either<RepositoryException, Nil>> scheduleClient(
    ({
      int barbershopId,
      int userId,
      String clientName,
      DateTime? date,
      int? time,
    }) data,
  ) async {
    try {
      await restClient.auth.post<void>(
        '/schedules',
        data: {
          'barbershop_id': data.barbershopId,
          'user_id': data.userId,
          'client_name': data.clientName,
          'date': data.date!.toIso8601String(),
          'time': data.time!,
        },
      );

      return Success(nil);
    } on DioException catch (e, s) {
      log(
        'Ocorreu um erro ao agendar corte de cabelo.',
        error: e,
        stackTrace: s,
      );

      return Failure(
        RepositoryException('Ocorreu um erro ao agendar corte de cabelo.'),
      );
    }
  }

  @override
  Future<Either<RepositoryException, List<ScheduleModel>>> findScheduleByDate(
    ({DateTime date, int userId}) filter,
  ) async {
    try {
      final Response(:List<dynamic> data) = await restClient.auth.get(
        '/schedules',
        queryParameters: {
          'user_id': filter.userId,
          'date': filter.date.toIso8601String(),
        },
      );

      final schedules = data
          .map(
            (json) => ScheduleModel.fromMap(json as Map<String, Object?>),
          )
          .toList();

      return Success(schedules);
    } on DioException catch (e, s) {
      log('Ocorreu um erro ao buscar agendamentos.', error: e, stackTrace: s);
      return Failure(
        RepositoryException('Ocorreu um erro ao buscar agendamentos'),
      );
    } on ArgumentError catch (e, s) {
      log(
        'Dados de agendamentos inválidos (Invalid JSON)',
        error: e,
        stackTrace: s,
      );
      return Failure(
        RepositoryException('Dados de agendamentos inválidos (Invalid JSON)'),
      );
    }
  }
}
