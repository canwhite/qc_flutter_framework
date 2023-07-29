import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      
    let messenger : FlutterBinaryMessenger = window?.rootViewController as! FlutterBinaryMessenger
    testPlugin(messenger: messenger)

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }


  func testPlugin(messenger: FlutterBinaryMessenger) {   
    //channel监听和回调
    let channel = FlutterMethodChannel(name: "samples.flutter.dev/platform_channel", binaryMessenger: messenger)    
    channel.setMethodCallHandler { (call:FlutterMethodCall, result:@escaping FlutterResult) in           
    if (call.method == "getPlatformVersion") {            
          result("14");      
        }              
    }

    //call,也是需要具体的时机触发
    //channel.invokeMethod("randomNumberGenerated", 2) 


  }



}
