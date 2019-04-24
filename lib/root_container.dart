import 'package:debug_menu/debug_menu_screen.dart';
import 'package:debug_menu/gesture_type.dart';
import 'package:debug_menu/menu_actions/menu_action.dart';
import 'package:flutter/material.dart';

///This class wraps the top level widget in order to provide debug functionality to the applicationn
class RootDebugContainer extends StatefulWidget {
  const RootDebugContainer(
      {@required this.child,
      @required this.title,
      @required this.menuActions,
      @required this.isProduction,
      this.gestureType = GestureType.doubleTap,
      this.logNetworkRequests = true});

  /// Root widget of the application.
  final Widget child;

  /// Title of the application.
  final String title;

  /// Menu action items to present.
  final List<MenuAction> menuActions;

  /// Flag to determine if the app is in production. If it is, the debug menu
  /// will not show.
  final bool isProduction;

  /// Debug menu activation gesture.
  final GestureType gestureType;

  /// Flag to determine if network requests should be logged.
  final bool logNetworkRequests;

  @override
  State<StatefulWidget> createState() => _RootDebugContainerState(
      child, menuActions, title, isProduction, gestureType, logNetworkRequests);
}

class _RootDebugContainerState extends State<RootDebugContainer>
    with TickerProviderStateMixin {
  _RootDebugContainerState(this._child, this._menuActions, this._title,
      this._isProduction, this._gestureType, this._logNetworkRequests);

  /// Root widget of the application.
  final Widget _child;

  /// Title of the application.
  final String _title;

  /// Flag to determine if the app is in production.
  /// will not show.
  final bool _isProduction;

  /// Debug menu activation gesture.
  final GestureType _gestureType;

  /// Flag to determine if network requests should be logged.
  final bool _logNetworkRequests;

  /// Menu action items to present.
  List<MenuAction> _menuActions;

  /// Flag to show debug menu;
  bool _showDebugMenu = false;

  @override
  Widget build(BuildContext context) {
    if (_isProduction) {
      return _child;
    } else if (_showDebugMenu) {
      return _buildDebugMenu(_showDebugMenu);
    } else {
      return _buildDebugContainer(_showDebugMenu);
    }
  }

  /// Builds the debug container, which contains the app contents
  /// but also overlays it with a gesture detector to switch between
  /// the menu and the app
  Widget _buildDebugContainer(bool visible) {
    return GestureDetector(
        onDoubleTap: () {
          if (_gestureType == GestureType.doubleTap) {
            _presentDebugMenu();
          }
        },
        onLongPress: () {
          if (_gestureType == GestureType.longPress) {
            _presentDebugMenu();
          }
        },
        child: _child);
  }

  /// Builds the debug menu
  Widget _buildDebugMenu(bool visible) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.white),
        home: DebugMenuScreen(_title, _menuActions, _onDebugBackPressed,
            _logNetworkRequests));
  }

  /// Hides the debug menu.
  void _onDebugBackPressed() {
    setState(() {
      _showDebugMenu = false;
    });
  }

  /// Shows the debug menu.
  void _presentDebugMenu() {
    setState(() {
      _showDebugMenu = true;
    });
  }
}
