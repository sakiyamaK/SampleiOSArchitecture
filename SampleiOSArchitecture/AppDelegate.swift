//
//  AppDelegate.swift
//  SampleiOSArchitecture
//
//  Created by sakiyamaK on 2021/02/07.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    let window = UIWindow()
    Router.showRoot(window: window)
    self.window = window

    return true
  }
}
