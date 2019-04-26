import 'package:debug_menu/shared/constants.dart';
import 'package:debug_menu/shared/text_item.dart';
import 'package:debug_menu_dio_networking/network_request_item/network_request_item.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ResponseNetworkRequestItem extends NetworkRequestItem {
  ResponseNetworkRequestItem(this.response);

  /// Network response.
  // ignore: always_specify_types
  Response response;

  /// Text style for the widgets.
  final TextStyle _textStyle =
      Constants.defaultTextStyle().copyWith(color: Colors.green);

  @override
  Widget buildItem() {
    return ExpansionTile(title: _buildTitleItem(), children: <Widget>[
      Column(children: <Widget>[
        TextItem('Headers:\n${_headerString()}', _textStyle),
        TextItem('Data:\n${_responseDataString()}', _textStyle),
      ])
    ]);
  }

  /// Builds the title widget for the expansion tile.
  Widget _buildTitleItem() {
    return Column(children: <Widget>[
      TextItem('Request: ${response.request.method}', _textStyle),
      TextItem(
          '${response.request.baseUrl}${response.request.path}', _textStyle),
      TextItem('Status Code: ${response.statusCode}', _textStyle),
      TextItem(
          'Content Type: ${response.request.contentType.value}', _textStyle),
    ]);
  }

  /// Driver function to convert the headers to a string.
  String _headerString() {
    return jsonString(response.request.headers, 0);
  }

  /// Driver function to convert the response data to a string.
  String _responseDataString() {
    return jsonString(response.data, 0);
  }
}
