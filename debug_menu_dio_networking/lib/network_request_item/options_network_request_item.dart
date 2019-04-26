import 'package:debug_menu/shared/constants.dart';
import 'package:debug_menu/shared/text_item.dart';
import 'package:debug_menu_dio_networking/network_request_item/network_request_item.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class OptionsNetworkRequestItem extends NetworkRequestItem {
  OptionsNetworkRequestItem(this.options);

  /// Request options sent to the api.
  RequestOptions options;

  /// Text style for the widgets.
  final TextStyle _textStyle = Constants.defaultTextStyle();

  @override
  Widget buildItem() {
    return ExpansionTile(title: _buildTitleItem(), children: <Widget>[
      Column(children: <Widget>[
        TextItem('Headers:\n${_headerString()}', _textStyle),
      ])
    ]);
  }

  /// Builds the title widget for the expansion tile.
  Widget _buildTitleItem() {
    return Column(children: <Widget>[
      TextItem('Request: ${options.method}', _textStyle),
      TextItem('${options.baseUrl}${options.path}', _textStyle),
      TextItem('Content Type: ${options.contentType.value}', _textStyle),
    ]);
  }

  /// Driver function to convert the headers to a string.
  String _headerString() {
    return jsonString(options.headers, 0);
  }
}
