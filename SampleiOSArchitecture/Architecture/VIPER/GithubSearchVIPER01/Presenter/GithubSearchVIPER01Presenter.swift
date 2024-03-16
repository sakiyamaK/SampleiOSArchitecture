//
//  GithubSearchVIPER01Presentation.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/2/24.
//

import Foundation

// protocolを必ず用意
protocol GithubSearchVIPER01Presentation: AnyObject {
  func viewDidLoad()
  func tapSearchButton(word: String?)
  func selectItem(indexPath: IndexPath)
  func getSearchedItems() -> [GithubSearchVIPER01Entity]
}

// 他の部品以外は状態(パラメータ)をもたない
// 徹底的に他との中継役だけに徹する
final class GithubSearchVIPER01Presenter {
  // 循環参照しないようにviewだけweak
  private weak var view: GithubSearchVIPER01View?
  private let router: GithubSearchVIPER01Wireframe
  private let interactor: GithubSearchVIPER01Usecase

  init(
    view: GithubSearchVIPER01View,
    interactor: GithubSearchVIPER01Usecase,
    router: GithubSearchVIPER01Wireframe
  ) {
    self.view = view
    self.interactor = interactor
    self.router = router
  }
}

// 用意したprotocolに準拠させる
extension GithubSearchVIPER01Presenter: GithubSearchVIPER01Presentation {
  func viewDidLoad() {
    view?.initView()
  }

  func tapSearchButton(word: String?) {
    let parameters = GithubSearchParameters(searchWord: word)
    view?.startLoading()
    interactor.get(parameters: parameters) { [weak self] result in
      guard let self = self else { return }
      self.view?.finishLoading()
      switch result {
      case let .success(items):
        self.view?.reloadTable(items: items)
      case let .failure(error):
        self.router.showAlert(error: error)
      }
    }
  }

  func selectItem(indexPath: IndexPath) {
    let item = interactor.getSearchedItems()[indexPath.row]
    router.showWeb(item: item)
  }

  func getSearchedItems() -> [GithubSearchVIPER01Entity] {
    interactor.getSearchedItems()
  }
}
