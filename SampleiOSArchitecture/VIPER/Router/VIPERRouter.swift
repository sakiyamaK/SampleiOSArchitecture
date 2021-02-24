//
//  VIPERRouter.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/2/24.
//

import UIKit

protocol VIPERWireframe: AnyObject {
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
}

extension UIStoryboard {
  static func loadVIPER() -> VIPERViewController {
    UIStoryboard(name: "VIPER", bundle: nil).instantiateInitialViewController() as! VIPERViewController 
  }
}
