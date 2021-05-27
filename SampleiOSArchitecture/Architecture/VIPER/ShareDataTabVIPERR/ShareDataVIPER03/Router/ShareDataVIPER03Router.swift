//
//  ShareDataVIPER03Router.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/5/27.
//

import UIKit

protocol ShareDataVIPER03Wireframe: AnyObject {
}

final class ShareDataVIPER03Router {
  private unowned let viewController: UIViewController

  deinit { DLog() }

  private init(viewController: UIViewController) {
    self.viewController = viewController
  }

  static func assembleModules() -> UIViewController {
    let view = ShareDataVIPER03ViewController.makeFromStoryboard()
    let interactor = ShareDataVIPER03Interactor()
    let router = ShareDataVIPER03Router(viewController: view)
    let presenter = ShareDataVIPER03Presenter(
      view: view,
      interactor: interactor,
      router: router
    )

    view.inject(presenter: presenter)

    return view
  }
}

extension ShareDataVIPER03Router: ShareDataVIPER03Wireframe {
}

extension UIStoryboard {
  static func loadShareDataVIPER03() -> ShareDataVIPER03ViewController {
    UIStoryboard(name: "ShareDataVIPER03", bundle: nil).instantiateInitialViewController() as! ShareDataVIPER03ViewController 
  }
}
