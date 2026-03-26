import 'dart:async';

import 'package:sushi/core/utils/assets_manager.dart';
import 'package:sushi/features/Home/view/widgets/home_screen_components/models/bonus_alert.dart';
import 'package:sushi/features/Home/view/widgets/home_screen_components/wating_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../../../main.dart';

class BonusItem extends StatefulWidget {
  const BonusItem({Key? key}) : super(key: key);

  @override
  State<BonusItem> createState() => _BonusItemState();
}

class _BonusItemState extends State<BonusItem> {
  late DatabaseReference _bonusRef;
  late StreamSubscription<DatabaseEvent> _bonusSubscription;
  String bonus = "";
  String bonusDate = "";
  // String authFCM ='';
  void getAuthFCM() async {
    try {
      // var authFCM = await FirebaseAuth.instance.currentUser!.uid;
      _bonusRef = FirebaseDatabase.instance.reference().child('drivers/$authFCM');
      _bonusSubscription = _bonusRef.onValue.listen((DatabaseEvent event) {
        DataSnapshot snapshot = event.snapshot;
        if (snapshot.value != null && snapshot.value is Map<dynamic, dynamic>) {
          Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
          setState(() {
            bonus = data['bonus']?.toString() ?? "0";
            bonusDate = data['bonus_date']?.toString() ?? "";
          });
        } else {
          print("Invalid data structure received from Firebase: ${snapshot.value}");
        }
      });
    } catch (error) {
      print("Error fetching bonus data: $error");
    }
  }
  @override
  void initState() {
    super.initState();
    getAuthFCM();
  }

  @override
  void dispose() {
    super.dispose();
    _bonusSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return bonus != "" &&
        bonusDate != "" &&
        isDateBeforeCurrentDate(bonusDate) == false
        ? InkWell(
      onTap: (){
        showBonusAlert(bonus);
      },
          child: Stack(
           children: [
          Image.asset(AssetsManager.bonusBell,color: Colors.blue,),
          Positioned(
            bottom: 5,
            top: 0,
            left: 0,
            right: 0,
            child: Center(child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment:
              MainAxisAlignment.center,
              children: [
                Text("\$$bonus",style: TextStyle(color: Colors.white,fontSize: 9),),
              ],
            )),
          )
                ],
              ),
        )
        : Container();
  }

  bool isDateBeforeCurrentDate(String dateISOString) {
    DateTime givenDate = DateTime.parse(dateISOString);
    DateTime currentDate = DateTime.now();
    return givenDate.isBefore(currentDate);
  }
}