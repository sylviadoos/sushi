import 'package:flutter/material.dart';

import '../utils/app_colors.dart';


CheckboxThemeData checkboxThemedata = CheckboxThemeData(
  side: BorderSide.none,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(5),
  ),
  checkColor: MaterialStateProperty.resolveWith<Color>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return AppColors.primaryBckColor;
      }
      return AppColors.primaryBckColor;
    },
  ),
  fillColor: MaterialStateProperty.resolveWith<Color>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.white;
      }
      return AppColors.primaryBckColor;
    },
  ),
);
