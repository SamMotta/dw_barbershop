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
              DayButton('Seg', onDayPressed),
              DayButton('Ter', onDayPressed),
              DayButton('Qua', onDayPressed),
              DayButton('Qui', onDayPressed),
              DayButton('Sex', onDayPressed),
              DayButton('Sab', onDayPressed),
              DayButton('Dom', onDayPressed),
            ],
          ),
        ),
      ],
    );
  }
}

class DayButton extends StatefulWidget {
  const DayButton(
    this.label,
    this.onDayPressed, {
    super.key,
  });

  final ValueChanged<String> onDayPressed;
  final String label;

  @override
  State<DayButton> createState() => _DayButtonState();
}

class _DayButtonState extends State<DayButton> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: InkWell(
        onTap: () {
          widget.onDayPressed(widget.label);
          setState(() => isSelected = !isSelected);
        },
        child: Container(
          width: 40,
          height: 56,
          decoration: BoxDecoration(
            color: isSelected ? ColorsConstants.brown : null,
            borderRadius: BorderRadius.circular(8),
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
      ),
    );
  }
}
