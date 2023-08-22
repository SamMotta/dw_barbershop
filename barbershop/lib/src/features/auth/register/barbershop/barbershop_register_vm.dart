import 'package:barbershop/src/core/fp/either.dart';
import 'package:barbershop/src/core/providers/application_providers.dart';
import 'package:barbershop/src/features/auth/register/barbershop/barbershop_register_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'barbershop_register_vm.g.dart';

@riverpod
class BarbershopRegisterVM extends _$BarbershopRegisterVM {
  @override
  BarbershopRegisterState build() => const BarbershopRegisterState.initial();

  void addOrRemoveOpeningHours(int hour) {
    final openingHours = [...state.openingHours];

    if (openingHours.contains(hour)) {
      openingHours.remove(hour);
    } else {
      openingHours.add(hour);
    }

    state = state.copyWith(openingHours: openingHours);
  }

  void addOrRemoveOpeningDays(String day) {
    final openingDays = [...state.openingDays];

    if (openingDays.contains(day)) {
      openingDays.remove(day);
    } else {
      openingDays.add(day);
    }

    state = state.copyWith(openingDays: openingDays);
  }

  Future<void> register(String name, String email) async {
    final repo = ref.watch(barbershopRepoProvider);

    final BarbershopRegisterState(:openingHours, :openingDays) = state;

    final dto = (
      name: name,
      email: email,
      openingHours: openingHours,
      openingDays: openingDays,
    );

    final result = await repo.save(dto);

    switch (result) {
      case Success():
        ref.invalidate(getMyBarbershopProvider);
        state = state.copyWith(status: BarbershopRegisterStatus.success);
      case Failure():
        state = state.copyWith(status: BarbershopRegisterStatus.error);
    }
  }
}
