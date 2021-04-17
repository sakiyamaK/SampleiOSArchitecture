//
//  GithubAPI.swift
//  SampleMVP
//
//  Created by sakiyamaK on 2020/12/28.
//

import Foundation

enum GithubError: Error {
  case error, connect, parse
}

struct GithubSearchParameters {
  enum Order: String {
    case desc, asc
  }

  enum Sort: String {
    case stars
  }

  let searchWord: String?
  private var _searchWord: String { searchWord ?? "" }
  let sort: Sort = .stars
  let order: Order = .asc
  let perPage: Int = 100
  let page: Int = 0

  var validation: Bool {
    _searchWord.isNotEmpty && perPage <= 100 && perPage > 0
  }

  var queryParameter: String {
    "q=\(_searchWord)&sort=\(sort.rawValue)&order=\(order.rawValue)&per_page=\(perPage)&page=\(page)"
  }
}

protocol GithubAPIProtocol: AnyObject {
  func get(parameters: GithubSearchParameters,
           completion: ((Result<[GithubModel], GithubError>) -> Void)?)
}

final class GithubAPI: GithubAPIProtocol {
  static let shared = GithubAPI()

  private init() {}

  func get(parameters: GithubSearchParameters,
           completion: ((Result<[GithubModel], GithubError>) -> Void)? = nil)
  {
    guard parameters.validation else {
      completion?(.failure(.error))
      return
    }
    let url = URL(string: "https://api.github.com/search/repositories?\(parameters.queryParameter)")!
    let task: URLSessionTask = URLSession.shared.dataTask(with: url, completionHandler: { data, _, _ in
      guard let data = data,
            let githubResponse = try? JSONDecoder().decode(GithubResponse.self, from: data),
            let models = githubResponse.items
      else {
        completion?(.failure(.error))
        return
      }
      completion?(.success(models))
    })

    task.resume()
  }
}
