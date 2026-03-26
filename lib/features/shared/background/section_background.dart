import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../../main.dart';

class SectionBackground extends StatelessWidget {
  final Widget child;
  final Color color;
  final BoxBorder? border;
  final double? width,padding;
  final double redius;
  const SectionBackground({
    super.key,
    required this.child,
    this.color = AppColors.lightButtonColor,
    this.border,
    this.width,
    this.padding,
    this.redius=20,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: padding??0),
      child: Container(
          width: width,
          decoration: BoxDecoration(
              border: border,
              color: color,
              borderRadius: BorderRadius.circular(redius)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: child,
          )),
    );
  }
}

class PositionedSectionBackground extends StatelessWidget {
  // final Widget child;
  final Color color, iconColor;

  const PositionedSectionBackground({
    super.key,
    this.color = AppColors.darkTextColor,
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 0.09,
      height:screenHeight * 0.04,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: color,
      ),
      child: Icon(
        Icons.edit,
        color: iconColor,
        size: 16,
      ),
    );
  }
}


