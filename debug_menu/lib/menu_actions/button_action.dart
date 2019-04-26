import 'dart:ui';

import 'package:debug_menu/menu_action.dart';

class ButtonAction implements MenuAction {
  ButtonAction(this.title, this.tappedCallback);

  @override
  String title;

  @override
  String description = "";

  /// Callback for the action being tapped.
  VoidCallback tappedCallback;

  /// Calls the action selected callback.
  void tapped() {
    tappedCallback();
  }
}