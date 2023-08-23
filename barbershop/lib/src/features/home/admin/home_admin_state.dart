import 'package:barbershop/src/models/user_model.dart';

enum HomeAdminStatus {
  loaded,
  error,
}

class HomeAdminState {
  const HomeAdminState({required this.employees, required this.status});

  final List<UserModel> employees;
  final HomeAdminStatus status;
  HomeAdminState copyWith({
    List<UserModel>? employees,
    HomeAdminStatus? status,
  }) {
    return HomeAdminState(
      employees: employees ?? this.employees,
      status: status ?? this.status,
    );
  }
}
