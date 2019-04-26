import 'package:debug_menu_dio_networking/interceptor/debug_menu_interceptor.dart';
import 'package:debug_menu_dio_networking/network_request_item/network_request_item.dart';
import 'package:debug_menu_dio_networking/screen/network_activity_screen.dart';
import 'package:flutter/material.dart';

class NetworkActivity {
  /// Routes to the network activity screen.
  static Widget provideNetworkActivityScreen() {
    final List<NetworkRequestItem> requestFormatterList =
        DebugMenuInterceptor.getRequestFormatterList();
    return NetworkActivityScreen(requestFormatterList);
  }
}
