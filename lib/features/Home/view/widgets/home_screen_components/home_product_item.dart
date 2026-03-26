import 'package:flutter/material.dart';



class HomeProductItem extends StatelessWidget {
  const HomeProductItem(
      {super.key,
      required  this.bottomRowWidget,
      // required  this.trillingIcon,
       required this.onTaped,
      required  this.productName ,
        this.productImage = '',
       required this.categoryName });

  final Widget bottomRowWidget;
  // final Widget trillingIcon;
  final Function() onTaped;
  final String? productName;
  final String? productImage;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return Container(
      );
  }
}
