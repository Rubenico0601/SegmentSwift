//
// AppDelegate.swift
//

import UIKit
import Segment
import SegmentCleverTap
import CleverTapSDK
import AnalyticsLive

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
      _ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        CleverTap.setDebugLevel(CleverTapLogLevel.debug.rawValue)
        // ==== Replace with your Segment Source WRITE KEY ====
        let config = Configuration(writeKey: "lmjYxOXGPY0eFCnc6JjiEdzu3bdk4Bh3")
        let analytics = Analytics(configuration: config)
        
        // Add the CleverTap destination plugin (forwards Segment calls to CleverTap)
        analytics.add(plugin: CleverTapDestination())
        analytics.add(plugin: DestinationFilters())

        // Save a global instance for easy use across your app
        Analytics.main = analytics

        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration",
                                    sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication,
                     didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}
}

// Shared analytics instance accessible from anywhere in app
extension Analytics {
    // implicitly-unwrapped optional, set at launch in AppDelegate
    static var main: Analytics!
}
