//
//  VIPERRouter.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/2/24.
//

import UIKit

protocol VIPERWireframe: AnyObject {
  func showWeb(viperEntity: VIPEREntity)
}

final class VIPERRouter {
  private unowned let viewController: UIViewController

  private init(viewController: UIViewController) {
    self.viewController = viewController
  }

  static func assembleModules() -> UIViewController {
    let view = VIPERViewController.makeFromStoryboard()
    let interactor = VIPERInteractor()
    let router = VIPERRouter(viewController: view)
    let presenter = VIPERPresenter(
      view: view,
      interactor: interactor,
      router: router
    )

    view.presenter = presenter

    return view
  }
}

extension VIPERRouter: VIPERWireframe {
  func showWeb(viperEntity: VIPEREntity){
    let next = WebRouter.assembleModules(viperEntity: viperEntity)
    if let nav = viewController.navigationController {
      nav.pushViewController(next, animated: true)
    } else {
      viewController.present(next, animated: true, completion: nil)
    }
  }
}

extension UIStoryboard {
  static func loadVIPER() -> VIPERViewController {
    UIStoryboard(name: "VIPER", bundle: nil).instantiateInitialViewController() as! VIPERViewController 
  }
}
