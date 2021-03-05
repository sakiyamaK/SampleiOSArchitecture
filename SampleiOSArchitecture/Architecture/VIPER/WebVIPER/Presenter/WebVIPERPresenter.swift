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
    router: WebVIPERWireframe
    ) {
    self.view = view
    self.interactor = interactor
    self.router = router
  }
}

extension WebVIPERPresenter: WebVIPERPresentation {

  func viewDidLoad() {
    guard let url = URL(string: interactor.getInitParameters().entity.urlStr) else { return }
    self.view?.fetch(url: url)
  }
}
