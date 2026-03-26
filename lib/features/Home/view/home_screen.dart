import 'package:sushi/features/Home/view/widgets/home_screen_components/bonus_icon.dart';
import 'package:sushi/features/Home/view/widgets/home_screen_components/home_screen_body.dart';
import 'package:sushi/features/Home/view/widgets/layout_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../control/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      // appBar: buildCustomAppbar('Home', color: Colors.white,),
      body: const HomeScreenBody(),
      bottomNavigationBar:
          const AppNavBar(selectedScreen: NavBarSelectedScreen.homeScreen),
    );
  }
}
