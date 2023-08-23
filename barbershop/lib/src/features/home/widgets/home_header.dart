import 'package:barbershop/src/core/constants/constants.dart';
import 'package:barbershop/src/core/providers/application_providers.dart';
import 'package:barbershop/src/core/ui/icons/barbershop_icons.dart';
import 'package:barbershop/src/core/ui/widgets/barbershop_loader.dart';
import 'package:barbershop/src/features/home/admin/home_admin_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeHeader extends ConsumerWidget {
  const HomeHeader({super.key, this.hideFilter = false});

  final bool hideFilter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final barbershop = ref.watch(getMyBarbershopProvider);

    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.only(bottom: 18),
      width: MediaQuery.sizeOf(context).width,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
        image: DecorationImage(
          fit: BoxFit.cover,
          opacity: 0.5,
          image: AssetImage(ImageConstants.backgroundChair),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          barbershop.maybeWhen(
            orElse: () => const Center(
              child: BarbershopLoader(),
            ),
            data: (data) => Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Color(0xFFbdbdbd),
                  child: SizedBox.shrink(),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: Text(
                    data.name,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Text(
                    'Editar',
                    style: TextStyle(
                      color: ColorsConstants.brown,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () =>
                      ref.read(homeAdminVMProvider.notifier).logout(),
                  icon: const Icon(
                    BarbershopIcons.exit,
                    color: ColorsConstants.brown,
                    size: 32,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Bem-vindo',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Agende um horário:',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 40,
            ),
          ),
          Offstage(
            offstage: hideFilter,
            child: const SizedBox(height: 24),
          ),
          Offstage(
            offstage: hideFilter,
            child: TextFormField(
              decoration: const InputDecoration(
                label: Text('Buscar colaborador'),
                suffixIconColor: ColorsConstants.brown,
                suffixIcon: Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Icon(BarbershopIcons.search, size: 26),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
