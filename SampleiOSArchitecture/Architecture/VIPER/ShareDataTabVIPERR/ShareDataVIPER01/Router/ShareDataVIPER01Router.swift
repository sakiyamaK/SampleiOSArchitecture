//
//  ShareDataVIPER01Router.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/5/27.
//

import UIKit

protocol ShareDataVIPER01Wireframe: AnyObject {
  func showShareDataVIPER03()
}

final class ShareDataVIPER01Router {
  private unowned let viewController: UIViewController

  deinit { DLog() }

  private init(viewController: UIViewController) {
    self.viewController = viewController
  }

  static func assembleModules() -> UIViewController {
    let view = ShareDataVIPER01ViewController.makeFromStoryboard()
    let interactor = ShareDataVIPER01Interactor()
    let router = ShareDataVIPER01Router(viewController: view)
    let presenter = ShareDataVIPER01Presenter(
      view: view,
      interactor: interactor,
      router: router
    )

    view.inject(presenter: presenter)

    return view
  }
}

extension ShareDataVIPER01Router: ShareDataVIPER01Wireframe {
  func showShareDataVIPER03() {
    let vc = ShareDataVIPER03Router.assembleModules()
    viewController.show(next: vc)
  }
}

extension UIStoryboard {
  static func loadShareDataVIPER01() -> ShareDataVIPER01ViewController {
    UIStoryboard(name: "ShareDataVIPER01", bundle: nil).instantiateInitialViewController() as! ShareDataVIPER01ViewController 
  }
}
