//
//  GithubAPI+Combine.swift
//  SampleiOSArchitecture
//
//  Created by sakiyamaK on 2021/04/08.
//

import Combine
import Foundation

extension GithubAPIProtocol {
  // 戻り値はObservable型にすること
  func get(parameters: GithubSearchParameters) -> AnyPublisher<[GithubModel], GithubError> {
    let url = URL(string: "https://api.github.com/search/repositories?\(parameters.queryParameter)")!
    return URLSession.shared.dataTaskPublisher(for: url)
      .tryMap { data, response -> Data in
        guard let httpRes = response as? HTTPURLResponse,
              (200..<300).contains(httpRes.statusCode)
        else {
          throw GithubError.error
        }
        return data
      }
      .decode(type: GithubResponse.self, decoder: JSONDecoder())
      .map { $0.items ?? [] }
      .mapError { $0 as! GithubError }
      .eraseToAnyPublisher()
  }
}
