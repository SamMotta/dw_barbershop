import 'dart:developer';

import 'package:barbershop/src/core/constants/constants.dart';
import 'package:barbershop/src/core/ui/widgets/barbershop_loader.dart';
import 'package:barbershop/src/features/employee/schedule/appointment_ds.dart';
import 'package:barbershop/src/features/employee/schedule/employee_schedule_vm.dart';
import 'package:barbershop/src/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EmployeeSchedulePage extends ConsumerStatefulWidget {
  const EmployeeSchedulePage({super.key});

  @override
  ConsumerState<EmployeeSchedulePage> createState() =>
      _EmployeeSchedulePageState();
}

class _EmployeeSchedulePageState extends ConsumerState<EmployeeSchedulePage> {
  late DateTime dateSelected;
  bool ignoreFirstLoad = true;

  @override
  void initState() {
    final DateTime(:day, :month, :year) = DateTime.now();
    dateSelected = DateTime(year, month, day);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final UserModel(id: userId, :name) =
        ModalRoute.of(context)!.settings.arguments! as UserModel;

    final scheduleAsync = ref.watch(
      employeeScheduleVMProvider(userId, dateSelected),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Agenda')),
      body: Column(
        children: [
          const SizedBox(height: 6),
          Text(
            name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 44),
          scheduleAsync.when(
            loading: BarbershopLoader.new,
            error: (error, stackTrace) {
              log(
                'Ocorreu um erro ao carregar agendamento.',
                error: error,
                stackTrace: stackTrace,
              );
              return const Center(
                child: Text('Ocorreu um erro ao carregar agendamento.'),
              );
            },
            data: (data) => Expanded(
              child: SfCalendar(
                dataSource: AppointmentDatasource(data),
                allowViewNavigation: true,
                showNavigationArrow: true,
                showDatePickerButton: true,
                showTodayButton: true,
                todayHighlightColor: ColorsConstants.brown,
                onViewChanged: (viewDetails) {
                  if (ignoreFirstLoad) {
                    ignoreFirstLoad = false;
                    return;
                  }

                  ref
                      .read(
                        employeeScheduleVMProvider(userId, dateSelected)
                            .notifier,
                      )
                      .changeDate(userId, viewDetails.visibleDates.first);
                },
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
          ),
        ],
      ),
    );
  }
}
