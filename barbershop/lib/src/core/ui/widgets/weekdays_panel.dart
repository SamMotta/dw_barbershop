import 'package:barbershop/src/core/constants/constants.dart';
import 'package:flutter/material.dart';

class WeekdaysPanel extends StatelessWidget {
  const WeekdaysPanel({
    required this.onDayPressed,
    this.enabledDays,
    super.key,
  });

  final List<String>? enabledDays;
  final ValueChanged<String> onDayPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Selecione os dias de atendimento',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DayButton(
                'Seg',
                onDayPressed,
                enabledDays,
              ),
              DayButton(
                'Ter',
                onDayPressed,
                enabledDays,
              ),
              DayButton(
                'Qua',
                onDayPressed,
                enabledDays,
              ),
              DayButton(
                'Qui',
                onDayPressed,
                enabledDays,
              ),
              DayButton(
                'Sex',
                onDayPressed,
                enabledDays,
              ),
              DayButton(
                'Sab',
                onDayPressed,
                enabledDays,
              ),
              DayButton(
                'Dom',
                onDayPressed,
                enabledDays,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DayButton extends StatefulWidget {
  const DayButton(this.label, this.onDayPressed, this.enabledDays, {super.key});

  final List<String>? enabledDays;
  final ValueChanged<String> onDayPressed;
  final String label;

  @override
  State<DayButton> createState() => _DayButtonState();
}

class _DayButtonState extends State<DayButton> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    var backgroundColor =
        isSelected ? ColorsConstants.brown : null;
    final borderColor =
        isSelected ? ColorsConstants.brown : ColorsConstants.grey;
    final textColor = isSelected ? Colors.white : ColorsConstants.grey;

    final DayButton(:enabledDays, :label, :onDayPressed) = widget;
    final isDisabledDay = enabledDays != null && !enabledDays.contains(label);

    if (isDisabledDay) {
      backgroundColor = Colors.grey.shade400;
    }

    return Padding(
      padding: const EdgeInsets.all(3),
      child: InkWell(
        onTap: isDisabledDay
            ? null
            : () {
                onDayPressed(label);
                setState(() => isSelected = !isSelected);
              },
        child: Container(
          width: 40,
          height: 56,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: borderColor),
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
      ),
    );
  }
}
