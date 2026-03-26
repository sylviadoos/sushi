import 'package:sushi/main.dart';
import 'package:sushi/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';

//secondary
AppBar PrimaryAppBar({
  required String title,
  Widget? leading,
  Widget? suffix,
  Color? color,
  bool? backLogin,
  void Function()? actionEvent,
  String? image,
}) {
  return AppBar(
    centerTitle: true,
    title: Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Text(title),
    ),
    backgroundColor: color,
    surfaceTintColor: color,
    leading: leading ??
        IconButton(
            onPressed: () {
              if(backLogin==true){
                Get.offAllNamed(AppRoutes.signIn);
              }else{
                Get.back();
              }
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
    actions: [
      if (image != null)
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: actionEvent,
            child: SvgPicture.asset(image),
          ),
        ),
      if (suffix != null)
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: suffix,
        ),
    ],
  );
}

class CustomAppbar extends StatelessWidget {
  final String title;

  const CustomAppbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight * 0.15,
      width: screenWidth,
      decoration: const BoxDecoration(
        color: AppColors.lightBckColor,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      child: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: Get.textTheme.headlineLarge!
              .copyWith(color: AppColors.darkTextColor),
        ),
      ),
    );
  }
}

Widget SettingsAppBar({
  required String title,
  required String? image,
  void Function()? actionEvent,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: AppColors.darkTextColor,
        ),
      ),
      // Text(
      //   title,
      //   style: Get.theme.textTheme.headlineSmall,
      // ),
      Text(title, style: Get.textTheme.bodyLarge!.copyWith(fontSize: 25)),
      if (image != null)
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
              onTap: actionEvent, child: SvgPicture.asset(image)),
        )
    ],
  );
}
