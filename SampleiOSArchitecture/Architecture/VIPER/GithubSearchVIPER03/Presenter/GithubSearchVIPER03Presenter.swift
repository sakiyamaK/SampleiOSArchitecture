//
//  GithubSearchVIPER03Presentation.swift
//  SampleiOSArchitecture
//
//  Created by  on 2023/5/13.
//

import Foundation

import Foundation

protocol GithubSearchVIPER03Presentation: AnyObject {
    func viewDidLoad()
    func tapSearchButton(word: String?)
    func selectItem(indexPath: IndexPath)
    func getSearchedItems() -> [GithubSearchVIPER03Entity]
}

final class GithubSearchVIPER03Presenter {

    private weak var view: GithubSearchVIPER03View?
    private let router: GithubSearchVIPER03Wireframe
    private let mainInteractor: GithubSearchVIPER03Usecase
    private let githubInteractor: GithubSearchVIPER03GithubUsecase
    private let qiitaInteractor: GithubSearchVIPER03QiitaUsecase

    init(
        view: GithubSearchVIPER03View,
        mainInteractor: GithubSearchVIPER03Usecase,
        githubInteractor: GithubSearchVIPER03GithubUsecase,
        qiitaInteractor: GithubSearchVIPER03QiitaUsecase,
        router: GithubSearchVIPER03Wireframe
    ) {
        self.view = view
        self.mainInteractor = mainInteractor
        self.githubInteractor = githubInteractor
        self.qiitaInteractor = qiitaInteractor
        self.router = router
    }
}

extension GithubSearchVIPER03Presenter: GithubSearchVIPER03Presentation {

    private func reloadIfNeed() {
        // ローディングが終わったのならviewを更新
        guard !self.mainInteractor.getLoading() else { return }
        view?.finishLoading()
        view?.reloadTable(items: self.mainInteractor.getSearchedItems())

    }
    func viewDidLoad() {
        view?.initView()
    }

    func tapSearchButton(word: String?) {

        // 同時にふたつのAPIを叩く


        // ローディングの状態を更新する
        view?.startLoading()
        mainInteractor.setGithub(loading: true)
        mainInteractor.setQiita(loading: true)

        // githubInteractorでapiを叩く
        githubInteractor.get(parameters: GithubSearchParameters(searchWord: word)) { [weak self] result in
            guard let self = self else { return }

            // ローディングの状態を更新する
            self.mainInteractor.setGithub(loading: false)

            switch result {
            case let .success(items):
                // apiの結果を保存しておく
                self.mainInteractor.setGithub(entities: items)
                // 画面を更新させようとする
                reloadIfNeed()
            case let .failure(error):
                self.router.showAlert(error: error)
            }
        }

        //qiitaInteractorでapiを叩く
        qiitaInteractor.get(parameters: QiitaSearchParameters(searchWord: word)) { [weak self] result in
            guard let self = self else { return }

            // ローディングの状態を更新する
            self.mainInteractor.setQiita(loading: false)

            switch result {
            case let .success(items):
                // apiの結果を保存しておく
                self.mainInteractor.setQiita(entities: items)
                // 画面を更新させようとする
                reloadIfNeed()
            case let .failure(error):
                self.router.showAlert(error: error)
            }
        }
    }

    func selectItem(indexPath: IndexPath) {
        let item = mainInteractor.getSearchedItems()[indexPath.row]
        let webEntity = WebVIPEREntity(urlStr: item.urlStr)
        let dependency = WebVIPERInteractor.Dependency(entity: webEntity)
        router.showWeb(dependency: dependency)
    }

    func getSearchedItems() -> [GithubSearchVIPER03Entity] {
        self.mainInteractor.getSearchedItems()
    }
}
