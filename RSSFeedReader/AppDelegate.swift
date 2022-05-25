//
//  AppDelegate.swift
//  RSSFeedReader
//
//  Created by Oleksii Mykhalchuk on 5/24/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  var appCoordinator: AppCoordinator?
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    window = UIWindow(frame: UIScreen.main.bounds)
    let navigationCon = UINavigationController.init()
    appCoordinator = AppCoordinator(navCon: navigationCon)
    appCoordinator?.start()
    window?.rootViewController = navigationCon
    window?.makeKeyAndVisible()
    return true
  }
}
