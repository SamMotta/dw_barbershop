import 'package:barbershop/src/core/ui/helpers/form_helper.dart';
import 'package:barbershop/src/core/ui/widgets/avatar_widget.dart';
import 'package:barbershop/src/core/ui/widgets/hours_panel.dart';
import 'package:barbershop/src/core/ui/widgets/weekdays_panel.dart';
import 'package:flutter/material.dart';

class EmployeeRegisterPage extends StatefulWidget {
  const EmployeeRegisterPage({super.key});

  @override
  State<EmployeeRegisterPage> createState() => _EmployeeRegisterPageState();
}

class _EmployeeRegisterPageState extends State<EmployeeRegisterPage> {
  bool isAdmin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar colaborador'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 14),
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
                    }),
                  ),
                  const Flexible(
                    child: Text(
                      'Sou admistrador e quero me cadastrar como colaborador',
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
                      onTapOutside: (_) => context.unfocus(),
                      decoration: const InputDecoration(
                        label: Text('Nome'),
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      onTapOutside: (_) => context.unfocus(),
                      decoration: const InputDecoration(
                        label: Text('E-mail'),
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      onTapOutside: (_) => context.unfocus(),
                      decoration: const InputDecoration(
                        label: Text('Senha'),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
              const WeekdaysPanel(onDayPressed: print),
              const SizedBox(height: 24),
              const HoursPanel(
                startTime: 6,
                endTime: 23,
                onHourPressed: print,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(56),
                ),
                onPressed: () {},
                child: const Text('Cadastrar colaborador'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
