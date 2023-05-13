//
//  GithubSearchVIPER01Interactor.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/2/24.
//

import Foundation

// protocolを必ず用意
protocol GithubSearchVIPER01Usecase {
  func get(parameters: GithubSearchParameters, completion: ((Result<[GithubSearchVIPER01Entity], GithubSearchVIPER01EntityError>) -> Void)?)
  func getSearchedItems() -> [GithubSearchVIPER01Entity]
}

// もっともごちゃごちゃしがちになる部分
// 他のアーキテクチャでいうUtilityが担当してたやつ全部ここに来そう
final class GithubSearchVIPER01Interactor {
  private let host: String
  // 検索結果の状態を保持
  private var searchedItems: [GithubSearchVIPER01Entity]
  init(host: String = "https://api.github.com") {
    self.host = host
    searchedItems = []
  }
}

// 用意したprotocolに準拠させる
extension GithubSearchVIPER01Interactor: GithubSearchVIPER01Usecase {
  func get(parameters: GithubSearchParameters, completion: ((Result<[GithubSearchVIPER01Entity], GithubSearchVIPER01EntityError>) -> Void)? = nil) {
    guard parameters.validation
    else {
      completion?(.failure(.error))
      return
    }
    // APIをシングルトンにして呼び出す方式でもいいかもしれない
    let url = URL(string: "\(host)/search/repositories?\(parameters.queryParameter)")!
    let task: URLSessionTask = URLSession.shared.dataTask(with: url, completionHandler: { data, _, _ in
      guard let data = data,
            let githubResponse = try? JSONDecoder().decode(GithubSearchVIPER01EntityResponse.self, from: data),
            let items = githubResponse.items
      else {
        completion?(.failure(.error))
        return
      }
      // 検索結果の状態を保持
      self.searchedItems = items
      completion?(.success(items))
    })
    task.resume()
  }

  func getSearchedItems() -> [GithubSearchVIPER01Entity] { searchedItems }
}
