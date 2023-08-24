import 'dart:developer';

import 'package:barbershop/src/core/constants/constants.dart';
import 'package:barbershop/src/core/ui/icons/barbershop_icons.dart';
import 'package:barbershop/src/core/ui/widgets/barbershop_loader.dart';
import 'package:barbershop/src/features/home/admin/home_admin_vm.dart';
import 'package:barbershop/src/features/home/admin/widgets/home_employee_tile.dart';
import 'package:barbershop/src/features/home/widgets/home_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeAdminPage extends ConsumerWidget {
  const HomeAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeAdminVMProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: ColorsConstants.brown,
        onPressed: () async {
          await Navigator.of(context).pushNamed('/employee/register');
          ref.invalidate(homeAdminVMProvider);
        },
        child: const CircleAvatar(
          backgroundColor: Colors.white,
          maxRadius: 13,
          child: Icon(BarbershopIcons.addEmploye, color: ColorsConstants.brown),
        ),
      ),
      body: homeState.whenOrNull(
        error: (error, stackTrace) {
          log(
            'Ocorreu um erro ao carregar colaboradores.',
            error: error,
            stackTrace: stackTrace,
          );

          return const Center(
            child: Text(
              'Ocorreu um erro ao carregar os dados dos colaboradores.',
              style: TextStyle(fontSize: 18),
            ),
          );
        },
        loading: () => const Center(child: BarbershopLoader()),
        data: (data) => CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: HomeHeader(),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => HomeEmployeeTile(
                  employee: data.employees[index],
                ),
                childCount: data.employees.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
