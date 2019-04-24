import 'dart:async';

import 'package:debug_menu/shared/constants.dart';
import 'package:flutter/services.dart';

class PlatformVersion {
  static const MethodChannel _channel =
      const MethodChannel(Constants.debugMenuPlatformChannel);

  static Future<String> get platformVersion async {
    Map result = {};
    result = await _channel.invokeMethod(Constants.platformVersionMethodName);
    var platform = result["Platform"];
    var version = result["Version"];
    var versionString = platform + " " + version;
    return versionString;
  }
}
