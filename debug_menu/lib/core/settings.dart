import 'dart:async';

import 'package:debug_menu/shared/constants.dart';
import 'package:flutter/services.dart';

class Settings {
  static const MethodChannel _channel =
      const MethodChannel(Constants.debugMenuPlatformChannel);

  static Future<void> openApplicationSettings() async {
    String result;
    try {
      result = await _channel.invokeMethod(Constants.settingsMethodName);
      if (result == "Cannot open settings") {
        throw Exception("Cannot open settings");
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }
}
