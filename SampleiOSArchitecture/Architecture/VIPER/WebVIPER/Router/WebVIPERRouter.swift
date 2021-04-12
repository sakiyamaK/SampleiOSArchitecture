//
//  WebVIPERRouter.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/2/24.
//

import UIKit

protocol WebVIPERWireframe: AnyObject {
  func showAlert(error: Error)
}

final class WebVIPERRouter {
  private unowned let viewController: UIViewController

  private init(viewController: UIViewController) {
    self.viewController = viewController
  }

  static func assembleModules(initParameters: WebVIPERUsecaseInitParameters) -> UIViewController {
    let view = UIStoryboard.webVIPERViewController
    let interactor = WebVIPERInteractor(initParameters: initParameters)
    let router = WebVIPERRouter(viewController: view)
    let presenter = WebVIPERPresenter(
      view: view,
      interactor: interactor,
      router: router
    )

    view.inject(presenter: presenter)

    return view
  }
}

extension WebVIPERRouter: WebVIPERWireframe {
  func showAlert(error: Error) {
    // アラート画面のRouterを呼ぶ
    print(error.localizedDescription)
  }
}

extension UIStoryboard {
  static var webVIPERViewController: WebVIPERViewController {
    return UIStoryboard(name: "WebVIPER", bundle: nil).instantiateInitialViewController() as! WebVIPERViewController
  }
}
