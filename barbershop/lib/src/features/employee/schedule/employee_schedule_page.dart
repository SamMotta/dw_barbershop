import 'package:barbershop/src/core/constants/constants.dart';
import 'package:barbershop/src/features/employee/schedule/appointment_ds.dart';
import 'package:barbershop/src/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EmployeeSchedulePage extends StatelessWidget {
  const EmployeeSchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments! as UserModel;

    return Scaffold(
      appBar: AppBar(title: const Text('Agenda')),
      body: Column(
        children: [
          const SizedBox(height: 6),
          Text(
            user.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 44),
          Expanded(
            child: SfCalendar(
              dataSource: AppointmentDatasource(),
              allowViewNavigation: true,
              showNavigationArrow: true,
              showDatePickerButton: true,
              showTodayButton: true,
              todayHighlightColor: ColorsConstants.brown,
              onTap: (calendarTapDetails) {
                final appointments = calendarTapDetails.appointments;

                if (appointments != null && appointments.isNotEmpty) {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (context) {
                      final formatter = DateFormat('dd/MM/yyyy HH:mm');

                      return SizedBox(
                        height: 200,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // ignore: avoid_dynamic_calls
                              Text('Cliente: ${appointments.first.subject}'),
                              Text(
                                'Horário: ${formatter.format(
                                  calendarTapDetails.date ?? DateTime.now(),
                                )}',
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
              appointmentBuilder: (context, details) {
                return Container(
                  decoration: BoxDecoration(
                    color: ColorsConstants.brown,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      // ignore: avoid_dynamic_calls
                      details.appointments.first.subject.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
