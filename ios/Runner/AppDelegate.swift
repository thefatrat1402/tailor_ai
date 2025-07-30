
import UIKit
import Flutter
import ARKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  private var resultCallback: FlutterResult?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(name: "com.example.arheight/height", binaryMessenger: controller.binaryMessenger)

    channel.setMethodCallHandler { [weak self] call, result in
      if call.method == "startHeightEstimation" {
        self?.resultCallback = result
        self?.startARSession()
      } else {
        result(FlutterMethodNotImplemented)
      }
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func startARSession() {
    guard ARBodyTrackingConfiguration.isSupported else {
      resultCallback?(FlutterError(code: "UNSUPPORTED", message: "Body tracking not supported", details: nil))
      return
    }

    let config = ARBodyTrackingConfiguration()
    let session = ARSession()
    session.run(config)

    DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
      if let bodyAnchor = session.currentFrame?.anchors.compactMap({ $0 as? ARBodyAnchor }).first {
        let headY = bodyAnchor.skeleton.modelTransform(for: .head)?.columns.3.y ?? 0.0
        let footY = bodyAnchor.skeleton.modelTransform(for: .leftFoot)?.columns.3.y ?? 0.0
        let height = abs(headY - footY)
        self.resultCallback?(height)
      } else {
        self.resultCallback?(0.0)
      }
      session.pause()
    }
  }
}

