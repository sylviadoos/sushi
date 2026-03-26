import 'package:flutter/material.dart';

import '../../core/utils/app_colors.dart';

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  Function(double? rating)? onRatingChanged;

  StarRating({
    this.starCount = 5,
    this.rating = .0,
    required this.onRatingChanged,
  });

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = Icon(
        Icons.star_border_rounded,
        color: AppColors.dividerGrayColor,
        size: 45,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = Icon(
        Icons.star_half_rounded,
        color: Colors.yellow,
        size: 45,

      );
    } else {
      icon = Icon(
        Icons.star_border_rounded,
        color: Colors.yellow,
        size: 45,

      );
    }
    return InkResponse(
      onTap: onRatingChanged == null ? null : () => onRatingChanged!(rating),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        children:
            List.generate(starCount, (index) => buildStar(context, index)));
  }
}
