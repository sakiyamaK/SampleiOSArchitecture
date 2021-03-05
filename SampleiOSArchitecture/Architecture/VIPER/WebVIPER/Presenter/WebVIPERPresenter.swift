//
//  WebVIPERPresentation.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/2/24.
//

import Foundation

protocol WebVIPERPresentation: AnyObject {
  func viewDidLoad()
}

final class WebVIPERPresenter {
  private weak var view: WebVIPERView?
  private let router: WebVIPERWireframe
  private let interactor: WebVIPERUsecase

  init(
    view: WebVIPERView,
    interactor: WebVIPERUsecase,
    router: WebVIPERWireframe,
    viperEntity: GithubSearchVIPEREntity
  ) {
    self.view = view
    self.interactor = interactor
    self.router = router
    self.view?.setInitParameters(viperEntity)
  }
}

extension WebVIPERPresenter: WebVIPERPresentation {
  func viewDidLoad() {
    self.view?.fetch()
  }
}
