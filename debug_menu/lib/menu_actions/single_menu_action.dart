import 'dart:ui';

import 'package:debug_menu/menu_action.dart';

class SingleMenuAction implements MenuAction {
  SingleMenuAction(this.title, this.description, this._actionSelectedCallback);

  @override
  String title;

  @override
  String description;

  /// Callback for the action.
  VoidCallback _actionSelectedCallback;

  /// Called when the action is selected.
  void actionSelected() {
    _actionSelectedCallback();
  }
}
