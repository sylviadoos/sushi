import 'package:sushi/features/Home/view/widgets/home_screen_components/welcome_home_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../main.dart';
import '../../../control/home_controller.dart';
import 'home_list.dart';
import 'home_taps.dart';

class HomeScreenBody extends GetView<HomeController> {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
           WelcomeHomeWidget(),
          // SizedBox(
          //   height:screenHeight * 0.03,
          // ),
          // const Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 8.0),
          //   child: HomeScreenTaps(),
          // ),
          SizedBox(
            height:screenHeight * 0.03,
          ),
          const HomeList(),
        ],
      ),
    );
  }
}
