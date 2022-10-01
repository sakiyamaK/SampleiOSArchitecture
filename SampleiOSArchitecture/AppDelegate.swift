//
//  AppDelegate.swift
//  SampleiOSArchitecture
//
//  Created by sakiyamaK on 2021/02/07.
//

import UIKit

final class TestGithubSearchPresenterOutput: GithubSearchPresenterOutput {
  func update(loading: Bool) {
    print(loading)
  }

  func update(githubModels: [GithubModel]) {
    print(githubModels)
  }

  func get(error: Error) {
    print(error)
  }

  func showWeb(githubModel: GithubModel) {
    print(githubModel)
  }
}

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
