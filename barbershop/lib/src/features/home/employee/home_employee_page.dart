import 'dart:developer';

import 'package:barbershop/src/core/constants/constants.dart';
import 'package:barbershop/src/core/providers/application_providers.dart';
import 'package:barbershop/src/core/ui/widgets/avatar_widget.dart';
import 'package:barbershop/src/core/ui/widgets/barbershop_loader.dart';
import 'package:barbershop/src/features/home/employee/home_employee_provider.dart';
import 'package:barbershop/src/features/home/widgets/home_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeEmployeePage extends ConsumerWidget {
  const HomeEmployeePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userModelAsync = ref.watch(getMeProvider);

    return Scaffold(
      body: userModelAsync.when(
        error: (error, stackTrace) {
          log(
            'Ocorreu um erro ao carregar dados do Usuário.',
            error: error,
            stackTrace: StackTrace.current,
          );
          return const Center(
            child: Text(
              'Ocorreu um erro ao carregar dados do Usuário.',
              style: TextStyle(fontSize: 26),
            ),
          );
        },
        loading: BarbershopLoader.new,
        data: (employee) => CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: HomeHeader(hideFilter: true),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const AvatarWidget(
                      hideUploadButton: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 20,
                      ),
                      child: Text(
                        employee.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.sizeOf(context).width * .7,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: ColorsConstants.grey),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Consumer(
                            builder: (context, ref, child) {
                              final totalSchedulesAsync = ref.watch(
                                getTotalSchedulesProvider(employee.id),
                              );

                              return totalSchedulesAsync.when(
                                skipLoadingOnRefresh: false,
                                error: (error, stackTrace) {
                                  log(
                                    'Ocorreu um erro ao carregar '
                                    'dados de agendamento.',
                                    error: error,
                                    stackTrace: StackTrace.current,
                                  );
                                  return const Center(
                                    child: Text(
                                      'Ocorreu um erro ao carregar '
                                      'dados de agendamento.',
                                      style: TextStyle(fontSize: 26),
                                    ),
                                  );
                                },
                                loading: BarbershopLoader.new,
                                data: (data) => Text(
                                  data.toString(),
                                  style: const TextStyle(
                                    color: ColorsConstants.brown,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 28,
                                  ),
                                ),
                              );
                            },
                          ),
                          const Text(
                            'Hoje',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(56),
                        ),
                        onPressed: () async {
                          await Navigator.of(context)
                              .pushNamed('/schedule', arguments: employee);
                          ref.invalidate(getTotalSchedulesProvider);
                        },
                        child: const Text('Agendar Cliente'),
                      ),
                    ),
                    OutlinedButton(
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(
                          color: ColorsConstants.brown,
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        minimumSize: const Size.fromHeight(56),
                      ),
                      onPressed: () async {
                        await Navigator.of(context).pushNamed(
                          '/employee/schedule',
                          arguments: employee,
                        );
                        ref.invalidate(getTotalSchedulesProvider);
                      },
                      child: const Text('Agenda'),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
