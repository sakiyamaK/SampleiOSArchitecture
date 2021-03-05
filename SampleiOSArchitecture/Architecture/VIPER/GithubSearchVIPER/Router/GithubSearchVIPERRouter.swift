//
//  GithubSearchVIPERRouter.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/2/24.
//

import UIKit

protocol GithubSearchVIPERWireframe: AnyObject {
  func showWeb(GithubSearchVIPEREntity: GithubSearchVIPEREntity)
}

final class GithubSearchVIPERRouter {
  private unowned let viewController: UIViewController

  private init(viewController: UIViewController) {
    self.viewController = viewController
  }

  static func assembleModules() -> UIViewController {
    let view = GithubSearchVIPERViewController.makeFromStoryboard()
    let interactor = GithubSearchVIPERInteractor()
    let router = GithubSearchVIPERRouter(viewController: view)
    let presenter = GithubSearchVIPERPresenter(
      view: view,
      interactor: interactor,
      router: router
    )

    view.presenter = presenter

    return view
  }
}

extension GithubSearchVIPERRouter: GithubSearchVIPERWireframe {
  func showWeb(GithubSearchVIPEREntity: GithubSearchVIPEREntity){
    let next = WebVIPERRouter.assembleModules(viperEntity: GithubSearchVIPEREntity)
    viewController.show(next: next)
  }
}

extension UIStoryboard {
  static func loadGithubSearchVIPER() -> GithubSearchVIPERViewController {
    UIStoryboard(name: "GithubSearchVIPER", bundle: nil).instantiateInitialViewController() as! GithubSearchVIPERViewController 
  }
}
