import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_loader.dart';

startLoading() {
  showDialog(
    context: Get.context!,
    barrierDismissible: false,
    useSafeArea: true,
    builder: (context) =>const CustomLoader(),
  );
}

stopLoading() {
  Get.back();
}
