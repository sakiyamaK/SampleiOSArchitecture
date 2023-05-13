//
//  GithubSearchVIPER03Interactor.swift
//  SampleiOSArchitecture
//
//  Created by on 2023/5/13.
//

import Foundation

// QiitaAPIを叩くだけのInteractor

protocol GithubSearchVIPER03QiitaUsecase {
    func get(parameters: QiitaSearchParameters, completion: ((Result<[GithubSearchVIPER03QiitaEntity], GithubSearchVIPER03EntityError>) -> Void)?)
}

final class GithubSearchVIPER03QiitaInteractor {
    struct Dependency {
        var host: String = "https://qiita.com"
    }

    let dependency: Dependency
    init(dependency: Dependency) {
        self.dependency = dependency
    }
}

extension GithubSearchVIPER03QiitaInteractor: GithubSearchVIPER03QiitaUsecase {
    func get(parameters: QiitaSearchParameters, completion: ((Result<[GithubSearchVIPER03QiitaEntity], GithubSearchVIPER03EntityError>) -> Void)? = nil) {
        guard parameters.validation
        else {
            completion?(.failure(.error))
            return
        }

        let url = URL(string: "\(dependency.host)/api/v2/items?\(parameters.queryParameter)")!
        let task: URLSessionTask = URLSession.shared.dataTask(with: url, completionHandler: { data, _, _ in

            guard let data = data,
                  let items = try? JSONDecoder().decode([GithubSearchVIPER03QiitaEntity].self, from: data)
            else {
                completion?(.failure(.error))
                return
            }
            completion?(.success(items))
        })
        task.resume()
    }
}
