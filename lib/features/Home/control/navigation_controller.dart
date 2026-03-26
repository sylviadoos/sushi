import 'package:get/get.dart';

class NavigationController extends GetxController {
  RxInt currentIndex = RxInt(0);
  goToAllProducts() {

    currentIndex.value = 5;
  }

}
