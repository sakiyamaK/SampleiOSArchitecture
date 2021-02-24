//
//  VIPERPresentation.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/2/24.
//

import Foundation

protocol VIPERPresentation: AnyObject {
  func viewDidLoad()
  func search(word: String)
  func showAleart(error: Error)
  func showWeb(viperEntity: VIPEREntity)
}

final class VIPERPresenter {
  private weak var view: VIPERView?
  private let router: VIPERWireframe
  private let interactor: VIPERUsecase

  init(
    view: VIPERView,
    interactor: VIPERUsecase,
    router: VIPERWireframe
  ) {
    self.view = view
    self.interactor = interactor
    self.router = router
  }
}

extension VIPERPresenter: VIPERPresentation {
  func viewDidLoad() {
    view?.initView()
  }

  func search(word: String) {
    view?.startLoading()
    interactor.get(searchWord: word, isDesc: true){[weak self] result in
      guard let self = self else { return }
      self.view?.finishLoading()
      switch result {
      case .success(let items):
        self.view?.reloadTable(items: items)
      case .failure(let error):
        self.view?.showAlert(error: error)
      }
    }
  }

  func showAleart(error: Error) {
    //AlertのRouterを呼び出す
    print(error.localizedDescription)
  }

  func showWeb(viperEntity: VIPEREntity) {
    //WebViewのRouterを呼び出す
    print(viperEntity.urlStr)
  }
}
