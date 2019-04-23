import 'dart:async';

import 'package:flutter/services.dart';

class PlatformVersion {
  static const MethodChannel _channel =
      const MethodChannel('platform_version');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
