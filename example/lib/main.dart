import 'package:debug_menu/gesture_type.dart';
import 'package:debug_menu/menu_actions/button_action.dart';
import 'package:debug_menu/menu_actions/menu_action.dart';
import 'package:debug_menu/menu_actions/multi_menu_action.dart';
import 'package:debug_menu/menu_actions/single_menu_action.dart';
import 'package:debug_menu/menu_actions/toggle_menu_action.dart';
import 'package:debug_menu/root_container.dart';
import 'package:debug_menu/settings_action.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return RootDebugContainer(
      title: "Example Debug Container",
      gestureType: GestureType.doubleTap,
      isProduction: false,
      menuActions: _debugActions(),
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: Center(
            child: Text('Double Tap to open Debug Menu'),
          ),
        ),
      ),
    );
  }

  List<MenuAction> _debugActions() {
    final List<MenuAction> actions = List<MenuAction>();

    final MultiMenuAction emptyMultiMenuAction =
        MultiMenuAction('Sample Empty Multi Action', []);

    final ToggleMenuAction toggleMenuItem = ToggleMenuAction(
        'Toggle Menu Item',
        'Toggles a menu item',
        () => {print('Selected Toggle Menu Action')},
        false);

    final SingleMenuAction singleMenuAction = SingleMenuAction(
        'Show a toast',
        'Sample display for a toast',
        () => {print('Selected Single Menu Action')});

    final SettingsAction settingsAction = SettingsAction();

    final ButtonAction action =
        ButtonAction("Test", () => print("This worked"));

    actions.add(emptyMultiMenuAction);
    actions.add(toggleMenuItem);
    actions.add(singleMenuAction);
    actions.add(settingsAction);
    actions.add(action);

    return actions;
  }
}
