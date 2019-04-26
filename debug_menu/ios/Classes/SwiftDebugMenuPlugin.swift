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
       if openSettings() == false {
          result("Cannot open settings")
       }
    } else if call.method == "getPlatformVersion" {
       let version = ["Platform": "iOS", "Version": "\(UIDevice.current.systemVersion)"]
       result(version)
    }
    else {
       result(FlutterMethodNotImplemented)
       return
    }
  }

  @discardableResult
  func openSettings() -> Bool {
    guard let settingsURL = URL(string: UIApplicationOpenSettingsURLString),
        UIApplication.shared.canOpenURL(settingsURL), #available(iOS 10.0, *) else {
            return false
    }
    UIApplication.shared.open(settingsURL)
    return true
  }

}