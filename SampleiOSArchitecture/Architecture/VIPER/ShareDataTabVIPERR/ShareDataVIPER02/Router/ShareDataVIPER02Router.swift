//
//  ShareDataVIPER02Router.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/5/27.
//

import UIKit

protocol ShareDataVIPER02Wireframe: AnyObject {
}

final class ShareDataVIPER02Router {
  private unowned let viewController: UIViewController

  deinit { DLog() }

  private init(viewController: UIViewController) {
    self.viewController = viewController
  }

  static func assembleModules() -> UIViewController {
    let view = ShareDataVIPER02ViewController.makeFromStoryboard()
    let interactor = ShareDataVIPER02Interactor()
    let router = ShareDataVIPER02Router(viewController: view)
    let presenter = ShareDataVIPER02Presenter(
      view: view,
      interactor: interactor,
      router: router
    )

    view.inject(presenter: presenter)

    return view
  }
}

extension ShareDataVIPER02Router: ShareDataVIPER02Wireframe {
}

extension UIStoryboard {
  static func loadShareDataVIPER02() -> ShareDataVIPER02ViewController {
    UIStoryboard(name: "ShareDataVIPER02", bundle: nil).instantiateInitialViewController() as! ShareDataVIPER02ViewController 
  }
}
