import 'package:barbershop/src/core/constants/constants.dart';
import 'package:barbershop/src/core/ui/icons/barbershop_icons.dart';
import 'package:barbershop/src/core/ui/widgets/avatar_widget.dart';
import 'package:barbershop/src/features/schedule/widgets/schedule_calendar.dart';

import 'package:flutter/material.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final nameEC = TextEditingController();

  @override
  void dispose() {
    nameEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Agendar',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15).copyWith(bottom: 24),
        child: Center(
          child: Column(
            children: [
              const AvatarWidget(hideUploadButton: true),
              const SizedBox(height: 24),
              const Text(
                'Nome e sobrenome',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 37),
              TextFormField(
                controller: nameEC,
                decoration: const InputDecoration(
                  label: Text('Cliente'),
                ),
              ),
              const SizedBox(height: 32),
              TextFormField(
                readOnly: true,
                decoration: const InputDecoration(
                  label: Text('Selecione uma data e hora'),
                  hintText: 'Selecione uma data e hora',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  suffixIcon: Icon(
                    BarbershopIcons.calendar,
                    color: ColorsConstants.brown,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const ScheduleCalendar(),
            ],
          ),
        ),
      ),
    );
  }
}
