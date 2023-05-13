//
//  GithubSearchVIPER02Interactor.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/2/24.
//

import Foundation

protocol GithubSearchVIPER02Usecase {
    func get(parameters: GithubSearchParameters, completion: ((Result<[GithubSearchVIPER02Entity], GithubSearchVIPER02EntityError>) -> Void)?)
    func getSearchedItems() -> [GithubSearchVIPER02Entity]
    var dependency: GithubSearchVIPER02Interactor.Dependency { get }

}

final class GithubSearchVIPER02Interactor {
    // 初期化パラメータ
    struct Dependency {
        var host: String = "https://api.github.com"
        var searchWord: String?
    }

    let dependency: Dependency
    // 検索結果の状態を保持
    private var searchedItems: [GithubSearchVIPER02Entity]
    init(dependency: Dependency) {
        self.dependency = dependency
        searchedItems = []
    }
}

extension GithubSearchVIPER02Interactor: GithubSearchVIPER02Usecase {
    func get(parameters: GithubSearchParameters, completion: ((Result<[GithubSearchVIPER02Entity], GithubSearchVIPER02EntityError>) -> Void)? = nil) {
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
            // 検索結果の状態を保持
            self.searchedItems = items
            completion?(.success(items))
        })
        task.resume()
    }

    func getSearchedItems() -> [GithubSearchVIPER02Entity] { searchedItems }
}
