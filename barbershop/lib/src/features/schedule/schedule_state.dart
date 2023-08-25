import 'package:flutter/material.dart';

enum ScheduleStatus {
  initial,
  error,
  success,
}

class ScheduleState {
  const ScheduleState({
    required this.status,
    this.scheduleHour,
    this.scheduleDate,
  });

  const ScheduleState.initial() : this(status: ScheduleStatus.initial);

  final ScheduleStatus status;
  final int? scheduleHour;
  final DateTime? scheduleDate;
  ScheduleState copyWith({
    ScheduleStatus? status,
    ValueGetter<int?>? scheduleHour,
    ValueGetter<DateTime?>? scheduleDate,
  }) {
    return ScheduleState(
      status: status ?? this.status,
      scheduleHour: scheduleHour != null ? scheduleHour() : this.scheduleHour,
      scheduleDate: scheduleDate != null ? scheduleDate() : this.scheduleDate,
    );
  }
}
