import 'dart:async';

import 'package:debug_menu/shared/constants.dart';
import 'package:flutter/services.dart';

class Settings {
  static const MethodChannel _channel =
      const MethodChannel(Constants.debugMenuPlatformChannel);

  static Future<void> openApplicationSettings() async {
    try {
      await _channel.invokeMethod(Constants.settingsMethodName);
    } on PlatformException catch (e) {
      print(e);
    }
  }
}
