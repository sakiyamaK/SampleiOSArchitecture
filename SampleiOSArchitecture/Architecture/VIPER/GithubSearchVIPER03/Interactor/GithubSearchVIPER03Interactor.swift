//
//  GithubSearchVIPER03Interactor.swift
//  SampleiOSArchitecture
//
//  Created by  on 2023/5/13.
//

// 他のIntarctorの結果を受け取り必要な処理をしてViewに渡すためのメインのInteractor

import Foundation

protocol GithubSearchVIPER03Usecase {
    func getSearchedItems() -> [GithubSearchVIPER03Entity]
    func getLoading() -> Bool

    func setGithub(entities: [GithubSearchVIPER03GithubEntity])
    func setQiita(entities: [GithubSearchVIPER03QiitaEntity])
    func setGithub(loading: Bool)
    func setQiita(loading: Bool)
}

final class GithubSearchVIPER03Interactor {
    // 検索結果の状態を保持
    private var githubSearchedItems: [GithubSearchVIPER03GithubEntity] = []
    private var qiitaSearchedItems: [GithubSearchVIPER03QiitaEntity] = []
    // ローディングの状態を保持
    private var githubLoading: Bool = false
    private var qiitaLoading: Bool = false

    init() {}
}

extension GithubSearchVIPER03Interactor: GithubSearchVIPER03Usecase {
    func setGithub(entities: [GithubSearchVIPER03GithubEntity]) {
        self.githubSearchedItems = entities
    }

    func setQiita(entities: [GithubSearchVIPER03QiitaEntity]) {
        self.qiitaSearchedItems = entities
    }

    func setGithub(loading: Bool) {
        self.githubLoading = loading
    }

    func setQiita(loading: Bool) {
        self.qiitaLoading = loading
    }

    func getSearchedItems() -> [GithubSearchVIPER03Entity] {
        githubSearchedItems.compactMap({
            GithubSearchVIPER03Entity(name: $0.name, urlStr: $0.urlStr)
        }) +
        qiitaSearchedItems.compactMap({
            GithubSearchVIPER03Entity(name: $0.title, urlStr: $0.urlStr)
        })
    }

    func getLoading() -> Bool {
        githubLoading || qiitaLoading
    }
}
