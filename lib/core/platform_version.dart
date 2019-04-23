import 'dart:async';

import 'package:debug_menu/shared/constants.dart';
import 'package:flutter/services.dart';

class PlatformVersion {
  static const MethodChannel _channel =
      const MethodChannel(Constants.debugMenuPlatformChannel);

  static Future<String> get platformVersion async {
    final String version =
        await _channel.invokeMethod(Constants.platformVersionMethodName);
    return version;
  }
}
