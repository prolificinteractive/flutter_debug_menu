import 'package:debug_menu/core/settings.dart';
import 'package:debug_menu/menu_actions/single_menu_action.dart';

class SettingsAction extends SingleMenuAction {
  SettingsAction({String title, String description, actionSelectedCallback})
      : super("Settings", "Open the Application Settings",
            () => Settings.openApplicationSettings());
}
