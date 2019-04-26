import 'dart:ui';

import 'package:debug_menu/menu_action.dart';

class ToggleMenuAction implements MenuAction {
  ToggleMenuAction(this.title, this.description, this._actionSelectedCallback,
      this.selected);

  @override
  String title;

  @override
  String description;

  /// Callback for the action.
  VoidCallback _actionSelectedCallback;

  /// Flag to determine if the menu action is selected.
  bool selected;

  /// Toggles the selection of the menu action.
  /// Calls the action selected callback.
  void actionSelected() {
    selected = !selected;
    _actionSelectedCallback();
  }
}
