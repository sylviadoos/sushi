import 'package:sushi/Utils/Functions.dart';
import 'package:sushi/core/utils/assets_manager.dart';
import 'package:flutter/material.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void showWaitingAlert() {
  showDialog(
    context: navigatorKey.currentState!.overlay!.context,
    builder: (BuildContext context) {
      Future.delayed(Duration(seconds: 8), () {
        Navigator.of(context).pop(); // Dismiss the dialog after 8 seconds
        waitingAlertShown = false; // Set the flag to true after showing the alert
        previousLocation=null;
      });
      return AlertDialog(
        contentPadding: EdgeInsets.zero, // Remove default padding
        content: Container(
          height: 130,
          padding: EdgeInsets.all(16.0), // Add padding inside the container
          decoration: BoxDecoration(
            color: Color.fromRGBO(14, 49, 88, 1), // Set the background color to red
            borderRadius: BorderRadius.circular(15.0), // Set the border radius
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(AssetsManager.logo),
              ),
              // Icon(
              //   Icons.warning, // Choose an appropriate icon
              //   color: Colors.white, // Icon color
              //   size: 40.0, // Icon size
              // ),
              SizedBox(width: 16.0), // Space between icon and text
              Expanded(
                child: Text(
                  'Please make sure that you’re completing the order, or it will be reassigned soon.',
                  style: TextStyle(
                    color: Colors.white, // Text color
                    fontSize: 16.0, // Text size
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}