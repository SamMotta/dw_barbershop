import 'package:barbershop/src/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleCalendar extends StatefulWidget {
  const ScheduleCalendar({super.key});

  @override
  State<ScheduleCalendar> createState() => _ScheduleCalendarState();
}

class _ScheduleCalendarState extends State<ScheduleCalendar> {
  DateTime? selectedDay;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Container(
      child: Column(
        children: [
          TableCalendar<void>(
            availableGestures: AvailableGestures.none,
            headerStyle: const HeaderStyle(titleCentered: true),
            rangeSelectionMode: RangeSelectionMode.disabled,
            locale: 'pt_BR',
            focusedDay: now,
            firstDay: DateTime.utc(now.year, now.month),
            lastDay: now.add(const Duration(days: 14)),
            availableCalendarFormats: const {
              CalendarFormat.month: 'Month',
            },
            selectedDayPredicate: (day) {
              return isSameDay(day, selectedDay);
            },
            onDaySelected: (selectedDay, _) => setState(() {
              this.selectedDay = selectedDay;
            }),
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                color: ColorsConstants.grey,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: ColorsConstants.brown,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
