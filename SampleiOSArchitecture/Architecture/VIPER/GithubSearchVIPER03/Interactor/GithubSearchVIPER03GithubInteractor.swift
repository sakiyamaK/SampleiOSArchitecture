//
//  GithubSearchVIPER03Interactor.swift
//  SampleiOSArchitecture
//
//  Created by  on 2023/5/13.
//

// GithubAPIを叩くだけのInteractor

import Foundation

protocol GithubSearchVIPER03GithubUsecase {
    func get(parameters: GithubSearchParameters, completion: ((Result<[GithubSearchVIPER03GithubEntity], GithubSearchVIPER03EntityError>) -> Void)?)
    var loading: Bool { get }
}

final class GithubSearchVIPER03GithubInteractor {
    struct Dependency {
        var host: String = "https://api.github.com"
    }

    private(set) var loading: Bool = false
    private let dependency: Dependency
    init(dependency: Dependency) {
        self.dependency = dependency
    }
}

extension GithubSearchVIPER03GithubInteractor: GithubSearchVIPER03GithubUsecase {
    func get(parameters: GithubSearchParameters, completion: ((Result<[GithubSearchVIPER03GithubEntity], GithubSearchVIPER03EntityError>) -> Void)? = nil) {
        guard parameters.validation
        else {
            completion?(.failure(.error))
            return
        }

        let url = URL(string: "\(dependency.host)/search/repositories?\(parameters.queryParameter)")!
        let task: URLSessionTask = URLSession.shared.dataTask(with: url, completionHandler: { data, _, _ in

            guard let data = data,
                  let githubResponse = try? JSONDecoder().decode(GithubSearchVIPER02EntityResponse.self, from: data),
                  let items = githubResponse.items
            else {
                completion?(.failure(.error))
                return
            }
            completion?(.success(items))
        })
        task.resume()
    }
}
