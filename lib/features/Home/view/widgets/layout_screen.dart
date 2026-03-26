import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../routes/app_routes.dart';
import '../../home_static_data/home_static_data.dart';
import 'CustomBottomNavBarItem.dart';

enum NavBarSelectedScreen { homeScreen, tracking, delivery, products, settings }

class AppNavBar extends StatelessWidget {
  const AppNavBar({super.key, required this.selectedScreen});

  final NavBarSelectedScreen selectedScreen;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: List.generate(
        pagesNames.length,
        (index) => BottomNavigationBarItem(
          icon: CustomBottomNavBarItem(
              selectedScreen: selectedScreen,
              index,
              AssetsManager.navPagesIcons[index]),
          backgroundColor: AppColors.lightBckColor,
          label: pagesNames[index],
        ),
      ).toList(),
      onTap: (int index) {
        switch (index) {
          case 0:
            Get.offNamed(AppRoutes.layout);
            break;
          case 1:
            Get.toNamed(AppRoutes.chatScreen);
            break;
          case 2:
            Get.toNamed(AppRoutes.orders);
            break;
          // case 3:
            // Get.toNamed(AppRoutes.product);
            // break;
          case 3:
            Get.toNamed(AppRoutes.settings);
            break;
        }
      },
    );
  }
}
