//
//  Router.swift
//  SampleMVP
//
//  Created by sakiyamaK on 2020/12/28.
//

import UIKit

final class Router {
  static func showRoot(window: UIWindow) {
    let vc = UIStoryboard.rootViewController
    let nav = UINavigationController(rootViewController: vc)
    window.rootViewController = nav
    window.makeKeyAndVisible()
  }

  static func showMVC(from: UIViewController) {
    from.show(next: UIStoryboard.mvcViewController)
  }

  static func showMVP(from: UIViewController) {
    let vc = UIStoryboard.mvpViewController
    let presenter = GithubSearchPresenter(output: vc)
    vc.inject(presenter: presenter)
    from.show(next: vc)
  }

  static func showMVVM(from: UIViewController) {
    from.show(next: UIStoryboard.mvvmViewController)
  }

  static func showVIPER(from: UIViewController) {
    from.show(next: VIPERRouter.assembleModules())
  }
}
