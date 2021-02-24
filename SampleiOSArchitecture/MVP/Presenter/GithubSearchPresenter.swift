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

final class GithubSearchPresenter {

  private weak var output: GithubSearchPresenterOutput!
  private var api: GithubAPIProtocol!
  //状態をここで持ってる
  private var items: [GithubModel]

  //このoutputがViewControllerのこと
  init(output: GithubSearchPresenterOutput, api: GithubAPIProtocol = GithubAPI.shared) {
    self.output = output
    self.api = api
    self.items = []
  }
}

//PresenterはInputのprotocolに準拠する
extension GithubSearchPresenter: GithubSearchPresenterInput {
  var numberOfItems: Int { items.count }

  func item(index: Int) -> GithubModel { items[index] }

  func didSelect(index: Int) {
    print(items[index])
  }

  func searchText(_ text: String, sortType: Bool) {
    //output(つまりVC側に何をするか任せる)
    output.update(loading: true)
    //presenterがやることはapiを叩くのみ
    self.api.get(searchWord: text, isDesc: sortType) {[weak self] (result) in
      //output(つまりVC側に何をするか任せる)
      self?.output.update(loading: false)
      switch result {
      case .success(let items):
        //状態を保持
        self?.items = items
        //output(つまりVC側に何をするか任せる)
        self?.output.update(items: items)
      case .failure(let error):
        //output(つまりVC側に何をするか任せる)
        self?.output.get(error: error)
      }
    }
  }
}
