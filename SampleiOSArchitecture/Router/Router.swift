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

  static func showMVVM(from: UIViewController) {
    from.show(next: UIStoryboard.mvvmViewController)
  }

  static func showVIPER(from: UIViewController) {
    from.show(next: VIPERRouter.assembleModules())
  }
}

//MVC用の遷移
extension Router {
  static func showMVC(from: UIViewController) {
    from.show(next: UIStoryboard.githubSearchMVCViewController)
  }

  static func showWebMVC(from: UIViewController, githubModel: GithubModel) {
    let vc = WebMVCViewController.makeFromStoryboard(githubModel: githubModel)
    from.show(next: vc)
  }
}

//MVC用の遷移
extension Router {
  static func showMVP(from: UIViewController) {
    let vc = UIStoryboard.githubSearchMVPViewController
    let presenter = GithubSearchPresenter(output: vc)
    vc.inject(presenter: presenter)
    from.show(next: vc)
  }

  static func showWebMVP(from: UIViewController, githubModel: GithubModel) {
    let vc = UIStoryboard.webMVPViewController
    let presenter = WebMVPPresenter(view: vc, githubModel: githubModel)
    vc.inject(presenter: presenter)
    from.show(next: vc)
  }
}
