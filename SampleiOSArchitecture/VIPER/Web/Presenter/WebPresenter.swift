//
//  WebPresentation.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/2/24.
//

import Foundation

protocol WebPresentation: AnyObject {
  func viewDidLoad()
}

final class WebPresenter {
  private weak var view: WebView?
  private let router: WebWireframe
  private let interactor: WebUsecase

  init(
    view: WebView,
    interactor: WebUsecase,
    router: WebWireframe,
    viperEntity: VIPEREntity
  ) {
    self.view = view
    self.interactor = interactor
    self.router = router
    self.view?.setInitParameters(viperEntity)
  }
}

extension WebPresenter: WebPresentation {
  func viewDidLoad() {
    self.view?.loadInitWeb()
  }
}
