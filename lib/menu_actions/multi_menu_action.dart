import 'package:debug_menu/menu_actions/menu_action.dart';
import 'package:debug_menu/menu_actions/toggle_menu_action.dart';

class MultiMenuAction implements MenuAction {
  MultiMenuAction(this.title, this.subActions) {
    _setInitialDescription();
  }

  @override
  String title;

  @override
  String description;

  /// Sub actions of the multi menu.
  List<MenuAction> subActions;

  /// Un-selects the sub-actions and sets the selected action as selected.
  void subActionSelected(ToggleMenuAction selectedAction) {
    if (selectedAction.selected) {
      return;
    }

    for (MenuAction action in subActions) {
      if (action == selectedAction) {
        description = selectedAction.title;
        selectedAction.actionSelected();
      } else if (action is ToggleMenuAction) {
        action.selected = false;
      }
    }
  }

  /// Sets the initial value of the description.
  void _setInitialDescription() {
    for (MenuAction action in subActions) {
      if (action is ToggleMenuAction && action.selected) {
        description = action.title;
      }
    }
  }
}
