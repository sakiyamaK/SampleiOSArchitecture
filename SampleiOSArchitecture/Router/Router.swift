//
//  Router.swift
//  SampleMVP
//
//  Created by sakiyamaK on 2020/12/28.
//

import UIKit

final class Router {
  static func showRoot(window: UIWindow) {
    let vc = RootViewController()
    let nav = UINavigationController(rootViewController: vc)
    window.rootViewController = nav
    window.makeKeyAndVisible()
  }
}

// MVC用の遷移
extension Router {
  static func showMVC(from: UIViewController) {
    from.show(next: UIStoryboard.GithubSearchMVC01ViewController)
  }

  static func showWebMVC(from: UIViewController, githubModel: GithubModel) {
    let vc = WebMVCViewController.makeFromStoryboard(githubModel: githubModel)
    from.show(next: vc)
  }
}

// MVP用の遷移
extension Router {
  static func showMVP(from: UIViewController) {
    let vc = UIStoryboard.githubSearchMVPViewController
    let presenter = GithubSearchPresenter(output: vc)
    vc.inject(presenter: presenter)
    from.show(next: vc)
  }

  static func showWebMVP(from: UIViewController, githubModel: GithubModel) {
    let vc = UIStoryboard.webMVPViewController
    let presenter = WebMVPPresenter(output: vc, githubModel: githubModel)
    vc.inject(presenter: presenter)
    from.show(next: vc)
  }
}

// MVVM用の遷移
extension Router {
  static func showMVVM01(from: UIViewController) {
    let vc = UIStoryboard.githubSearchMVVM01ViewController
    from.show(next: vc)
  }

  static func showWebMVVM(from: UIViewController, githubModel: GithubModel) {
    let vc = WebMVVMViewController.makeFromStoryboard(githubModel: githubModel)
    from.show(next: vc)
  }

  static func showMVVM02(from: UIViewController) {
    let vc = GithubSearchMVVM02ViewController.makeFromStoryboard()
    from.show(next: vc)
  }

  static func showMVVM03(from: UIViewController) {
    let vc = GithubSearchMVVM03ViewController.makeFromStoryboard()
    from.show(next: vc)
  }
}

// VIPER用の遷移
// 本来はこんな書き方しないが起動時にVIPERの記述になっていないためしかたなく
// 逆にいうとこうして他のアーキテクチャからVIPERに切り替えることもできる
extension Router {
  static func showVIPER(from: UIViewController) {
    from.show(next: GithubSearchVIPERRouter.assembleModules())
  }

  static func showVIPER02(from: UIViewController) {
    from.show(next: GithubSearchVIPER02Router.assembleModulesUIKit())
  }

  static func showShareDataVIPER(from: UIViewController) {
    from.show(next: ShareDataTabVIPERRRouter.assembleModules())
  }
}
