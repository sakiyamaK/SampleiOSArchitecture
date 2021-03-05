//
//  WebVIPERRouter.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/2/24.
//

import UIKit

protocol WebVIPERWireframe: AnyObject {
}

final class WebVIPERRouter {
  private unowned let viewController: UIViewController

  private init(viewController: UIViewController) {
    self.viewController = viewController
  }

  static func assembleModules(viperEntity: GithubSearchVIPEREntity) -> UIViewController {
    let view = WebVIPERViewController.makeFromStoryboard()
    let interactor = WebVIPERInteractor()
    let router = WebVIPERRouter(viewController: view)
    let presenter = WebVIPERPresenter(
      view: view,
      interactor: interactor,
      router: router,
      viperEntity: viperEntity
    )

    view.presenter = presenter

    return view
  }
}

extension WebVIPERRouter: WebVIPERWireframe {
}

extension UIStoryboard {
  static func loadWebVIPER() -> WebVIPERViewController {
    UIStoryboard(name: "WebVIPER", bundle: nil).instantiateInitialViewController() as! WebVIPERViewController 
  }
}
