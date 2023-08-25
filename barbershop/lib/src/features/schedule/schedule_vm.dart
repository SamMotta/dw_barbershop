import 'package:asyncstate/asyncstate.dart';
import 'package:barbershop/src/core/fp/either.dart';
import 'package:barbershop/src/core/providers/application_providers.dart';
import 'package:barbershop/src/features/schedule/schedule_state.dart';
import 'package:barbershop/src/models/barbershop_model.dart';
import 'package:barbershop/src/models/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'schedule_vm.g.dart';

@riverpod
class ScheduleVM extends _$ScheduleVM {
  @override
  ScheduleState build() => const ScheduleState.initial();

  void hourSelect(int hour) {
    if (state.scheduleHour == hour) {
      state = state.copyWith(scheduleHour: () => null);
      return;
    }

    state = state.copyWith(scheduleHour: () => hour);
  }

  void dateSelect(DateTime date) =>
      state = state.copyWith(scheduleDate: () => date);

  Future<void> register({
    required UserModel user,
    required String clientName,
  }) async {
    final asyncLoader = AsyncLoaderHandler()..start();

    final ScheduleState(
      :scheduleHour,
      :scheduleDate,
    ) = state;

    final scheduleRepo = ref.read(scheduleRepositoryProvider);
    final BarbershopModel(:id) =
        await ref.watch(getMyBarbershopProvider.future);

    final dto = (
      barbershopId: id,
      userId: user.id,
      clientName: clientName,
      date: scheduleDate,
      time: scheduleHour,
    );

    final scheduleResult = await scheduleRepo.scheduleClient(dto);

    switch (scheduleResult) {
      case Success():
        state = state.copyWith(status: ScheduleStatus.success);
      case Failure():
        state = state.copyWith(status: ScheduleStatus.error);
    }

    asyncLoader.close();
  }
}
