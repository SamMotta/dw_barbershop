// ignore_for_file: public_member_api_docs, sort_constructors_first
sealed class UserModel {
  final int id;
  final String name;
  final String email;
  final String? avatar;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
  });

  factory UserModel.fromMap(Map<String, Object?> json) {
    return switch (json['profile']) {
      'ADM' => UserModelAdmin.fromMap(json),
      'EMPLOYEE' => UserModelEmployee.fromMap(json),
      _ => throw ArgumentError('Invalid user profile!')
    };
  }
}

class UserModelAdmin extends UserModel {
  final List<String>? workDays;
  final List<int>? workHours;

  UserModelAdmin({
    required super.id,
    required super.name,
    required super.email,
    super.avatar,
    this.workDays,
    this.workHours,
  });

  factory UserModelAdmin.fromMap(Map<String, Object?> json) {
    return switch (json) {
      {
        'id': final int id,
        'name': final String name,
        'email': final String email,
      } =>
        UserModelAdmin(
          id: id,
          name: name,
          email: email,
          avatar: json['avatar'] as String?,
          workDays: (json['work_days'] as List?)?.cast<String>(),
          workHours: (json['work_hours'] as List?)?.cast<int>(),
        ),
      _ => throw ArgumentError('Invalid JSON!'),
    };
  }
}

class UserModelEmployee extends UserModel {
  final List<String> workDays;
  final List<int> workHours;
  final int barbershopId;

  UserModelEmployee({
    required super.id,
    required super.name,
    required super.email,
    required this.barbershopId,
    required this.workDays,
    required this.workHours,
    super.avatar,
  });

  factory UserModelEmployee.fromMap(Map<String, Object?> json) =>
      switch (json) {
        {
          'id': final int id,
          'name': final String name,
          'email': final String email,
          'barbershop_id': final int barbershopId,
          // ignore: strict_raw_type
          'work_days': final List workDays,
          // ignore: strict_raw_type
          'work_hours': final List workHours,
        } =>
          UserModelEmployee(
            id: id,
            name: name,
            email: email,
            barbershopId: barbershopId,
            workDays: workDays.cast<String>(),
            workHours: workHours.cast<int>(),
            avatar: json['avatar'] as String?,
          ),
        _ => throw ArgumentError('Invalid JSON!'),
      };
}
