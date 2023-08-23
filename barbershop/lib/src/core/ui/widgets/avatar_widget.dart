import 'package:barbershop/src/core/constants/constants.dart';
import 'package:barbershop/src/core/ui/icons/barbershop_icons.dart';
import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      height: 110,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: const DecorationImage(
                image: AssetImage(ImageConstants.avatar),
              ),
            ),
          ),
          Positioned(
            bottom: 2,
            right: 2,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: ColorsConstants.brown, width: 2),
              ),
              child: const Icon(
                BarbershopIcons.addEmploye,
                color: ColorsConstants.brown,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
