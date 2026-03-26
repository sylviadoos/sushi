import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sushi/features/Home/view/widgets/home_screen_components/wating_alert.dart';
import 'package:sushi/firebase_options.dart';
import 'package:sushi/routes/app_pages.dart';
import 'package:sushi/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'Utils/Functions.dart';
import 'Utils/notifications.dart';
import 'core/theme/app_theme.dart';

// Screen size in density independent pixels
double screenHeight = 200;
double screenWidth = 200;
var authFCM ='';
var authPhoneFCM ='';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options:DefaultFirebaseOptions.currentPlatform,
  // );
  // if(FirebaseAuth.instance.currentUser != null){

  // }
  await GetStorage.init();




  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  @pragma('vm:entry-point')
  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();
  }

  checkState();
  currentPositionUpdate();
  initMessaging();
  getDetailsOfDevice();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // firebaseuser();

    var size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      title: 'Sushi Pizza',
      getPages: appPages(),
      initialRoute: AppRoutes.layout,

            debugShowCheckedModeBanner: false,
      theme: myAppTheme,
    );
  }


}
