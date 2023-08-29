import 'package:barbershop/src/core/fp/either.dart';
import 'package:barbershop/src/core/providers/application_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_employee_provider.g.dart';

@riverpod
Future<int> getTotalSchedules(GetTotalSchedulesRef ref, int userId) async {
  final DateTime(:year, :month, :day) = DateTime.now();
  final date = DateTime(year, month, day);

  final scheduleRepo = ref.read(scheduleRepositoryProvider);
  final schedulesResult = await scheduleRepo.findScheduleByDate(
    (date: date, userId: userId),
  );

  return switch (schedulesResult) {
    Success(value: List(length: final totalSchedules)) => totalSchedules,
    Failure(:final exception) => throw exception,
  };
}
