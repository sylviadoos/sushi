import 'package:flutter/services.dart';

class DeveloperModeCheck {
  static const platform = MethodChannel('com.example.developer_mode/check');

  // Function to check if developer mode is enabled
  static Future<bool> isDeveloperModeEnabled() async {
    try {
      final bool isDeveloperModeEnabled = await platform.invokeMethod('checkDeveloperMode');
      return isDeveloperModeEnabled;
    } on PlatformException catch (e) {
      print("Failed to check developer mode: '${e.message}'.");
      return false;
    }
  }
}