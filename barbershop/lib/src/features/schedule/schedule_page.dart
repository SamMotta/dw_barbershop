import 'package:barbershop/src/core/constants/constants.dart';
import 'package:barbershop/src/core/ui/helpers/form_helper.dart';
import 'package:barbershop/src/core/ui/helpers/messages.dart';
import 'package:barbershop/src/core/ui/icons/barbershop_icons.dart';
import 'package:barbershop/src/core/ui/widgets/avatar_widget.dart';
import 'package:barbershop/src/core/ui/widgets/hours_panel.dart';
import 'package:barbershop/src/features/schedule/widgets/schedule_calendar.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:validatorless/validatorless.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final formKey = GlobalKey<FormState>();
  final dateFormatter = DateFormat('dd/mm/yyyy');

  final nameEC = TextEditingController();
  final dateEC = TextEditingController();

  bool showCalendar = false;

  @override
  void dispose() {
    nameEC.dispose();
    dateEC.dispose();
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
          child: Form(
            key: formKey,
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
                  validator:
                      Validatorless.required('O campo cliente é obrigatório.'),
                  onTapOutside: (_) => context.unfocus(),
                  decoration: const InputDecoration(
                    label: Text('Cliente'),
                  ),
                ),
                const SizedBox(height: 32),
                TextFormField(
                  readOnly: true,
                  controller: dateEC,
                  validator: Validatorless.date('Insira uma data válida.'),
                  onTap: () => setState(() {
                    showCalendar = true;
                  }),
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
                Offstage(
                  offstage: !showCalendar,
                  child: Column(
                    children: [
                      const SizedBox(height: 32),
                      ScheduleCalendar(
                        okPressed: (selectedDay) {
                          setState(() {
                            dateEC.text = dateFormatter.format(selectedDay);
                            showCalendar = false;
                          });
                        },
                        cancelPressed: () {
                          setState(() {
                            showCalendar = false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const HoursPanel.singleSelection(
                  startTime: 6,
                  endTime: 23,
                  onHourPressed: print,
                  enabledHours: [6, 7, 8, 9, 10],
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                  ),
                  onPressed: () {
                    switch (formKey.currentState?.validate()) {
                      case false || null:
                        Messages.showError(
                          'Dados incompletos ou inválidos.',
                          context,
                        );
                      case true:
                    }
                  },
                  child: const Text(
                    'Agendar',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
