import 'package:barbershop/src/core/constants/constants.dart';
import 'package:barbershop/src/core/ui/helpers/form_helper.dart';
import 'package:barbershop/src/core/ui/helpers/messages.dart';
import 'package:barbershop/src/core/ui/icons/barbershop_icons.dart';
import 'package:barbershop/src/core/ui/widgets/avatar_widget.dart';
import 'package:barbershop/src/core/ui/widgets/hours_panel.dart';
import 'package:barbershop/src/features/schedule/schedule_state.dart';
import 'package:barbershop/src/features/schedule/schedule_vm.dart';
import 'package:barbershop/src/features/schedule/widgets/schedule_calendar.dart';
import 'package:barbershop/src/models/user_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:validatorless/validatorless.dart';

class SchedulePage extends ConsumerStatefulWidget {
  const SchedulePage({super.key});

  @override
  ConsumerState<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends ConsumerState<SchedulePage> {
  final formKey = GlobalKey<FormState>();
  final dateFormatter = DateFormat('dd/MM/yyyy');

  final clientEC = TextEditingController();
  final dateEC = TextEditingController();

  bool showCalendar = false;

  @override
  void dispose() {
    clientEC.dispose();
    dateEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheduleVM = ref.watch(scheduleVMProvider.notifier);

    final user = ModalRoute.of(context)!.settings.arguments! as UserModel;

    final employee = switch (user) {
      UserModelAdmin(:final workDays, :final workHours) => (
          workDays: workDays!,
          workHours: workHours!,
        ),
      UserModelEmployee(:final workDays, :final workHours) => (
          workDays: workDays,
          workHours: workHours,
        ),
    };

    ref.listen(
      scheduleVMProvider.select((state) => state.status),
      (_, status) {
        switch (status) {
          case ScheduleStatus.initial:
            break;
          case ScheduleStatus.success:
            Messages.showSuccess('Cliente agendado com sucesso', context);
            Navigator.of(context).pop();
          case ScheduleStatus.error:
            Messages.showError(
              'Ocorreu um erro ao registrar agendamento',
              context,
            );
        }
      },
    );

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
                Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 37),
                TextFormField(
                  controller: clientEC,
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
                  validator:
                      Validatorless.required('O campo data é obrigatório.'),
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
                        workDays: employee.workDays,
                        okPressed: (selectedDay) {
                          dateEC.text = dateFormatter.format(selectedDay);
                          scheduleVM.dateSelect(selectedDay);
                          showCalendar = false;
                          setState(() {});
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
                HoursPanel.singleSelection(
                  startTime: 6,
                  endTime: 23,
                  onHourPressed: scheduleVM.hourSelect,
                  enabledHours: employee.workHours,
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
                        final hourSelected = ref.watch(
                          scheduleVMProvider
                              .select((state) => state.scheduleHour != null),
                        );

                        if (hourSelected) {
                          scheduleVM.register(
                            user: user,
                            clientName: clientEC.text,
                          );
                        } else {
                          Messages.showError(
                            'Selecione um horário de atendimento',
                            context,
                          );
                        }
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
