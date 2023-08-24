// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:barbershop/src/core/constants/constants.dart';
import 'package:flutter/material.dart';

class HoursPanel extends StatelessWidget {
  const HoursPanel({
    required this.startTime,
    required this.endTime,
    required this.onHourPressed,
    this.enabledHours,
    super.key,
  });

  final List<int>? enabledHours;
  final ValueChanged<int> onHourPressed;
  final int startTime;
  final int endTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Selecione os horários de atendimento',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 16,
          children: [
            for (var i = startTime; i <= endTime; i++)
              TimeButton(
                '${i.toString().padLeft(2, '0')}:00',
                onHourPressed,
                i,
                enabledHours,
              ),
          ],
        ),
      ],
    );
  }
}

class TimeButton extends StatefulWidget {
  const TimeButton(
    this.label,
    this.onHourPressed,
    this.value,
    this.enabledHours, {
    super.key,
  });

  final List<int>? enabledHours;
  final ValueChanged<int> onHourPressed;
  final int value;
  final String label;

  @override
  State<TimeButton> createState() => _TimeButtonState();
}

class _TimeButtonState extends State<TimeButton> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    final TimeButton(:enabledHours, :label, :onHourPressed, :value) = widget;

    final borderColor =
        isSelected ? ColorsConstants.brown : ColorsConstants.grey;
    var bgColor = isSelected ? ColorsConstants.brown : null;
    final textColor = isSelected ? Colors.white : ColorsConstants.grey;

    final isDisabledHour =
        enabledHours != null && !enabledHours.contains(value);

    if (isDisabledHour) {
      bgColor = Colors.grey.shade400;
    }

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: isDisabledHour
          ? null
          : () => setState(() {
                isSelected = !isSelected;
                onHourPressed(value);
              }),
      child: Container(
        height: 36,
        width: 64,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: bgColor,
          border: Border.all(
            color: borderColor,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
