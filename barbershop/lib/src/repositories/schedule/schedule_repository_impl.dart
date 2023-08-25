import 'dart:developer';

import 'package:barbershop/src/core/client/rest_client.dart';
import 'package:barbershop/src/core/exceptions/repository_exception.dart';
import 'package:barbershop/src/core/fp/either.dart';
import 'package:barbershop/src/core/fp/nil.dart';
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
}
