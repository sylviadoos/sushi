import 'package:get/get.dart';

import '../features/Home/control/home_controller.dart';
import '../features/Home/view/home_screen.dart';
import '../features/Home/view/widgets/home_screen_components/map_page.dart';
import 'app_routes.dart';

appPages() => [


      GetPage(
        name: AppRoutes.layout,
        page: () =>  Maps(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: const Duration(milliseconds: 500),
        binding: BindingsBuilder(() {
          Get.lazyPut<HomeController>(
            () => HomeController(),
          );

        }),
      ),

    ];
