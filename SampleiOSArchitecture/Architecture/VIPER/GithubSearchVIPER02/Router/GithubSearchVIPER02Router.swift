//
//  GithubSearchVIPER02Router.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/4/17.
//

import SwiftUI
import UIKit

final class GithubSearchVIPER02Router {
  private unowned let viewController: UIViewController

  init(viewController: UIViewController) {
    self.viewController = viewController
  }

  // SwiftUIとUIKitのどちらにも対応できるようにするための処理
  private static func assembleModulesShare() -> (GithubSearchVIPER02View, UIViewController) {
    let interactor = GithubSearchVIPER02Interactor()
    let viewHelper = GithubSearchVIPER02ViewHelper()
    let view = GithubSearchVIPER02View(viewHelper: viewHelper)
    let viewController = UIHostingController(rootView: view)
    let router = GithubSearchVIPER02Router(viewController: viewController)
    let presenter = GithubSearchVIPER02Presenter(
      view: viewHelper,
      interactor: interactor,
      router: router
    )
    viewHelper.inject(presenter: presenter)
    return (view, viewController)
  }

  // SwiftUI用
  static func assembleModules() -> some View {
    GithubSearchVIPER02Router.assembleModulesShare().0
  }

  // UIKit用
  static func assembleModulesUIKit() -> UIViewController {
    GithubSearchVIPER02Router.assembleModulesShare().1
  }
}

extension GithubSearchVIPER02Router: GithubSearchVIPERWireframe {
  func showAlert(error: Error) {
    print(error.localizedDescription)
  }

  func showWeb(initParameters: WebVIPERUsecaseInitParameters) {
    let next = WebVIPERRouter.assembleModules(initParameters: initParameters)
    viewController.show(next: next)
  }
}
