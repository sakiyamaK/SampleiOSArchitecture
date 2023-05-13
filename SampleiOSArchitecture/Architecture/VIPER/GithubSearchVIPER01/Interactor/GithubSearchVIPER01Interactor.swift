//
//  GithubSearchVIPERInteractor.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/2/24.
//

import Foundation

// protocolを必ず用意
protocol GithubSearchVIPERUsecase {
  func get(parameters: GithubSearchParameters, completion: ((Result<[GithubSearchVIPEREntity], GithubSearchVIPEREntityError>) -> Void)?)
  func getSearchedItems() -> [GithubSearchVIPEREntity]
}

// もっともごちゃごちゃしがちになる部分
// 他のアーキテクチャでいうUtilityが担当してたやつ全部ここに来そう
final class GithubSearchVIPERInteractor {
  private let host: String
  // 検索結果の状態を保持
  private var searchedItems: [GithubSearchVIPEREntity]
  init(host: String = "https://api.github.com") {
    self.host = host
    searchedItems = []
  }
}

// 用意したprotocolに準拠させる
extension GithubSearchVIPERInteractor: GithubSearchVIPERUsecase {
  func get(parameters: GithubSearchParameters, completion: ((Result<[GithubSearchVIPEREntity], GithubSearchVIPEREntityError>) -> Void)? = nil) {
    guard parameters.validation
    else {
      completion?(.failure(.error))
      return
    }
    // APIをシングルトンにして呼び出す方式でもいいかもしれない
    let url = URL(string: "\(host)/search/repositories?\(parameters.queryParameter)")!
    let task: URLSessionTask = URLSession.shared.dataTask(with: url, completionHandler: { data, _, _ in
      guard let data = data,
            let githubResponse = try? JSONDecoder().decode(GithubSearchVIPEREntityResponse.self, from: data),
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

  func getSearchedItems() -> [GithubSearchVIPEREntity] { searchedItems }
}
