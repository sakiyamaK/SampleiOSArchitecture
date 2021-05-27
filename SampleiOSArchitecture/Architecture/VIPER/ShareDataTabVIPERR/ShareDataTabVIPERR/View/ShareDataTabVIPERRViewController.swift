//
//  ShareDataTabVIPERRView.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/5/27.
//

import UIKit

protocol ShareDataTabVIPERRView: AnyObject {
}

final class ShareDataTabVIPERRViewController: UITabBarController {

  static func make() -> ShareDataTabVIPERRViewController {
    let vc = ShareDataTabVIPERRViewController()
    return vc
  }

  private var presenter: ShareDataTabVIPERRPresentation!
  func inject(presenter: ShareDataTabVIPERRPresentation) {
    self.presenter = presenter
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.setNavigationBarHidden(true, animated: false)
    presenter.viewWillAppear()
  }

  override func viewDidDisappear(_ animated: Bool) {
    self.navigationController?.setNavigationBarHidden(false, animated: false)
    super.viewDidDisappear(animated)
  }
}

extension ShareDataTabVIPERRViewController: UITabBarControllerDelegate {
}

extension ShareDataTabVIPERRViewController: ShareDataTabVIPERRView {
}
