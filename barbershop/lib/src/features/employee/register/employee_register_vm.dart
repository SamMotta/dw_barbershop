import 'package:asyncstate/asyncstate.dart';
import 'package:barbershop/src/core/exceptions/repository_exception.dart';
import 'package:barbershop/src/core/fp/either.dart';
import 'package:barbershop/src/core/fp/nil.dart';
import 'package:barbershop/src/core/providers/application_providers.dart';
import 'package:barbershop/src/features/employee/register/employee_register_state.dart';
import 'package:barbershop/src/models/barbershop_model.dart';
import 'package:barbershop/src/repositories/user/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'employee_register_vm.g.dart';

@riverpod
class EmployeeRegisterVM extends _$EmployeeRegisterVM {
  @override
  EmployeeRegisterState build() => EmployeeRegisterState.initial();

  Future<void> register({
    String? name,
    String? email,
    String? password,
  }) async {
    final EmployeeRegisterState(
      :isRegisteringAdmin,
      :workDays,
      :workHours,
    ) = state;

    final asyncHandler = AsyncLoaderHandler()..start();

    final UserRepository(:registerAdminAsEmployee, :registerEmployee) =
        ref.read(userRepoProvider);
    final BarbershopModel(id: barbershopId) =
        await ref.watch(getMyBarbershopProvider.future);

    final Either<RepositoryException, Nil> resultRegister;

    if (isRegisteringAdmin) {
      final dto = (
        workDays: workDays,
        workHours: workHours,
      );

      resultRegister = await registerAdminAsEmployee(dto);
    } else {
      final dto = (
        barbershopId: barbershopId,
        name: name!,
        email: email!,
        password: password!,
        workDays: workDays,
        workHours: workHours,
      );

      resultRegister = await registerEmployee(dto);
    }

    switch (resultRegister) {
      case Success():
        state = state.copyWith(status: EmployeeRegisterStatus.success);
      case Failure():
        state = state.copyWith(status: EmployeeRegisterStatus.error);
    }

    asyncHandler.close();
  }

  void toggleIsRegistringAdmin({required bool isAdmin}) =>
      state = state.copyWith(isRegisteringAdmin: isAdmin);

  void addOrRemoveWorkDays(String day) {
    final days = [...state.workDays];

    if (days.contains(day)) {
      days.remove(day);
    } else {
      days.add(day);
    }

    state = state.copyWith(workDays: days);
  }

  void addOrRemoveWorkHours(int hour) {
    {
      final hours = [...state.workHours];

      if (hours.contains(hour)) {
        hours.remove(hour);
      } else {
        hours.add(hour);
      }

      state = state.copyWith(workHours: hours);
    }
  }
}
