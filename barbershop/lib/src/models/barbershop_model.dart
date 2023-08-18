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
          'id': final int id,
          'name': final String name,
          'email': final String email,
          // ignore: strict_raw_type
          'opening_days': final List openingDays,
          // ignore: strict_raw_type
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
