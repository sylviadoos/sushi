import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import '../features/Home/view/widgets/home_screen_components/map_page.dart';
import 'Functions.dart';

// create an instance
FirebaseMessaging messaging = FirebaseMessaging.instance;
FlutterLocalNotificationsPlugin fltNotification =
FlutterLocalNotificationsPlugin();
FlutterLocalNotificationsPlugin rideNotification =
FlutterLocalNotificationsPlugin();
bool isGeneral = false;
String latestNotification = '';
int id = 0;

void notificationTapBackground(NotificationResponse notificationResponse) {
  print('onMessage.li2');

  isGeneral = true;
  duration = 1500;
  sound();
  driverReq['accepted_at'] =null;
  valueNotifierHome.incrementNotifier();
}

var androidDetails = const AndroidNotificationDetails(
  'high_importance_channel',
  'High Importance Notifications',
  channelDescription: 'High importance notification channel',
  enableVibration: true,
  enableLights: true,
  importance: Importance.high,
  playSound: true,
  sound: RawResourceAndroidNotificationSound('alert'),
  priority: Priority.high,
  visibility: NotificationVisibility.private,
);

const iosDetails = DarwinNotificationDetails(
    presentAlert: true, presentBadge: true, presentSound: true, sound: 'alert.wav');

var generalNotificationDetails =
NotificationDetails(android: androidDetails, iOS: iosDetails);

var androiInit =
const AndroidInitializationSettings('@drawable/logo'); //for logo
var iosInit = const DarwinInitializationSettings(
  defaultPresentAlert: true,
  defaultPresentBadge: true,
  defaultPresentSound: true,
);
var initSetting = InitializationSettings(android: androiInit, iOS: iosInit);

Future<void> initMessaging() async {
  await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
    provisional: false,
  );

  await fltNotification.initialize(
    initSetting,
    onDidReceiveNotificationResponse: notificationTapBackground,
    onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
  );

  FirebaseMessaging.instance.getInitialMessage().then((message) {
    print('onMessage.li4');
    print(message?.data.toString());

    if(message?.data != null){
      print(message?.data.toString());
      print(message?.data['order_id'].toString());
      userLoginData.write("order_id", message?.data['order_id'].toString());

      // _showGeneralNotification(message?.data);
    duration = 1500;
    sound();
    driverReq['accepted_at'] =null;
    valueNotifierHome.incrementNotifier();
    isGeneral = true;}
    if (message?.data != null) {
      if (message?.data['push_type'] == 'general') {
        latestNotification = message?.data['message'];
        isGeneral = true;
        duration = 1500;
        sound();
        driverReq['accepted_at'] =null;
        valueNotifierHome.incrementNotifier();
      }
    }
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    print('onMessage.li');
    if(message?.data != null) {
      print(message?.data.toString());
      print(message?.data['order_id'].toString());
      userLoginData.write("order_id", message?.data['order_id'].toString());
    }
    //_showGeneralNotification(message.data);
    duration = 1500;
    sound();
    driverReq['accepted_at'] =null;
    valueNotifierHome.incrementNotifier();
    isGeneral = true;
    RemoteNotification? notification = message.notification;
    if (notification != null) {
      if (message.data['push_type'].toString() == 'general') {
        latestNotification = message.data['message'];
        if (message.data['image'].isNotEmpty) {
          _showBigPictureNotificationURLGeneral(message.data);
        } else {
          _showGeneralNotification(message.data);
        }
      } else {
        _showRideNotification(message.notification);
      }
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('onMessage.li1');

    print(message?.data['order_id'].toString());
    userLoginData.write("order_id", message?.data['order_id'].toString());
   // _showGeneralNotification(message.data);
    print(message);
    duration = 1500;
    sound();
    driverReq['accepted_at'] =null;
    valueNotifierHome.incrementNotifier();
    isGeneral = true;
    if (message.data['push_type'].toString() == 'general') {
      latestNotification = message.data['message'];
      isGeneral = true;
      duration = 1500;
      sound();
      driverReq['accepted_at'] =null;
      valueNotifierHome.incrementNotifier();
    }
  });

}

@pragma('vm:entry-point') // important!
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Save data payload into SharedPreferences
  print('onMessage.li7');

  if (message.data.isNotEmpty) {

    await GetStorage.init();
    final userLoginData = GetStorage();
    print(message?.data['order_id'].toString());
    userLoginData.write("order_id", message?.data['order_id'].toString());
    print(userLoginData.read("order_id"));

    driverReq['accepted_at'] =null;
    valueNotifierHome.incrementNotifier();  }
}
Future<String> _downloadAndSaveFile(String url, String fileName) async {
  final Directory directory = await getApplicationDocumentsDirectory();
  final String filePath = '${directory.path}/$fileName';
  final http.Response response = await http.get(Uri.parse(url));
  final File file = File(filePath);
  await file.writeAsBytes(response.bodyBytes);
  return filePath;
}

Future<Uint8List> _getByteArrayFromUrl(String url) async {
  final http.Response response = await http.get(Uri.parse(url));
  return response.bodyBytes;
}

Future<void> _showBigPictureNotificationURLGeneral(message) async {
  latestNotification = message['message'];
  if (platform == TargetPlatform.android) {
    final ByteArrayAndroidBitmap bigPicture =
    ByteArrayAndroidBitmap(await _getByteArrayFromUrl(message['image']));
    final BigPictureStyleInformation bigPictureStyleInformation =
    BigPictureStyleInformation(bigPicture);
    final AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'High importance notification channel',
      styleInformation: bigPictureStyleInformation,
      enableVibration: true,
      enableLights: true,
      importance: Importance.high,
      playSound: true,
      sound: const RawResourceAndroidNotificationSound('alert'),
      priority: Priority.high,
      visibility: NotificationVisibility.public,
    );
    final NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
    fltNotification.initialize(initSetting,
        onDidReceiveNotificationResponse: notificationTapBackground,
        onDidReceiveBackgroundNotificationResponse: notificationTapBackground);
    await fltNotification.show(
        id++, message['title'], message['message'], notificationDetails);
  } else {
    final String bigPicturePath = await _downloadAndSaveFile(
        Uri.parse(message['image']).toString(), 'bigPicture.jpg');
    final DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
        attachments: <DarwinNotificationAttachment>[
          DarwinNotificationAttachment(
            bigPicturePath,
          )
        ]);

    final NotificationDetails notificationDetails =
    NotificationDetails(iOS: iosDetails);
    fltNotification.initialize(initSetting,
        onDidReceiveNotificationResponse: notificationTapBackground,
        onDidReceiveBackgroundNotificationResponse: notificationTapBackground);
    await fltNotification.show(
        id++, message['title'], message['message'], notificationDetails);
  }
  id = id++;
}

Future<void> _showGeneralNotification(message) async {
  print(message.toString()+'hhhhsss');


  const AndroidNotificationDetails androidNotificationDetails =
  AndroidNotificationDetails(
    'high_importance_channel',
    'High Importance Notifications',
    channelDescription: 'High importance notification channel',
    enableVibration: true,
    enableLights: true,
    importance: Importance.high,
    playSound: true,
    sound: RawResourceAndroidNotificationSound('alert'),
    priority: Priority.high,
    visibility: NotificationVisibility.public,
  );
  const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true, presentBadge: true, presentSound: true, sound: 'alert.wav');
  const NotificationDetails notificationDetails =
  NotificationDetails(android: androidNotificationDetails, iOS: iosDetails);
  fltNotification.initialize(initSetting,
      onDidReceiveNotificationResponse: notificationTapBackground,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground);
  await fltNotification.show(
      id++, message?['title'], message?['message'], notificationDetails);
  id = id++;

}

Future<void> _showRideNotification(message) async {
  const AndroidNotificationDetails androidNotificationDetails =
  AndroidNotificationDetails(
    'high_importance_channel',
    'High Importance Notifications',
    channelDescription: 'High importance notification channel',
    enableVibration: true,
    enableLights: true,
    importance: Importance.high,
    playSound: true,
    sound: RawResourceAndroidNotificationSound('alert'),
    priority: Priority.high,
    visibility: NotificationVisibility.public,
  );
  const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
    sound: 'alert.wav',
  );
  const NotificationDetails notificationDetails =
  NotificationDetails(android: androidNotificationDetails, iOS: iosDetails);
  rideNotification.initialize(initSetting);
  await rideNotification.show(id++, message.title.toString(),
      message.body.toString(), notificationDetails);
  id = id++;
}