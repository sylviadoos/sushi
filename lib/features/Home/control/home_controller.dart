import 'package:get/get.dart';

class HomeController extends GetxController {
  List<String> taps = ['Pending', 'Preparing', 'Ready', 'Pickup', 'Done'];
  RxInt currentIndex = RxInt(0);

  @override
  void onInit() {
    super.onInit();

  }

  changeCurrentIndex(int i) {
    currentIndex.value = i;
    // update();
  }
}
