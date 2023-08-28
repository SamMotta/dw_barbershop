class ScheduleModel {
  ScheduleModel({
    required this.id,
    required this.barbershopId,
    required this.userId,
    required this.clientName,
    required this.date,
    required this.time,
  });

  factory ScheduleModel.fromMap(Map<String, Object?> json) {
    switch (json) {
      case {
          'id': final int id,
          'barbershop_id': final int barbershopId,
          'user_id': final int userId,
          'client_name': final String clientName,
          'date': final String scheduleDate,
          'time': final int hour,
        }:
        return ScheduleModel(
          id: id,
          barbershopId: barbershopId,
          userId: userId,
          clientName: clientName,
          date: DateTime.parse(scheduleDate),
          time: hour,
        );

      case _:
        throw ArgumentError('Dados de agendamento inválido. (Invalid JSON)');
    }
  }

  final int id;
  final int barbershopId;
  final int userId;
  final String clientName;
  final DateTime date;
  final int time;
}
