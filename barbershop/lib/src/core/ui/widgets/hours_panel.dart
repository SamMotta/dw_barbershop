// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:barbershop/src/core/constants/constants.dart';
import 'package:flutter/material.dart';

class HoursPanel extends StatelessWidget {
  const HoursPanel({
    required this.startTime,
    required this.endTime,
    super.key,
  });

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
              ),
          ],
        ),
      ],
    );
  }
}

class TimeButton extends StatelessWidget {
  const TimeButton(
    this.label, {
    super.key,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {},
      child: Container(
        height: 36,
        width: 64,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: ColorsConstants.grey),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(color: ColorsConstants.grey, fontSize: 12),
          ),
        ),
      ),
    );
  }
}
