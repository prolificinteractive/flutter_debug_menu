# debug_menu

A debug menu for Flutter

## Getting Started

This project is a starting point for a Dart
[package](https://flutter.io/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our
[online documentation](https://flutter.io/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Implementation

Add `RootDebugContainer` as the root object in the application's main build function.

```
 @override
  Widget build(BuildContext context) {
    return RootDebugContainer(
        child: AppContainer(
            application: _application,
            child: MaterialApp( ... )),
        title: 'AT&T Thanks',
        menuActions: _debugActions(),
        isProduction: false,
        gestureType: GestureType.doubleTap,
        logNetworkRequests: true);
  }
```

The `child` can be the standard application container of the app. Other options of the RootDebugContainer include:

- `title` - Title of the application. Sets the app bar of the debug menu.
- `menuActions` - Actions of the debug menu. More information below.
- `isProduction` - Flag to determine if the application is in production. Will disable the debug menu if the app is in production.
- `gestureType` - Debug menu activation gesture. Current options: `longPress` or `doubleTap`.
- `logNetworkRequests` - Flag to determine if the debug menu should log network requests and responses.

## Menu Actions

Add `menuActions` to the `RootDebugContainer`. Actions can be added in the form of a `List<MenuAction>`.

### `MultiMenuAction`
`MultiMenuAction` can be used for menu actions that require a selection from a menu. A `MultiMenuAction` is useful for changing the API environment.

```
 List<MenuAction> _debugActions() {
    final List<MenuAction> actions = List<MenuAction>();
    final List<MenuAction> subActions = List<MenuAction>();

    final MenuAction stagingAction = ToggleMenuAction(
        'Staging',
        'Development API Environment',
        () => {_application = ATTApplication(Staging())},
        true);

    final MenuAction developmentAction = ToggleMenuAction(
        'Development',
        'Development API Environment',
        () => {_application = ATTApplication(Dev())},
        false);

    final MenuAction productionAction = ToggleMenuAction(
        'Production',
        'Production API Environment',
        () => {_application = ATTApplication(Production())},
        false);

    subActions.add(stagingAction);
    subActions.add(developmentAction);
    subActions.add(productionAction);

    final MultiMenuAction multiMenuAction =
        MultiMenuAction('API Environments', subActions);

    actions.add(multiMenuAction);
    return actions;
  }
```
As shown above, a `MultiMenuAction`, takes in a the name of the action with a list of subActions. A subAction can be in the form of the abstract class `MenuAction`

```
abstract class MenuAction {
  /// Title of the menu action.
  String title;

  /// Description of the menu action.
  String description;
}
```

### `ToggleMenuAction`
A `ToggleMenuAction` can either be selected or unselected. It can be used in a `MultiMenuAction` or by itself to select an option.

```
final MenuAction productionAction = ToggleMenuAction(
    'Production',
    'Production API Environment',
    () => {_application = ATTApplication(Production())},
    false);
```

Parameters:
 - title - The title of the action.
 - description - SubTitle description of the action.
 - actionSelectedCallback - Callback when the action is selected.

A `ToggleMenuAction` can be used with a `MultiMenuAction` to change the API environment when its selected.

### `SingleMenuAction`
A `SingleMenuAction` is similar to a `ToggleMenuAction`, except it doesn't have a selected / unselected state.
The `actionSelectedCallback` is called whenever the item is selected.

```
final SingleMenuAction singleMenuAction = SingleMenuAction(
    'Show a toast',
    'Sample display for a toast',
    () => {print('Selected Single Menu Action')});
```

### Network Activity Monitor

Network Activity can be monitored and displayed in the debug menu by adding the following line to dio.

```
_dio.interceptors.add(DebugMenuInterceptor(isProduction: false));
```

The `isProduction` boolean flag will allow the ability to prevent any network logging if it is in production.
To enable network logging, ensure `isProduction` is set to false and the `logNetworkRequests` is enabled in the `RootDebugContainer`.
