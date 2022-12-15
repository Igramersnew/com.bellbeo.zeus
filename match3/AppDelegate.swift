import UIKit
import AppsFlyerLib
import AppTrackingTransparency
import AdSupport

import FBSDKCoreKit
import FirebaseCore

import OneSignal
import RevenueCat

class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        FirebaseApp.configure()
        
        Purchases.configure(with: Configuration.Builder(withAPIKey: Constants.revenueCat).with(usesStoreKit2IfAvailable: true).build())
        
        OneSignal.initWithLaunchOptions(launchOptions)
        OneSignal.setAppId(Constants.onesignalKey)

        OneSignal.promptForPushNotifications(userResponse: { accepted in
          print("User accepted notifications: \(accepted)")
        })
        
        application.registerForRemoteNotifications()
        
        AppsFlyerLib.shared().isDebug = false
        
        AppsFlyerLib.shared().appsFlyerDevKey = Constants.appsflyerKey
        AppsFlyerLib.shared().appleAppID = Constants.appleID
        
        AppsFlyerLib.shared().waitForATTUserAuthorization(timeoutInterval: 60)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActiveNotification),
                                               name: UIApplication.didBecomeActiveNotification,
                                               object: nil)
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        ApplicationDelegate.shared.application(
            UIApplication.shared,
            open: url,
            sourceApplication: nil,
            annotation: [UIApplication.OpenURLOptionsKey.annotation]
        )
    }
    
    @objc func didBecomeActiveNotification() {
        AppsFlyerLib.shared().start()
        ATTrackingManager.requestTrackingAuthorization { status in
            NotificationCenter.default.post(name: Constants.attracking, object: nil)
        }
    }


}
