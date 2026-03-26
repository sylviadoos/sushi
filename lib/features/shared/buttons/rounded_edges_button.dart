import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../../../main.dart';

class RoundedEdgesButton extends StatelessWidget {
  final String txt;
  final Color? txtColor;
  final Color? color;
  final double? width;
  final double? height;
  final void Function()? onTap;

  const RoundedEdgesButton(
      {super.key,
      required this.onTap,
      this.color = AppColors.primaryBckColor,
      this.width,
      this.height,
      required this.txt,
      this.txtColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? screenWidth / 2,
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: color,
            boxShadow: const [
              BoxShadow(color: Colors.black26, blurRadius: 5, spreadRadius: 0.2)
            ]),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Center(
            child: Text(txt,
                textAlign: TextAlign.center,
                style: txtColor == null
                    ? Get.theme.textTheme.labelMedium
                    : Get.theme.textTheme.labelMedium!
                        .copyWith(color: txtColor)),
          ),
        ),
      ),
    );
  }
}

class BorderRoundedEdgesButton extends StatelessWidget {
  final String txt;
  final Color? txtColor;
  final Color? color;
  final double? width;
  final double? height;
  final Function onTap;

  const BorderRoundedEdgesButton(
      {super.key,
      required this.onTap,
      this.color = Colors.white,
      this.width,
      this.height,
      required this.txt,
      this.txtColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        width: width ?? screenWidth / 2,
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(),
            color: color,
            boxShadow: const [
              BoxShadow(color: Colors.black26, blurRadius: 5, spreadRadius: 0.2)
            ]),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Center(
            child: Text(txt,
                textAlign: TextAlign.center,
                style: txtColor == null
                    ? Get.theme.textTheme.labelMedium
                    : Get.theme.textTheme.labelMedium!
                        .copyWith(color: txtColor)),
          ),
        ),
      ),
    );
  }
}
