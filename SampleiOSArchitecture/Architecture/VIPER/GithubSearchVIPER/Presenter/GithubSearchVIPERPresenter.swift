//
//  GithubSearchVIPERPresentation.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/2/24.
//

import Foundation

//protocolを必ず用意
protocol GithubSearchVIPERPresentation: AnyObject {
  func viewDidLoad()
  func tapSearchButton(word: String)
  func selectItem(githubSearchVIPEREntity: GithubSearchVIPEREntity)
}

//他の部品以外は状態(パラメータ)をもたない
//徹底的に他との中継役だけに徹する
final class GithubSearchVIPERPresenter {
  //循環参照しないようにviewだけweak
  private weak var view: GithubSearchVIPERView?
  private let router: GithubSearchVIPERWireframe
  private let interactor: GithubSearchVIPERUsecase

  init(
    view: GithubSearchVIPERView,
    interactor: GithubSearchVIPERUsecase,
    router: GithubSearchVIPERWireframe
  ) {
    self.view = view
    self.interactor = interactor
    self.router = router
  }
}

//用意したprotocolに準拠させる
extension GithubSearchVIPERPresenter: GithubSearchVIPERPresentation {
  func viewDidLoad() {
    view?.initView()
  }

  func tapSearchButton(word: String) {
    view?.startLoading()
    interactor.get(searchWord: word, isDesc: true){[weak self] result in
      guard let self = self else { return }
      self.view?.finishLoading()
      switch result {
      case .success(let items):
        self.view?.reloadTable(items: items)
      case .failure(let error):
        self.router.showAlert(error: error)
      }
    }
  }

  func selectItem(githubSearchVIPEREntity: GithubSearchVIPEREntity) {
    let initParameters: WebVIPERUsecaseInitParameters = .init(entity: githubSearchVIPEREntity)
    router.showWeb(initParameters: initParameters)
  }
}
