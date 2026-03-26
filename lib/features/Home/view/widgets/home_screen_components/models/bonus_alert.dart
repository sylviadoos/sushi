import 'package:sushi/features/Home/view/widgets/home_screen_components/wating_alert.dart';
import 'package:flutter/material.dart';

// GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void showBonusAlert(String bonus) {
  showDialog(
    context: navigatorKey.currentState!.overlay!.context,
    builder: (BuildContext context) {
      Future.delayed(Duration(seconds: 5), () {
        Navigator.of(context).pop(); // Dismiss the dialog after 4 seconds
      });
      return AlertDialog(
        title: Text('Bonus'),
        content: Text(
          'you Have A $bonus Bonuses  Earn A Bonus On Your Every Order ',
        ),
      );
    },
  );
}