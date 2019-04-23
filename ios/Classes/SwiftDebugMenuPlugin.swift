import Flutter
import UIKit

public class SwiftDebugMenuPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "debug_menu", binaryMessenger: registrar.messenger())
    let instance = SwiftDebugMenuPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {

    if call.method == "goToApplicationSettings"  {
       openSettings()
    } else if call.method == "getPlatformVersion" {
       result("iOS " + UIDevice.current.systemVersion)
    }
    else {
       result(FlutterMethodNotImplemented)
       return
    }
  }

  @discardableResult
  func openSettings() -> Bool {
      guard let settingsURL = URL(string: UIApplicationOpenSettingsURLString),
          UIApplication.shared.canOpenURL(settingsURL)
          else { return false }

      if #available(iOS 10.0, *) {
          UIApplication.shared.open(settingsURL)
      } else {
          // Fallback on earlier versions
          // Do nothing because this is a test app
      }
      return true
  }

}
