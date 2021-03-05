//
//  WebRouter.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/2/24.
//

import UIKit

protocol WebWireframe: AnyObject {
}

final class WebRouter {
  private unowned let viewController: UIViewController

  private init(viewController: UIViewController) {
    self.viewController = viewController
  }

  static func assembleModules(viperEntity: VIPEREntity) -> UIViewController {
    let view = WebViewController.makeFromStoryboard()
    let interactor = WebInteractor()
    let router = WebRouter(viewController: view)
    let presenter = WebPresenter(
      view: view,
      interactor: interactor,
      router: router,
      viperEntity: viperEntity
    )

    view.presenter = presenter

    return view
  }
}

extension WebRouter: WebWireframe {
}

extension UIStoryboard {
  static func loadWeb() -> WebViewController {
    UIStoryboard(name: "Web", bundle: nil).instantiateInitialViewController() as! WebViewController 
  }
}
