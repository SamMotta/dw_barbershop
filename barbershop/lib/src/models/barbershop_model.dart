// ignore_for_file: public_member_api_docs, sort_constructors_first
class BarbershopModel {
  final int id;
  // final int userId;
  final String name;
  final String email;
  final List<String> openingDays;
  final List<int> openingHours;

  BarbershopModel({
    required this.id,
    required this.name,
    required this.email,
    required this.openingDays,
    required this.openingHours,
  });

  factory BarbershopModel.fromMap(Map<String, Object?> json) => switch (json) {
        {
          'id': int id,
          'name': String name,
          'email': String email,
          'opening_days': final List openingDays,
          'opening_hours': final List openingHours,
        } =>
          BarbershopModel(
            id: id,
            email: email,
            name: name,
            openingDays: openingDays.cast<String>(),
            openingHours: openingHours.cast<int>(),
          ),
        _ => throw ArgumentError('Invalid JSON!', 'BarbershopModel'),
      };
}
