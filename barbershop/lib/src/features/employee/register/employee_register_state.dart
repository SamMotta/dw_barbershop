enum EmployeeRegisterStatus {
  initial,
  success,
  error,
}

class EmployeeRegisterState {
  EmployeeRegisterState({
    required this.status,
    required this.isRegisteringAdmin,
    required this.workDays,
    required this.workHours,
  });

  EmployeeRegisterState.initial()
      : this(
          status: EmployeeRegisterStatus.initial,
          isRegisteringAdmin: false,
          workDays: const [],
          workHours: const [],
        );

  final EmployeeRegisterStatus status;
  final bool isRegisteringAdmin;
  final List<String> workDays;
  final List<int> workHours;
  
  EmployeeRegisterState copyWith({
    EmployeeRegisterStatus? status,
    bool? isRegisteringAdmin,
    List<String>? workDays,
    List<int>? workHours,
  }) {
    return EmployeeRegisterState(
      status: status ?? this.status,
      isRegisteringAdmin: isRegisteringAdmin ?? this.isRegisteringAdmin,
      workDays: workDays ?? this.workDays,
      workHours: workHours ?? this.workHours,
    );
  }
}
