import UIKit
import Flutter
import CoreLocation

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        //MARK: Method channel
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController

        let getLocationChannel = FlutterMethodChannel(name: "com.flavoring/test",
                                                      binaryMessenger: controller as! FlutterBinaryMessenger)

        getLocationChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in

            guard call.method == "getMyLocation" else {
                result(FlutterMethodNotImplemented)
                return
            }
            result(String("hello flutter: replied to \(call.arguments!)"))

//            self?.getMyLocation(result: result)
        })

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func getMyLocation(result: FlutterResult) {

    }
}
