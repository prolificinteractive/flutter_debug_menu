import 'package:debug_menu/menu_action.dart';
import 'package:flutter/cupertino.dart';

class RoutingButtonAction extends MenuAction {
  RoutingButtonAction(this.title, this.viewToRouteTo);

  @override
  String title;

  /// The view the button should route to
  Widget viewToRouteTo;
}
