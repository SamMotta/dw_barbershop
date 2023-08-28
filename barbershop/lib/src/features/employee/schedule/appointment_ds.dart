import 'package:barbershop/src/core/constants/constants.dart';
import 'package:barbershop/src/models/schedule_model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppointmentDatasource extends CalendarDataSource<ScheduleModel> {
  AppointmentDatasource(this.schedules);

  final List<ScheduleModel> schedules;

  @override
  List<dynamic>? get appointments => schedules.map(
        (e) {
          final ScheduleModel(
            date: DateTime(:year, :month, :day),
            time: hour,
            :clientName
          ) = e;

          final startTime = DateTime(year, month, day, hour);
          final endTime = DateTime(year, month, day, hour + 1);

          return Appointment(
            color: ColorsConstants.brown,
            startTime: startTime,
            endTime: endTime,
            subject: clientName,
          );
        },
      ).toList();
}
