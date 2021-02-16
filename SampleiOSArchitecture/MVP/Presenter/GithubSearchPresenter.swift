//
//  GithubSearchPresenter.swift
//  SampleMVP
//
//  Created by sakiyamaK on 2020/12/28.
//

import Foundation

//入力に関するprotocol
protocol GithubSearchPresenterInput {
  var numberOfItems: Int { get }
  func item(index: Int) -> GithubModel
  func searchText(_ text: String, sortType: Bool)
  func didSelect(index: Int)
}

//出力に関するprotocol
protocol GithubSearchPresenterOutput: AnyObject {
  func update(loading: Bool)
  func update(items: [GithubModel])
  func get(error: Error)
}

//PresenterはInputのprotocolに準拠する
final class GithubSearchPresenter: GithubSearchPresenterInput {

  private weak var output: GithubSearchPresenterOutput!
  private var api: GithubAPIProtocol!
  private var items: [GithubModel]

  init(output: GithubSearchPresenterOutput, api: GithubAPIProtocol = GithubAPI.shared) {
    self.output = output
    self.api = api
    self.items = []
  }

  var numberOfItems: Int { items.count }

  func item(index: Int) -> GithubModel { items[index] }

  func didSelect(index: Int) {
    print(items[index])
  }

  func searchText(_ text: String, sortType: Bool) {
    output.update(loading: true)
    self.api.get(searchWord: text, isDesc: sortType) {[weak self] (result) in
      self?.output.update(loading: false)
      switch result {
      case .success(let items):
        self?.items = items
        self?.output.update(items: items)
      case .failure(let error):
        self?.output.get(error: error)
      }
    }
  }
}
