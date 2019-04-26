import 'dart:ui';

import 'package:flutter/material.dart';

class Constants {

  static const double defaultPadding = 20.0;
  static const double networkActivityPadding = 16.0;

  static TextStyle defaultTextStyle() => TextStyle(color: Colors.blueGrey);

  static const String debugMenuPlatformChannel = 'debug_menu';

  static const String platformVersionMethodName = 'getPlatformVersion';
  static const String settingsMethodName = 'goToApplicationSettings';

  static const String debugMenuPackage = 'debug_menu';
}
