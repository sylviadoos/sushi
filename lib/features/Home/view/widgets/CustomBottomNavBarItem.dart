import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_colors.dart';
import 'layout_screen.dart';

class CustomBottomNavBarItem extends StatelessWidget {
  final int index;
  final String img;

  const CustomBottomNavBarItem(this.index, this.img,
      {super.key, required this.selectedScreen});

  final NavBarSelectedScreen selectedScreen;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: index == selectedScreen.index
          ? AppColors.darkTextColor
          : Colors.transparent,
      child: SvgPicture.asset(img,
          colorFilter: index == selectedScreen.index
              ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
              : null),
    );
  }
}
