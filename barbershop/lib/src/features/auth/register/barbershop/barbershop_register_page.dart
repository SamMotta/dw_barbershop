import 'package:barbershop/src/core/ui/helpers/form_helper.dart';
import 'package:barbershop/src/core/ui/helpers/messages.dart';
import 'package:barbershop/src/core/ui/widgets/hours_panel.dart';
import 'package:barbershop/src/core/ui/widgets/weekdays_panel.dart';
import 'package:barbershop/src/features/auth/register/barbershop/barbershop_register_state.dart';
import 'package:barbershop/src/features/auth/register/barbershop/barbershop_register_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

class BarbershopRegisterPage extends ConsumerStatefulWidget {
  const BarbershopRegisterPage({super.key});

  @override
  ConsumerState<BarbershopRegisterPage> createState() =>
      _BarbershopRegisterPageState();
}

class _BarbershopRegisterPageState
    extends ConsumerState<BarbershopRegisterPage> {
  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();

  @override
  void dispose() {
    nameEC.dispose();
    emailEC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final barbershopRegisterVM =
        ref.watch(barbershopRegisterVMProvider.notifier);

    ref.listen(barbershopRegisterVMProvider, (_, state) {
      switch (state.status) {
        case BarbershopRegisterStatus.initial:
          break;
        case BarbershopRegisterStatus.success:
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/home/admin',
            (route) => false,
          );
        case BarbershopRegisterStatus.error:
          Messages.showError('Ocorreu um erro ao registrar barbearia', context);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar estabelecimento'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                TextFormField(
                  onTapOutside: (_) => context.unfocus(),
                  controller: nameEC,
                  validator:
                      Validatorless.required('O campo nome é obrigatório.'),
                  decoration: const InputDecoration(
                    label: Text('Nome'),
                  ),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  onTapOutside: (_) => context.unfocus(),
                  controller: emailEC,
                  validator: Validatorless.multiple([
                    Validatorless.required('O campo e-mail é obrigatório.'),
                    Validatorless.email('O campo e-mail não é válido.'),
                  ]),
                  decoration: const InputDecoration(
                    label: Text('E-mail'),
                  ),
                ),
                const SizedBox(height: 24),
                WeekdaysPanel(
                  onDayPressed: barbershopRegisterVM.addOrRemoveOpeningDays,
                ),
                const SizedBox(height: 24),
                HoursPanel(
                  startTime: 6,
                  endTime: 23,
                  onHourPressed: barbershopRegisterVM.addOrRemoveOpeningHours,
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: ElevatedButton(
                    onPressed: () {
                      switch (formKey.currentState?.validate()) {
                        case false || null:
                          Messages.showError('Formulário inválido.', context);

                        case true:
                          barbershopRegisterVM.register(
                            nameEC.text,
                            emailEC.text,
                          );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(56),
                    ),
                    child: const Text(
                      'Cadastrar estabelecimento',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
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
