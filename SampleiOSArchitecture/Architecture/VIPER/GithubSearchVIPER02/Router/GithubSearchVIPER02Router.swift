//
//  GithubSearchVIPER02Router.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/4/17.
//

import UIKit

protocol GithubSearchVIPER02Wireframe: AnyObject {
}

final class GithubSearchVIPER02Router {
  private unowned let viewController: UIViewController

  private init(viewController: UIViewController) {
    self.viewController = viewController
  }

  static func assembleModules() -> UIViewController {
    let view = GithubSearchVIPER02ViewController.makeFromStoryboard()
    let interactor = GithubSearchVIPER02Interactor()
    let router = GithubSearchVIPER02Router(viewController: view)
    let presenter = GithubSearchVIPER02Presenter(
      view: view,
      interactor: interactor,
      router: router
    )

    view.presenter = presenter

    return view
  }
}

extension GithubSearchVIPER02Router: GithubSearchVIPER02Wireframe {
}

extension UIStoryboard {
  static func loadGithubSearchVIPER02() -> GithubSearchVIPER02ViewController {
    UIStoryboard(name: "GithubSearchVIPER02", bundle: nil).instantiateInitialViewController() as! GithubSearchVIPER02ViewController 
  }
}