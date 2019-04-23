import 'package:debug_menu/network_activity/network_request_item/network_request_item.dart';
import 'package:debug_menu/shared/constants.dart';
import 'package:debug_menu/shared/text_item.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ErrorNetworkRequestItem extends NetworkRequestItem {
  ErrorNetworkRequestItem(this._error);

  /// Network error returned from the api.
  DioError _error;

  @override
  Widget buildItem() {
    final TextStyle textStyle =
        Constants.defaultTextStyle().copyWith(color: Colors.red);

    return Column(
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.only(
                left: Constants.networkActivityPadding,
                right: Constants.networkActivityPadding),
            child: TextItem('Error: ${_error.toString()}', textStyle))
      ],
    );
  }
}
