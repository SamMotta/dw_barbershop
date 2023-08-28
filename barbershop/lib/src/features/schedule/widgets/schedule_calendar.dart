import 'package:barbershop/src/core/constants/constants.dart';
import 'package:barbershop/src/core/ui/helpers/messages.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleCalendar extends StatefulWidget {
  const ScheduleCalendar({
    required this.cancelPressed,
    required this.okPressed,
    required this.workDays,
    super.key,
  });

  final VoidCallback cancelPressed;
  final ValueChanged<DateTime> okPressed;
  final List<String> workDays;

  @override
  State<ScheduleCalendar> createState() => _ScheduleCalendarState();
}

class _ScheduleCalendarState extends State<ScheduleCalendar> {
  DateTime? selectedDay;
  late final List<int> weekDaysEnabled;

  int convertWeekday(String weekDay) {
    return switch (weekDay.toLowerCase()) {
      'seg' => DateTime.monday,
      'ter' => DateTime.tuesday,
      'qua' => DateTime.wednesday,
      'qui' => DateTime.thursday,
      'sex' => DateTime.friday,
      'sab' => DateTime.saturday,
      'dom' => DateTime.sunday,
      _ => 0,
    };
  }

  @override
  void initState() {
    weekDaysEnabled = widget.workDays.map(convertWeekday).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final ScheduleCalendar(:cancelPressed, :okPressed) = widget;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFe6e2e9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          TableCalendar<void>(
            availableGestures: AvailableGestures.none,
            headerStyle: const HeaderStyle(titleCentered: true),
            rangeSelectionMode: RangeSelectionMode.disabled,
            locale: 'pt_BR',
            focusedDay: now,
            firstDay: DateTime.utc(now.year),
            lastDay: now.add(const Duration(days: 7)),
            enabledDayPredicate: (day) => weekDaysEnabled.contains(day.weekday),
            availableCalendarFormats: const {
              CalendarFormat.month: 'Month',
            },
            selectedDayPredicate: (day) {
              return isSameDay(day, selectedDay);
            },
            onDaySelected: (selectedDay, _) => setState(() {
              this.selectedDay = selectedDay;
            }),
            calendarStyle: CalendarStyle(
              todayDecoration: const BoxDecoration(
                color: ColorsConstants.brown,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: ColorsConstants.brown.withOpacity(0.4),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: cancelPressed,
                child: const Text(
                  'Cancelar',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: ColorsConstants.brown,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  final selectedDay = this.selectedDay;
                  if (selectedDay is DateTime) {
                    return okPressed(selectedDay);
                  }

                  return Messages.showError('Selecione um dia.', context);
                },
                child: const Text(
                  'Ok',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: ColorsConstants.brown,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
