//
//  GithubSearchVIPERInteractor.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/2/24.
//

import Foundation

//protocolを必ず用意
protocol GithubSearchVIPERUsecase {
  func get(searchWord: String, isDesc: Bool, completion: ((Result<[GithubSearchVIPEREntity], GithubSearchVIPEREntityError>) -> Void)?)
}

//もっともごちゃごちゃしがちになる部分
//他のアーキテクチャでいうUtilityが担当してたやつ全部きそう
final class GithubSearchVIPERInteractor {
  private let host: String
  init(host: String = "https://api.github.com") {
    self.host = host
  }
}

//用意したprotocolに準拠させる
extension GithubSearchVIPERInteractor: GithubSearchVIPERUsecase {
  func get(searchWord: String, isDesc: Bool = true, completion: ((Result<[GithubSearchVIPEREntity], GithubSearchVIPEREntityError>) -> Void)? = nil) {
    guard searchWord.count > 0 else {
      completion?(.failure(.error))
      return
    }
    let url: URL = URL(string: "\(host)/search/repositories?q=\(searchWord)&sort=stars&order=\(isDesc ? "desc" : "asc")")!
    let task: URLSessionTask = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
      guard let data = data,
            let githubResponse = try? JSONDecoder().decode(GithubSearchVIPEREntityResponse.self, from: data),
            let models = githubResponse.items else {
        completion?(.failure(.error))
        return
      }
      completion?(.success(models))
    })
    task.resume()
  }
}
