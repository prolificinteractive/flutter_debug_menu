import 'package:flutter/material.dart';

abstract class NetworkRequestItem {
  /// Builds the network request item.
  Widget buildItem();

  /// Converts a json return object to a String.
  String jsonString(dynamic data, int level) {
    if (data is Map<String, dynamic>) {
      return mapToString(data, level);
    } else if (data is List<dynamic>) {
      return listToString(data, level);
    }
  }

  /// Converts a map of <String, dynamic> to a String.
  String mapToString(Map<String, dynamic> map, int level) {
    if (map.isEmpty) {
      return '';
    }
    String mapString = '${tabString(level)}{\n';

    for (int i = 0; i < map.length; i++) {
      final String key = map.keys.elementAt(i);
      final dynamic value = map.values.elementAt(i);

      if (value is Map<String, dynamic>) {
        mapString +=
            '${tabString(level + 1)}$key : \n${mapToString(value, level + 1)}';
      } else {
        mapString += '${tabString(level + 1)}$key : ${value.toString()},';
      }
      mapString += '\n';
    }
    mapString += '${tabString(level)}}';
    return mapString;
  }

  /// Converts a list of dynamic to a String.
  String listToString(List<dynamic> data, int level) {
    if (data.isEmpty) {
      return '';
    }
    String listString = '${tabString(level)}[\n';
    for (int i = 0; i < data.length; i++) {
      listString += '${jsonString(data[i], level + 1)},\n';
    }
    listString += '${tabString(level)}\n]';
    return listString;
  }

  /// Returns a string with tabs.
  String tabString(int level) {
    String tabs = '';
    for (int j = 0; j < level; j++) {
      tabs += '    ';
    }
    return tabs;
  }
}
