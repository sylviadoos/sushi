import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sushi/core/utils/app_colors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:open_filex/open_filex.dart';
import 'package:open_settings_plus/open_settings_plus.dart' as openplus;
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart' as perm;
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';

import '../../../../../Utils/Functions.dart';
import '../../../../../Utils/Loading.dart';
import '../../../../../Utils/geohash.dart';
import '../../../../../Utils/notifications.dart';
import '../../../../../core/theme/StarRating.dart';

final userLoginData = GetStorage();

class Maps extends StatefulWidget {
  const Maps({Key? key}) : super(key: key);

  @override
  State<Maps> createState() => _MapsState();
}

bool locationAllowed = false;

Set<Circle> circles = {};

dynamic _timer;
String cancelReasonText = '';
bool notifyCompleted = false;
bool logout = false;
bool deleteAccount = false;
bool getStartOtp = false;
String driverOtp = '';
bool serviceEnabled = false;
bool show = true;
int filtericon = 0;

class _MapsState extends State<Maps>
    with WidgetsBindingObserver, TickerProviderStateMixin{
  List driverData = [];
  InAppWebViewController? _webViewController;
  late PullToRefreshController _pullToRefreshController;
  bool sosLoaded = false;
  bool cancelRequest = false;

  bool isChecked = false;



  String state = '';
  Animation<double>? _animation;
  dynamic animationController;
  double mapPadding = 0.0;

  int gettingPerm = 0;
  dynamic loc;
  bool showSos = false;
  bool _isLoading = false;
  dynamic pinLocationIcon;
  dynamic pinLocationIcon2;
  dynamic userLocationIcon;
  bool makeOnline = false;
  bool contactus = false;

  bool checkOne = false;

  bool checkTwo = false;





  bool permissionCamera=false;
  bool permissionLocation=false;
  bool permissionNotification=false;
  bool isShowDialog=false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();


    _pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue, // Refresh indicator color
      ),
      onRefresh: () async {
        if (_webViewController != null) {
          if (_webViewController != null) {
            _webViewController!.reload();
          } else {
            // fallback: reload the initial URL
            _webViewController!.loadUrl(
              urlRequest: URLRequest(
                url: WebUri("https://njsushi.com/admin/login"),
              ),
            );
          }
        }
      },
    );

  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {


      FirebaseMessaging.instance.getInitialMessage().then((value) {
        print('onMessage.li11');


        if (value?.data != null) {
          if (value?.data['push_type'] == 'general') {
            latestNotification = value?.data['message'];
            isGeneral = true;
            valueNotifierHome.incrementNotifier();
          }
        }
      });

      isBackground = false;
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      isBackground = true;
    }
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer.cancel();
    }


    animationController?.dispose();
    // WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  int _bottom = 0;


  @override
  Widget build(BuildContext context) {
    var media = MediaQuery
        .of(context)
        .size;

    return WillPopScope(
      onWillPop: () async {
        if (_webViewController != null) {
          bool canGoBack = await _webViewController!.canGoBack();
          if (canGoBack) {
            _webViewController!.goBack();
            return false; // stay in the app
          }
        }
        return true; // exit the app
      },
      child: Material(
        child: ValueListenableBuilder(
            valueListenable: valueNotifierHome.value,
            builder: (context, value, child) {



              return Directionality(
                textDirection: TextDirection.ltr,
                child: Scaffold(
                  extendBody: true,
                  extendBodyBehindAppBar: true,
                  body: StreamBuilder(
                      stream: null,
                      builder: (context, AsyncSnapshot<DatabaseEvent> event) {

                        return Stack(
                          children: [
                            Container(
                              color: page,
                              height: media.height * 1,
                              width: media.width ,
                              child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Stack(
                                          alignment:
                                          Alignment.center,
                                          children: [
                                            Container(
                                                width:MediaQuery.sizeOf(context).width,height: MediaQuery.sizeOf(context).height,
                                                child: InAppWebView(
                                                  initialUrlRequest: URLRequest(
                                                    url: WebUri("https://njsushi.com/admin/login"),
                                                  ),
                                                  onWebViewCreated: (controller) {
                                                    _webViewController = controller;
                                                    controller.addJavaScriptHandler(
                                                        handlerName: "openPdf",
                                                        callback: (args) async {
                                                          String pdfBase64 = args[0].toString();

                                                          // Remove prefix like "data:application/pdf;base64,"
                                                          pdfBase64 = pdfBase64.replaceFirst(RegExp(r'data:application/pdf;.*base64,'), "");

                                                          // Convert to bytes
                                                          Uint8List pdfBytes = base64Decode(pdfBase64);

                                                          // Option 1: Save and open using Flutter PDF viewer plugin
                                                          final dir = await getTemporaryDirectory();
                                                          final file = File("${dir.path}/generated.pdf");
                                                          await file.writeAsBytes(pdfBytes);
                                                          await Printing.layoutPdf(
                                                            onLayout: (_) async => file.readAsBytes(),
                                                          );
                                                          // Use open_filex or any PDF viewer
                                                         // await OpenFilex.open(file.path);
                          });},

                                                  pullToRefreshController: _pullToRefreshController,
                                                  onLoadStop: (controller, url) async {
                                                    _pullToRefreshController.endRefreshing();
                                                  },
                                                  onLoadError: (controller, url, code, message) {
                                                    _pullToRefreshController.endRefreshing();
                                                  },
                                                )),
                                            //request popup accept or reject
                                            Positioned(
                                                bottom: 30,
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .end,
                                                  children: [

                                                    const SizedBox(
                                                        height: 20),
                                                    SizedBox(
                                                        height: media
                                                            .width *
                                                            0.25),


                                                    (driverReq['accepted_at'] ==
                                                        null)
                                                        ? Column(
                                                      children: [

                                                        Container(
                                                            padding: const EdgeInsets
                                                                .fromLTRB(0, 0, 0,
                                                                0),
                                                            width: media.width *
                                                                0.9,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: AppColors
                                                                        .borderPopupColor,
                                                                    width: 2),

                                                                borderRadius: BorderRadius
                                                                    .circular(15),
                                                                color: AppColors
                                                                    .fillAccentGreyColor,
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                      blurRadius: 2,
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                          0.2),
                                                                      spreadRadius: 2)
                                                                ]),
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment
                                                                  .start,
                                                              mainAxisAlignment: MainAxisAlignment
                                                                  .spaceBetween,
                                                              children: [
                                                                (duration != 0)

                                                                    ? AnimatedContainer(
                                                                  duration: const Duration(
                                                                      milliseconds: 100),
                                                                  height: 10,
                                                                  width: (media
                                                                      .width *
                                                                      0.9 / 1500) *
                                                                      (1500 -
                                                                          duration),
                                                                  decoration: BoxDecoration(
                                                                      color:
                                                                      Color(
                                                                          0xFF27AD1D)
                                                                      ,
                                                                      borderRadius: BorderRadius
                                                                          .all(
                                                                          Radius
                                                                              .circular(
                                                                              20)
                                                                      )),
                                                                )
                                                                    : Container(),
                                                                Padding(
                                                                  padding: const EdgeInsets.all(8.0),
                                                                  child: Text(
                                                                    'You have a new Order click to stop alert',
                                                                    textAlign: TextAlign
                                                                        .center,style: TextStyle(
                                                                      fontWeight: FontWeight.bold,fontSize: 15
                                                                  ),
                                                                  ),
                                                                ),
                                                                SizedBox(height: 20,),

                                                                GestureDetector(
                                                                  onTap: (){
                                                                    driverReq['accepted_at'] =1;
                                                                    duration =0;
                                                                    _webViewController?.loadUrl(
                                                                      urlRequest: URLRequest(
                                                                        url: WebUri("https://njsushi.com/admin/orders/${userLoginData.read("order_id")}"),
                                                                      ),
                                                                    );
                                                                    userLoginData.write("order_id", "0");

                                                                    setState(() {

                                                                    });
                                                                  },
                                                                  child: Center(
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: Container(
                                                                        width: media
                                                                            .width * 0.5,height: 30,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius
                                                                                .circular(
                                                                                20),
                                                                            color: AppColors
                                                                                .lightButtonColor,
                                                                            boxShadow: const [
                                                                              BoxShadow(
                                                                                  color: Colors
                                                                                      .black26,
                                                                                  blurRadius: 5,
                                                                                  spreadRadius: 0.2)
                                                                            ]),
                                                                        child: Padding(
                                                                            padding: const EdgeInsets
                                                                                .all(3.0),
                                                                            child: Center(
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment
                                                                                      .center,
                                                                                  children: [
                                                                                    Text(
                                                                                      'Show order',
                                                                                      textAlign: TextAlign
                                                                                          .center,style: TextStyle(color: Colors.white),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: media
                                                                                          .width *
                                                                                          0.02,
                                                                                    ),

                                                                                  ],
                                                                                ))),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),

                                                              ],
                                                            )),
                                                      ],
                                                    )
                                                        : (driverReq['accepted_at'] !=
                                                        null)
                                                        ? SizedBox(
                                                      width: media.width * 0.9,
                                                      height: media.width * 0.7,
                                                    )
                                                        : Container(
                                                        width: media.width * 0.9)

                                                  ],
                                                )),



                                          ],
                                        ),
                                      ),
                                    )

                                  ]),
                            ),

                            (_isLoading == true)
                                ? const Positioned(top: 0, child: Loading())
                                : Container(),
                            //pickup marker

                          ],
                        );
                      }

                  ),


                ),
              );
            }

        ),
      ),
    );
  }


}

