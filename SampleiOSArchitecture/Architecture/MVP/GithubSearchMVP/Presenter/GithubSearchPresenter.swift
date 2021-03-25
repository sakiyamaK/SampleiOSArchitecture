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
  func search(parameters: GithubSearchParameters)
  func didSelect(index: Int)
}

//出力に関するprotocol
protocol GithubSearchPresenterOutput: AnyObject {
  func update(loading: Bool)
  func update(githubModels: [GithubModel])
  func get(error: Error)
  func showWeb(githubModel: GithubModel)
}

final class GithubSearchPresenter {

  private weak var output: GithubSearchPresenterOutput!
  private var api: GithubAPIProtocol!
  //状態をここで持ってる
  private var githubModels: [GithubModel]

  //このoutputがViewControllerのこと
  init(output: GithubSearchPresenterOutput, api: GithubAPIProtocol = GithubAPI.shared) {
    self.output = output
    self.api = api
    self.githubModels = []
  }
}

//PresenterはInputのprotocolに準拠する
extension GithubSearchPresenter: GithubSearchPresenterInput {
  var numberOfItems: Int { githubModels.count }

  func item(index: Int) -> GithubModel { githubModels[index] }

  func didSelect(index: Int) {
    output.showWeb(githubModel: githubModels[index])
  }

  func search(parameters: GithubSearchParameters) {
    guard parameters.validation else { return }
    //output(つまりVC側に何をするか任せる)
    output.update(loading: true)
    //presenterがやることはapiを叩くのみ
    self.api.get(parameters: parameters) {[weak self] (result) in
      //output(つまりVC側に何をするか任せる)
      self?.output.update(loading: false)
      switch result {
      case .success(let githubModels):
        //状態を保持
        self?.githubModels = githubModels
        //output(つまりVC側に何をするか任せる)
        self?.output.update(githubModels: githubModels)
      case .failure(let error):
        //output(つまりVC側に何をするか任せる)
        self?.output.get(error: error)
      }
    }
  }
}
