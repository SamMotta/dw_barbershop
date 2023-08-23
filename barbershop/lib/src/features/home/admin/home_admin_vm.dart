import 'package:asyncstate/asyncstate.dart';
import 'package:barbershop/src/core/fp/either.dart';
import 'package:barbershop/src/core/providers/application_providers.dart';
import 'package:barbershop/src/features/home/admin/home_admin_state.dart';
import 'package:barbershop/src/models/barbershop_model.dart';
import 'package:barbershop/src/models/user_model.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_admin_vm.g.dart';

@riverpod
class HomeAdminVM extends _$HomeAdminVM {
  @override
  Future<HomeAdminState> build() async {
    final userRepo = ref.read(userRepoProvider);
    final me = await ref.watch(getMeProvider.future);
    final BarbershopModel(id: barbershopId) = await ref.read(
      getMyBarbershopProvider.future,
    );

    final result = await userRepo.getEmployees(barbershopId);

    switch (result) {
      case Success(value: final employeesData):
        final employees = <UserModel>[];
        
        //* Checa se workDays e workHours são diferentes de null
        if (me case UserModelAdmin(workDays: _?, workHours: _?)) {
          employees.add(me);
        }

        employees.addAll(employeesData);

        return HomeAdminState(
          status: HomeAdminStatus.loaded,
          employees: employees,
        );
      case Failure():
        return const HomeAdminState(
          employees: [],
          status: HomeAdminStatus.error,
        );
    }
  }

  Future<void> logout() => ref.read(logoutProvider.future).asyncLoader();
}
