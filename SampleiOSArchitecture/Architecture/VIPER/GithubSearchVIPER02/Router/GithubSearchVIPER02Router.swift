//
//  GithubSearchVIPER02Router.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/4/17.
//

import SwiftUI
import UIKit

final class GithubSearchVIPER02Router {
  // TODO: 循環参照してそう
  private var viewController: UIViewController

  init(viewController: UIViewController) {
    self.viewController = viewController
  }

  // SwiftUIとUIKitのどちらにも対応できるようにするための処理
  private static func assembleModulesShare() -> (GithubSearchVIPER02View, GithubSearchVIPER02Router) {
    let interactor = GithubSearchVIPER02Interactor()
    let store = GithubSearchVIPER02Store()
    let view = GithubSearchVIPER02View(store: store)
    let router = GithubSearchVIPER02Router(viewController: UIHostingController(rootView: view))
    let presenter = GithubSearchVIPER02Presenter(
      view: store,
      interactor: interactor,
      router: router
    )
    store.inject(presenter: presenter)
    return (view, router)
  }

  // SwiftUI用
  static func assembleModules() -> some View {
    let (view, _) = GithubSearchVIPER02Router.assembleModulesShare()
    return view
  }

  // UIKit用
  static func assembleModulesUIKit() -> UIViewController {
    let (_, router) = GithubSearchVIPER02Router.assembleModulesShare()
    return router.viewController
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
