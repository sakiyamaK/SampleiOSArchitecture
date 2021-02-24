//
//  GithubAPI.swift
//  SampleMVP
//
//  Created by sakiyamaK on 2020/12/28.
//

import Foundation

enum GithubError: Error {
  case error
}

protocol GithubAPIProtocol: AnyObject {
  func get(searchWord: String, isDesc: Bool, completion: ((Result<[GithubModel], GithubError>) -> Void)?)
}

final class GithubAPI: GithubAPIProtocol {
  static let shared = GithubAPI()

  private init() {}

  func get(searchWord: String, isDesc: Bool = true, completion: ((Result<[GithubModel], GithubError>) -> Void)? = nil) {
    guard searchWord.count > 0 else {
      completion?(.failure(.error))
      return
    }
    let url: URL = URL(string: "https://api.github.com/search/repositories?q=\(searchWord)&sort=stars&order=\(isDesc ? "desc" : "asc")")!
    let task: URLSessionTask = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
      guard let data = data,
          let githubResponse = try? JSONDecoder().decode(GithubResponse.self, from: data),
          let models = githubResponse.items else {
        completion?(.failure(.error))
        return
      }
      completion?(.success(models))
    })
    task.resume()
  }
}
