//
//  ShareDataTabVIPERRRouter.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/5/27.
//

import UIKit

protocol ShareDataTabVIPERRWireframe: AnyObject {
}

final class ShareDataTabVIPERRRouter {
  private unowned let tabBarController: UITabBarController

  private init(tabBarController: UITabBarController) {
    self.tabBarController = tabBarController
  }

  private func setupTab() {
    let vc1 = ShareDataVIPER01Router.assembleModules()
    let nav1 = UINavigationController(rootViewController: vc1)
    nav1.tabBarItem.title = "red"
    let vc2 = ShareDataVIPER02Router.assembleModules()
    let nav2 = UINavigationController(rootViewController: vc2)
    nav2.tabBarItem.title = "blue"
    tabBarController.setViewControllers([nav1, nav2], animated: true)
  }

  static func assembleModules() -> UITabBarController {
    let view = ShareDataTabVIPERRViewController.make()
    let interactor = ShareDataTabVIPERRInteractor()
    let router = ShareDataTabVIPERRRouter(tabBarController: view)
    router.setupTab()
    let presenter = ShareDataTabVIPERRPresenter(
      view: view,
      interactor: interactor,
      router: router
    )

    view.inject(presenter: presenter)

    return view
  }
}

extension ShareDataTabVIPERRRouter: ShareDataTabVIPERRWireframe {
}
