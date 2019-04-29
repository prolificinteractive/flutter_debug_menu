import 'package:debug_menu_dio_networking/network_request_item/error_network_request_item.dart';
import 'package:debug_menu_dio_networking/network_request_item/network_request_item.dart';
import 'package:debug_menu_dio_networking/network_request_item/options_network_request_item.dart';
import 'package:debug_menu_dio_networking/network_request_item/response_network_request_item.dart';
import 'package:dio/dio.dart';

class DebugMenuInterceptor extends InterceptorsWrapper {
  DebugMenuInterceptor({this.isProduction, this.requestItemList});

  /// Debug request list.
  List<NetworkRequestItem> requestItemList =
      List<NetworkRequestItem>();

  /// Flag to determine if the app is in production. Disables logging for
  /// production app.
  final bool isProduction;

  @override
  void onRequest(RequestOptions options) {
    if (!isProduction) {
      requestItemList.add(OptionsNetworkRequestItem(options));
    }
    super.onRequest(options);
  }

  @override
  // ignore: always_specify_types
  void onResponse(Response response) {
    if (!isProduction) {
      requestItemList.add(ResponseNetworkRequestItem(response));
    }
    super.onResponse(response);
  }

  @override
  void onError(DioError err) {
    if (!isProduction) {
      requestItemList.add(ErrorNetworkRequestItem(err));
    }
    super.onError(err);
  }

  /// Returns the list of the request formatter.
  List<NetworkRequestItem> getRequestFormatterList() {
    return requestItemList.reversed.toList();
  }
}
