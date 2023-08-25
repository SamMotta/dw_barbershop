import 'package:barbershop/src/core/constants/constants.dart';
import 'package:flutter/material.dart';

class HoursPanel extends StatefulWidget {
  const HoursPanel({
    required this.startTime,
    required this.endTime,
    required this.onHourPressed,
    this.enabledHours,
    super.key,
  }) : singleSelection = false;

  const HoursPanel.singleSelection({
    required this.onHourPressed,
    required this.startTime,
    required this.endTime,
    this.enabledHours,
    super.key,
  }) : singleSelection = true;

  final List<int>? enabledHours;
  final ValueChanged<int> onHourPressed;
  final int startTime;
  final int endTime;
  final bool singleSelection;

  @override
  State<HoursPanel> createState() => _HoursPanelState();
}

class _HoursPanelState extends State<HoursPanel> {
  int? lastSelection;

  @override
  Widget build(BuildContext context) {
    final HoursPanel(
      :enabledHours,
      :onHourPressed,
      :startTime,
      :endTime,
      :singleSelection,
    ) = widget;

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
                label: '${i.toString().padLeft(2, '0')}:00',
                onHourPressed: (hourSelected) {
                  setState(() {
                    if (singleSelection) {
                      if (lastSelection == hourSelected) {
                        lastSelection = null;
                      } else {
                        lastSelection = hourSelected;
                      }
                    }
                  });
                  onHourPressed(hourSelected);
                },
                singleSelection: singleSelection,
                timeSelected: lastSelection,
                value: i,
                enabledHours: enabledHours,
              ),
          ],
        ),
      ],
    );
  }
}

class TimeButton extends StatefulWidget {
  const TimeButton({
    required this.label,
    required this.onHourPressed,
    required this.value,
    required this.enabledHours,
    required this.singleSelection,
    this.timeSelected,
    super.key,
  });

  final bool singleSelection;
  final List<int>? enabledHours;
  final ValueChanged<int> onHourPressed;
  final int? timeSelected;
  final int value;
  final String label;

  @override
  State<TimeButton> createState() => _TimeButtonState();
}

class _TimeButtonState extends State<TimeButton> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    final TimeButton(
      :enabledHours,
      :label,
      :onHourPressed,
      :value,
      :singleSelection,
      :timeSelected,
    ) = widget;

    if (singleSelection) {
      if (timeSelected != null) {
        if (timeSelected == value) {
          isSelected = true;
        } else {
          isSelected = false;
        }
      }
    }

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
