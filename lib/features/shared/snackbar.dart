import 'package:get/get.dart';

showCustomSnackBar(String? title, String txt) {
  Get.showSnackbar(GetSnackBar(
title: title,
message: txt,
duration:const Duration(seconds: 2),
  ));
}
