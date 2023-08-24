import 'dart:developer';

import 'package:barbershop/src/core/providers/application_providers.dart';
import 'package:barbershop/src/core/ui/helpers/form_helper.dart';
import 'package:barbershop/src/core/ui/helpers/messages.dart';
import 'package:barbershop/src/core/ui/widgets/avatar_widget.dart';
import 'package:barbershop/src/core/ui/widgets/barbershop_loader.dart';
import 'package:barbershop/src/core/ui/widgets/hours_panel.dart';
import 'package:barbershop/src/core/ui/widgets/weekdays_panel.dart';
import 'package:barbershop/src/features/employee/register/employee_register_state.dart';
import 'package:barbershop/src/features/employee/register/employee_register_vm.dart';
import 'package:barbershop/src/models/barbershop_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

class EmployeeRegisterPage extends ConsumerStatefulWidget {
  const EmployeeRegisterPage({super.key});

  @override
  ConsumerState<EmployeeRegisterPage> createState() =>
      _EmployeeRegisterPageState();
}

class _EmployeeRegisterPageState extends ConsumerState<EmployeeRegisterPage> {
  bool isAdmin = false;

  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  @override
  void dispose() {
    nameEC.dispose();
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final employeeRegisterVM = ref.watch(employeeRegisterVMProvider.notifier);
    final barbershopAsync = ref.watch(getMyBarbershopProvider);

    ref.listen(
      employeeRegisterVMProvider.select((state) => state.status),
      (_, status) {
        switch (status) {
          case EmployeeRegisterStatus.initial:
            break;
          case EmployeeRegisterStatus.success:
            Messages.showSuccess('Colaborador cadastrado com sucesso', context);
            Navigator.of(context).pop();
          case EmployeeRegisterStatus.error:
            Messages.showError(
              'Ocorreu um erro ao registrar colaborador',
              context,
            );
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar colaborador'),
      ),
      body: barbershopAsync.when(
        error: (error, stackTrace) {
          log(
            'deu erro',
            error: error,
            stackTrace: stackTrace,
          );

          return const Center(
            child: Text(
              'Ocorreu um erro ao carregar página.',
            ),
          );
        },
        loading: () => const Center(child: BarbershopLoader()),
        data: (barbershopModel) {
          final BarbershopModel(:openingDays, :openingHours) = barbershopModel;

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Form(
              key: formKey,
              child: Center(
                child: Column(
                  children: [
                    const AvatarWidget(),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Checkbox.adaptive(
                          value: isAdmin,
                          onChanged: (_) => setState(() {
                            isAdmin = !isAdmin;
                            employeeRegisterVM.toggleIsRegistringAdmin(
                              isAdmin: isAdmin,
                            );
                          }),
                        ),
                        const Flexible(
                          child: Text(
                            'Sou admistrador e quero me '
                            'cadastrar como colaborador',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Offstage(
                      offstage: isAdmin,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: nameEC,
                            validator: isAdmin
                                ? null
                                : Validatorless.required(
                                    'O campo nome é obrigatório',
                                  ),
                            onTapOutside: (_) => context.unfocus(),
                            decoration: const InputDecoration(
                              label: Text('Nome'),
                            ),
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            controller: emailEC,
                            validator: isAdmin
                                ? null
                                : Validatorless.multiple([
                                    Validatorless.required(
                                      'O campo e-mail é obrigatório',
                                    ),
                                    Validatorless.email('E-mail inválido'),
                                  ]),
                            onTapOutside: (_) => context.unfocus(),
                            decoration: const InputDecoration(
                              label: Text('E-mail'),
                            ),
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            controller: passwordEC,
                            validator: isAdmin
                                ? null
                                : Validatorless.multiple([
                                    Validatorless.required(
                                      'O campo senha é obrigatório',
                                    ),
                                    Validatorless.min(
                                      6,
                                      'O mínimo de caracteres é 6',
                                    ),
                                  ]),
                            onTapOutside: (_) => context.unfocus(),
                            decoration: const InputDecoration(
                              label: Text('Senha'),
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                    WeekdaysPanel(
                      onDayPressed: employeeRegisterVM.addOrRemoveWorkDays,
                      enabledDays: openingDays,
                    ),
                    const SizedBox(height: 24),
                    HoursPanel(
                      enabledHours: openingHours,
                      startTime: 6,
                      endTime: 23,
                      onHourPressed: employeeRegisterVM.addOrRemoveWorkHours,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(56),
                      ),
                      onPressed: () {
                        switch (formKey.currentState?.validate()) {
                          case false || null:
                            Messages.showError('Campos inválidos', context);
                          case true:
                            final EmployeeRegisterState(
                              workDays: List(isNotEmpty: hasWorkDays),
                              workHours: List(isNotEmpty: hasWorkHours)
                            ) = ref.watch(employeeRegisterVMProvider);

                            if (!hasWorkDays || !hasWorkHours) {
                              return Messages.showError(
                                'Por favor, selecione os dias de atendimento '
                                'e os horários de atendimento',
                                context,
                              );
                            }

                            employeeRegisterVM.register(
                              name: nameEC.text,
                              email: emailEC.text,
                              password: passwordEC.text,
                            );
                        }
                      },
                      child: const Text('Cadastrar colaborador'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
