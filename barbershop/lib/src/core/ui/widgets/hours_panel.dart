// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:barbershop/src/core/constants/constants.dart';
import 'package:flutter/material.dart';

class HoursPanel extends StatelessWidget {
  const HoursPanel({
    required this.startTime,
    required this.endTime,
    required this.onHourPressed,
    super.key,
  });

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
    this.value, {
    super.key,
  });

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
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () => setState(() {
        isSelected = !isSelected;
        widget.onHourPressed(widget.value);
      }),
      child: Container(
        height: 36,
        width: 64,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? ColorsConstants.brown : null,
          border: Border.all(
            color: isSelected ? ColorsConstants.brown : ColorsConstants.grey,
          ),
        ),
        child: Center(
          child: Text(
            widget.label,
            style: TextStyle(
              color: isSelected ? Colors.white : ColorsConstants.grey,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
