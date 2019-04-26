import 'package:debug_menu/shared/constants.dart';
import 'package:debug_menu_dio_networking/network_request_item/network_request_item.dart';
import 'package:flutter/material.dart';

class NetworkActivityScreen extends StatelessWidget {
  const NetworkActivityScreen(this._requestItemList);

  /// Network request list.
  final List<NetworkRequestItem> _requestItemList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Network Activity')),
        body: Padding(
            padding: const EdgeInsets.only(
                top: Constants.networkActivityPadding,
                bottom: Constants.networkActivityPadding),
            child: Container(
                child: ListView.builder(
              itemCount: _requestItemList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                    padding: const EdgeInsets.only(
                        left: Constants.networkActivityPadding,
                        right: Constants.networkActivityPadding),
                    child: _requestItemList[index].buildItem());
              },
            ))));
  }
}
