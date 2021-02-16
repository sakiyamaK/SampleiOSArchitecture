//
//  Router.swift
//  SampleMVP
//
//  Created by sakiyamaK on 2020/12/28.
//

import UIKit


//厳密にVIPERに沿ってやるならここもProtocolにした方がいいけどまぁいいや

final class Router {
  static private func show(from: UIViewController, to: UIViewController) {
    if let nav = from.navigationController {
      nav.pushViewController(to, animated: true)
    } else {
      from.present(to, animated: true, completion: nil)
    }
  }

  static func showRoot(window: UIWindow) {
    let vc = UIStoryboard.rootViewController
    let nav = UINavigationController(rootViewController: vc)
    window.rootViewController = nav
    window.makeKeyAndVisible()
  }

  static func showMVC(from: UIViewController) {
    show(from: from, to: UIStoryboard.mvcViewController)
  }

  static func showMVP(from: UIViewController) {
    let vc = UIStoryboard.mvpViewController
    let presenter = GithubSearchPresenter(output: vc)
    vc.inject(presenter: presenter)
    show(from: from, to: vc)
  }

  static func showMVVM(from: UIViewController) {
    show(from: from, to: UIStoryboard.mvvmViewController)
  }

}
