import 'package:barbershop/src/core/constants/constants.dart';
import 'package:flutter/material.dart';

class WeekdaysPanel extends StatelessWidget {
  const WeekdaysPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'Selecione os dias de atendimento',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
        ),
        SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DayButton('Seg'),
              DayButton('Ter'),
              DayButton('Qua'),
              DayButton('Qui'),
              DayButton('Sex'),
              DayButton('Sab'),
              DayButton('Dom'),
            ],
          ),
        ),
      ],
    );
  }
}

class DayButton extends StatefulWidget {
  const DayButton(
    this.label, {
    super.key,
  });

  final String label;

  @override
  State<DayButton> createState() => _DayButtonState();
}

class _DayButtonState extends State<DayButton> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: InkWell(
        onTap: () => setState(
          () => selected = !selected,
        ),
        child: Container(
          width: 40,
          height: 56,
          decoration: BoxDecoration(
            color: selected ? ColorsConstants.brown : null,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: selected ? ColorsConstants.brown : ColorsConstants.grey,
            ),
          ),
          child: Center(
            child: Text(
              widget.label,
              style: TextStyle(
                color: selected ? Colors.white : ColorsConstants.grey,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
