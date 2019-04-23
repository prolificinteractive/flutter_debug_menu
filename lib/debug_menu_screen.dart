import 'dart:async';

import 'package:debug_menu/core/platform_version.dart';
import 'package:debug_menu/menu_actions/menu_action.dart';
import 'package:debug_menu/menu_actions/multi_menu_action.dart';
import 'package:debug_menu/menu_actions/single_menu_action.dart';
import 'package:debug_menu/menu_actions/toggle_menu_action.dart';
import 'package:debug_menu/network_activity/debug_menu_interceptor.dart';
import 'package:debug_menu/network_activity/network_activity_screen.dart';
import 'package:debug_menu/network_activity/network_request_item/network_request_item.dart';
import 'package:debug_menu/settings_action.dart';
import 'package:debug_menu/shared/constants.dart';
import 'package:debug_menu/shared/text_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';

///This widget holds the debug menu UI and logic
class DebugMenuScreen extends StatefulWidget {
  const DebugMenuScreen(this._title, this._actions, this._onBackPressed,
      this._logNetworkRequests);

  /// Title of the application.
  final String _title;

  /// Menu action items to present.
  final List<MenuAction> _actions;

  /// Called when the back button is pressed.
  final VoidCallback _onBackPressed;

  /// Flag to determine if network requests should be logged.
  final bool _logNetworkRequests;

  @override
  State<StatefulWidget> createState() => _DebugMenuScreenState(
      _title, _actions, _onBackPressed, _logNetworkRequests);
}

class _DebugMenuScreenState extends State<DebugMenuScreen> {
  _DebugMenuScreenState(this._title, this._actions, this._onBackPressed,
      this._logNetworkRequests) {
    _getApplicationInfo();
    _getPlatformVersion();
  }

  /// Title of the application.
  final String _title;

  /// Menu action items to present.
  List<MenuAction> _actions;

  /// Called when the back button is pressed.
  final VoidCallback _onBackPressed;

  /// Flag to determine if network requests should be logged.
  final bool _logNetworkRequests;

  /// Application information.
  String _packageName = '';
  String _version = '';
  String _buildNumber = '';
  String _platformVersion = '';

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(_title),
        actions: <Widget>[
          FlatButton(
            child: const Text('Back', textAlign: TextAlign.center),
            onPressed: _onBackPressed,
          )
        ],
      ),
      body: ListView.builder(
        itemCount: _actions.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return _buildHeaderItem();
          } else {
            final int updatedIndex = index - 1;
            return _buildMenuItem(_actions[updatedIndex], updatedIndex);
          }
        },
      ),
    ));
  }

  /// Build the header widget.
  Widget _buildHeaderItem() {
    const double marginPadding = 16;
    return Container(
        child: Padding(
            padding: const EdgeInsets.only(
                top: Constants.defaultPadding,
                bottom: Constants.defaultPadding,
                left: marginPadding,
                right: marginPadding),
            child: Column(children: <Widget>[
              const TextItem('Application Information',
                  TextStyle(fontSize: 22, color: Colors.black)),
              TextItem(
                  'Package Name', Constants.defaultTextStyle(), _packageName),
              TextItem('Version: ', Constants.defaultTextStyle(), _version),
              TextItem(
                  'Build Number: ', Constants.defaultTextStyle(), _buildNumber),
              TextItem('Platform Version: ', Constants.defaultTextStyle(),
                  _platformVersion),
              _networkActivityItem(),
            ])));
  }

  /// Widget for the network activity button.
  Widget _networkActivityItem() {
    if (_logNetworkRequests) {
      return Row(children: <Widget>[
        Expanded(
            child: FlatButton(
          child: const Text('View Network Activity', textAlign: TextAlign.left),
          color: Colors.blueGrey[400],
          textColor: Colors.white,
          onPressed: _routeToNetworkActivityScreen,
        ))
      ]);
    } else {
      return Container();
    }
  }

  /// Routes to the network activity screen.
  void _routeToNetworkActivityScreen() {
    final List<NetworkRequestItem> requestFormatterList =
        DebugMenuInterceptor.getRequestFormatterList();
    Navigator.push(
        context,
        MaterialPageRoute<void>(
            builder: (BuildContext context) =>
                NetworkActivityScreen(requestFormatterList)));
  }

  /// Build the menu item list based on the action and the index.
  Widget _buildMenuItem(MenuAction action, int index) {
    if (action is ToggleMenuAction) {
      return _toggleMenuItem(action, index);
    } else if (action is MultiMenuAction) {
      return _multiMenuItem(action, index);
    } else if (action is SingleMenuAction) {
      return _singleMenuItem(action);
    } else {
      return Container();
    }
  }

  /// Toggle menu item type allows for the selection of an item.
  Widget _toggleMenuItem(ToggleMenuAction action, int index) {
    return InkWell(
        onTap: () => _itemSelected(action, index),
        child: Column(children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(Constants.defaultPadding),
              child: Row(
                children: <Widget>[
                  Expanded(child: _textItem(action)),
                  _checkImageItem(action.selected)
                ],
              ))
        ]));
  }

  /// Multi menu item type allows the expansion of the sub-actions.
  Widget _multiMenuItem(MultiMenuAction action, int index) {
    if (action.subActions.isEmpty) {
      return ListTile(title: _textItem(action));
    } else {
      return ExpansionTile(
        key: PageStorageKey<MultiMenuAction>(action),
        title: _textItem(action),
        children: action.subActions
            .map((MenuAction action) => _buildMenuItem(action, index))
            .toList(),
      );
    }
  }

  /// Single menu item type.
  Widget _singleMenuItem(SingleMenuAction action) {
    return InkWell(
        onTap: action.actionSelected,
        child: Column(children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(Constants.defaultPadding),
              child: Row(
                children: <Widget>[
                  Expanded(child: _textItem(action)),
                ],
              ))
        ]));
  }

  /// Display text widget.
  Widget _textItem(MenuAction action) {
    return Column(
        children: <Widget>[_titleWidget(action), _descriptionWidget(action)]);
  }

  /// Widget for the title.
  Widget _titleWidget(MenuAction action) {
    return Row(children: <Widget>[
      Text(action.title, style: const TextStyle(color: Colors.black))
    ]);
  }

  /// Widget for the description.
  Widget _descriptionWidget(MenuAction action) {
    if (action.description != null) {
      return Row(children: <Widget>[
        Text(
          action.description,
          textScaleFactor: 0.75,
          style: const TextStyle(color: Colors.blueGrey),
        )
      ]);
    } else {
      return Container();
    }
  }

  /// Check image for the toggleable menu actions.
  Widget _checkImageItem(bool selected) {
    const String rootPath = 'lib/assets';
    if (selected) {
      return Image.asset('$rootPath/check_circle/check_circle.png',
          package: Constants.debugMenuPackage, fit: BoxFit.fitWidth);
    } else {
      return Image.asset(
          '$rootPath/check_circle_outline/check_circle_outline.png',
          package: Constants.debugMenuPackage,
          fit: BoxFit.fitWidth);
    }
  }

  /// Updates the selected item and updates the ui.
  void _itemSelected(ToggleMenuAction selectedAction, int index) {
    final MenuAction selectedParentMenuAction = _actions[index];
    if (selectedParentMenuAction is MultiMenuAction) {
      selectedParentMenuAction.subActionSelected(selectedAction);
    } else if (selectedParentMenuAction is ToggleMenuAction) {
      selectedParentMenuAction.actionSelected();
    }
    setState(() {
      _actions = _actions;
    });
  }

  /// Gets the application info for the header.
  Future<void> _getApplicationInfo() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();

    setState(() {
      _packageName = '\n${packageInfo.packageName ?? ''}';
      _version = '${packageInfo.version ?? ''}';
      _buildNumber = '${packageInfo.buildNumber ?? ''}';
    });
  }

  /// Gets the platform version for the header.
  Future<void> _getPlatformVersion() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await PlatformVersion.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }
}
