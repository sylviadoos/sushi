import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:camera/camera.dart';
import 'package:sushi/Utils/notifications.dart';
import 'package:sushi/features/Home/view/widgets/home_screen_components/wating_alert.dart';
import 'package:sushi/main.dart';
import 'package:dio/src/multipart_file.dart' as multipart_file;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart' as geolocs;
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:vector_math/vector_math.dart' as vector;


geolocs.Position? previousLocation;
DateTime? lastLocationUpdateTime;
// Second waiting to Show Alert
const int waitingAlertDuration = 30; // second
// show  alert one time
bool waitingAlertShown = false;

dynamic platform;
Map<String, dynamic> userDetails = {};
dynamic heading = 0.0;
//waiting before start
dynamic waitingTime;
dynamic waitingBeforeTime;
dynamic waitingAfterTime;
dynamic arrivedTimer;
dynamic rideTimer;
bool    nearBy = false;

String currency = "\$";
AudioCache audioPlayer = AudioCache();
AudioPlayer audioPlayers = AudioPlayer();
// String audio = 'audio/notification_sound.mp3';
//calculate distance

calculateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var a = 0.5 -
      cos((lat2 - lat1) * p) / 2 +
      cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
  var val = (12742 * asin(sqrt(a))) * 1000;
  return val;
}
class AddressList {
  String address;
  LatLng latlng;
  String id;

  AddressList({required this.id, required this.address, required this.latlng});
}

String dropDistance ='';
String languageDirection = 'ltr';
//cancellation reason
List cancelReasonsList = [];
//making call to user

double duration=0.0;
bool userReject =false;
Set<Polyline> polyline = {};
const platforms = MethodChannel('flutter.app/awake');

var scrheight = 813.0;
var scrwidth = 375.0;
double eight = 0.0213;
double ten = 0.0267;
double twelve = 0.032;
double thirty = 0.08;
double fourteen = 0.0373;
double fifteen = 0.04;
double sixteen = 0.042666;
double seventeen = 0.046;
double eighteen = 0.048;
double twenty = 0.053;
double twentysix = 0.0693;
double twentyeight = 0.07466;
double twentyfour = 0.064;
double thirtysix = 0.096;
double fourty = 0.10667;
List<CameraDescription>? cameras;

Map<String, dynamic> driverReq = {};
bool isBackground = false;
String mapkey = 'AIzaSyAk-SGMMrKO6ZawG4OzaCSmJK5zAduv1NA';
String mapStyle = '';
List<LatLng> polyList = [];
String steps = '';

List<PointLatLng> decodeEncodedPolyline(String encoded,int num) {

  List<PointLatLng> poly = [];
  int index = 0, len = encoded.length;
  int lat = 0, lng = 0;

  while (index < len) {
    int b, shift = 0, result = 0;
    do {
      b = encoded.codeUnitAt(index++) - 63;
      result |= (b & 0x1f) << shift;
      shift += 5;
    } while (b >= 0x20);
    int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
    lat += dlat;

    shift = 0;
    result = 0;
    do {
      b = encoded.codeUnitAt(index++) - 63;
      result |= (b & 0x1f) << shift;
      shift += 5;
    } while (b >= 0x20);
    int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
    lng += dlng;
    LatLng p = LatLng((lat / 1E5).toDouble(), (lng / 1E5).toDouble());
    polyList.add(p);
  }
  polyline.add(Polyline(
    polylineId:  PolylineId('1'),
    visible: true,patterns: [
    PatternItem.dash(10),
    PatternItem.gap(10),
  ],
    color: num == 1? Color(0xFFFA1033):Color(0xFF3D6AFD),
    width: 4,
    points: polyList,
  ));
  valueNotifierHome.incrementNotifier();

  return poly;
}
getdurationdistance(indexTxt) async {


  String pickLat = driverReq['pick_lat$indexTxt'].toString();
  String pickLng = driverReq['pick_lng$indexTxt'].toString();
  String dropLat = driverReq['drop_lat$indexTxt'].toString();
  String dropLng = driverReq['drop_lng$indexTxt'].toString();
  if(indexTxt == '1'){
    pickLat = driverReq['drop_lat'].toString();
    pickLng = driverReq['drop_lng'].toString();
    dropLat = driverReq['drop_lat$indexTxt'].toString();
    dropLng = driverReq['drop_lng$indexTxt'].toString();
  }
  try {
    var response = await http.get(Uri.parse( 'https://maps.googleapis.com/maps/api/distancematrix/json?origins=$pickLat,$pickLng&destinations=$dropLat,$dropLng&departure_time=now&key=AIzaSyAk-SGMMrKO6ZawG4OzaCSmJK5zAduv1NA'));
    // double distanceInMeters = await    GeolocatorPlatform.instance.distanceBetween(
    //     driverReq['pick_lat'], driverReq['pick_lng'],driverReq['drop_lat'], driverReq['drop_lng']);
    //
    // var response = await http.get(Uri.parse(
    //     'https://maps.googleapis.com/maps/api/directions/json?origin=$pickLat%2C$pickLng&destination=$dropLat%2C$dropLng&avoid=ferries|indoor&transit_mode=bus&mode=driving&key=$mapkey'));
    if (response.statusCode == 200) {
      if(indexTxt == '1') { driverReq['duration1'] =
      jsonDecode(response.body)['rows'][0]['elements'][0]['duration']['text'];
      driverReq['distance_km1'] =
      jsonDecode(response.body)['rows'][0]['elements'][0]['distance']['text'];}
      else{
        driverReq['duration'] =
        jsonDecode(response.body)['rows'][0]['elements'][0]['duration']['text'];
        driverReq['distance_km'] =
        jsonDecode(response.body)['rows'][0]['elements'][0]['distance']['text'];}
    } else {
      debugPrint(response.body);
    }
    // return steps;
  } catch (e) {
    if (e is SocketException) {
      //  internet = false;
    }
  }

}
getDetailsOfDevice() async {
  driverReq['accepted_at']=1;
  print("onmess");

}
getPolylines() async {
  polyline.removeWhere((polyline) => polyline.polylineId.value == '1');

  polyList.clear();
  dropDistance = '';
  steps = '';

  String pickLat = driverReq['pick_lat'].toString();
  String pickLng = driverReq['pick_lng'].toString();
  String dropLat = driverReq['drop_lat'].toString();
  String dropLng = driverReq['drop_lng'].toString();

  try {
    var response = await http.get(Uri.parse( 'https://maps.googleapis.com/maps/api/directions/json?origin=$pickLat%2C$pickLng&destination=$dropLat%2C$dropLng&avoid=ferries|indoor&transit_mode=bus&mode=driving&key=$mapkey'));
    //
    // var response = await http.get(Uri.parse(
    print( 'https://maps.googleapis.com/maps/api/directions/json?origin=$pickLat%2C$pickLng&destination=$dropLat%2C$dropLng&avoid=ferries|indoor&transit_mode=bus&mode=driving&key=$mapkey');
    if (response.statusCode == 200) {
      steps =
      jsonDecode(response.body)['routes'][0]['overview_polyline']['points'];
      dropDistance =
      jsonDecode(response.body)['routes'][0]['legs'][0]['distance']['text'];
      polyline.clear();
      polyList.clear();
      decodeEncodedPolyline(steps,1);
    } else {
      debugPrint(response.body);
    }
    // return steps;
  } catch (e) {
    if (e is SocketException) {
      //  internet = false;
    }
  }

  return pickLat;
}
getPolylinesSecond() async {

  dropDistance = '';
  steps = '';

  String pickLat = driverReq['drop_lat'].toString();
  String pickLng = driverReq['drop_lng'].toString();
  String dropLat = driverReq['drop_lat1'].toString();
  String dropLng = driverReq['drop_lng1'].toString();

  try {
    var response = await http.get(Uri.parse( 'https://maps.googleapis.com/maps/api/directions/json?origin=$pickLat%2C$pickLng&destination=$dropLat%2C$dropLng&avoid=ferries|indoor&transit_mode=bus&mode=driving&key=$mapkey'));
    //
    // var response = await http.get(Uri.parse(
    print( 'https://maps.googleapis.com/maps/api/directions/json?origin=$pickLat%2C$pickLng&destination=$dropLat%2C$dropLng&avoid=ferries|indoor&transit_mode=bus&mode=driving&key=$mapkey');
    if (response.statusCode == 200) {
      steps =
      jsonDecode(response.body)['routes'][0]['overview_polyline']['points'];
      dropDistance =
      jsonDecode(response.body)['routes'][0]['legs'][0]['distance']['text'];
      decodeEncodedPolyline(steps,2);
    } else {
      debugPrint(response.body);
    }
    // return steps;
  } catch (e) {
    if (e is SocketException) {
      //  internet = false;
    }
  }

  return pickLat;
}

class ValueNotifyingHome {
  ValueNotifier value = ValueNotifier(0);

  void incrementNotifier() {

    value.value++;
    // duration = 15;
    // sound();
  }
}
ValueNotifyingHome valueNotifierHome = ValueNotifyingHome();

multiPartTheFile(File? img) async {
  if (img != null) {
    multipart_file.MultipartFile fileChunks =
    await multipart_file.MultipartFile.fromFile(img.path,
        filename: img.path.split('/').last);
    return fileChunks;
  } else {
    return null;
  }
}


//Firebase Function
checkState() async {
  authFCM =  await FirebaseMessaging.instance.getToken() ?? '';
  print(authFCM);
  print('authFCM');

 await http.post(
    Uri.parse("https://njsushi.com/api/admin-login-api.php"),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "username": 'admin_mobile@sendainj.com',
      "password": 'admin123',
      "fcm_token":authFCM
    }),
  );
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
}
class PointLatLng {
  /// Creates a geographical location specified in degrees [latitude] and
  /// [longitude].
  ///
  const PointLatLng(double latitude, double longitude)
  // ignore: unnecessary_null_comparison
      : assert(latitude != null),
  // ignore: unnecessary_null_comparison
        assert(longitude != null),

  // ignore: unnecessary_this, prefer_initializing_formals
        this.latitude = latitude,
  // ignore: unnecessary_this, prefer_initializing_formals
        this.longitude = longitude;

  /// The latitude in degrees.
  final double latitude;

  /// The longitude in degrees
  final double longitude;

  @override
  String toString() {
    return "lat: $latitude / longitude: $longitude";
  }


}
// double lat  =center.latitude;
// double lon =
//     center.longitude;
currentPositionUpdate() async {
  if (driverReq.isEmpty) {
    if (requestStreamStart == null ||
        requestStreamStart?.isPaused == true) {
      streamRequest();

    }
  }

}
audioPlay() async {
  audioPlayers.play(AssetSource('audio/alert.wav'));
}
double getBearing(LatLng begin, LatLng end) {
  double lat = (begin.latitude - end.latitude).abs();

  double lng = (begin.longitude - end.longitude).abs();

  if (begin.latitude < end.latitude && begin.longitude < end.longitude) {
    return vector.degrees(atan(lng / lat));
  } else if (begin.latitude >= end.latitude &&
      begin.longitude < end.longitude) {
    return (90 - vector.degrees(atan(lng / lat))) + 90;
  } else if (begin.latitude >= end.latitude &&
      begin.longitude >= end.longitude) {
    return vector.degrees(atan(lng / lat)) + 180;
  } else if (begin.latitude < end.latitude &&
      begin.longitude >= end.longitude) {
    return (90 - vector.degrees(atan(lng / lat))) + 270;
  }

  return -1;
}

//requestStream
StreamSubscription<DatabaseEvent>? requestStreamStart;
StreamSubscription<DatabaseEvent>? requestStreamEnd;
StreamSubscription<DatabaseEvent>? rideStreamStart;
StreamSubscription<DatabaseEvent>? rideStreamChanges;

streamRequest() {
  rideStreamStart?.cancel();
  rideStreamChanges?.cancel();
  requestStreamEnd?.cancel();
  requestStreamStart?.cancel();
  rideStreamStart = null;
  rideStreamChanges = null;
  requestStreamStart = null;
  requestStreamEnd = null;


}
sound() async {
  audioPlay();

  Timer.periodic(const Duration(seconds: 1), (timer) async {
    if (duration > 0.0 ) {
      duration--;

      if (audioPlayers.state == PlayerState.completed) {
        audioPlay();
      }
      valueNotifierHome.incrementNotifier();
    } else if (
        duration <= 0.0) {
      timer.cancel();
      if (audioPlayers.state != PlayerState.stopped &&
          audioPlayers.state != PlayerState.completed &&
          audioPlayers.state != PlayerState.paused &&
          audioPlayers.playerId.isNotEmpty) {
        audioPlayers.stop();
        // audioPlayers.dispose();
      }
      Future.delayed(const Duration(milliseconds: 1), () async {

      });
      duration = 0;
    } else {
      if (audioPlayers.state != PlayerState.stopped &&
          audioPlayers.state != PlayerState.completed &&
          audioPlayers.state != PlayerState.paused &&
          audioPlayers.playerId.isNotEmpty) {
        audioPlayers.stop();
        // audioPlayers.dispose();
      }
      timer.cancel();
      duration = 0;
    }
  });
}
