//
//  GithubSearchVIPER99Router.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/4/17.
//

import SwiftUI
import UIKit

typealias GithubSearchVIPER99Wireframe = GithubSearchVIPER01Wireframe

final class GithubSearchVIPER99Router {
  private unowned let viewController: UIViewController

  init(viewController: UIViewController) {
    self.viewController = viewController
  }

  // SwiftUIとUIKitのどちらにも対応できるようにするための処理
  private static func assembleModulesShare() -> (some View, UIViewController) {
    let interactor = GithubSearchVIPER99Interactor()
    let viewHelper = GithubSearchVIPER99ViewHelper()
    let view = GithubSearchVIPER99ViewSwiftUI(viewHelper: viewHelper)
    let viewController = UIHostingController(rootView: view)
    let router = GithubSearchVIPER99Router(viewController: viewController)
    let presenter = GithubSearchVIPER99Presenter(
      view: viewHelper,
      interactor: interactor,
      router: router
    )
    viewHelper.inject(presenter: presenter)
    return (view, viewController)
  }

  // SwiftUI用
  static func assembleModules() -> some View {
    GithubSearchVIPER99Router.assembleModulesShare().0
  }

  // UIKit用
  static func assembleModulesUIKit() -> UIViewController {
    GithubSearchVIPER99Router.assembleModulesShare().1
  }
}

extension GithubSearchVIPER99Router: GithubSearchVIPER99Wireframe {
  func showWeb(item: GithubSearchVIPER01Entity) {}

  func showAlert(error: Error) {
    print(error.localizedDescription)
  }

  func showWeb(dependency: WebVIPERInteractor.Dependency) {
    let next = WebVIPERRouter.assembleModules(dependency: dependency)
    viewController.show(next: next)
  }
}
