//
//  GithubSearchVIPER02Presentation.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/2/24.
//

import Foundation

protocol GithubSearchVIPER02Presentation: AnyObject {
    func viewDidLoad()
    func tapSearchButton(word: String?)
    func selectItem(indexPath: IndexPath)
    func getSearchedItems() -> [GithubSearchVIPER02Entity]
}

final class GithubSearchVIPER02Presenter {

    private weak var view: GithubSearchVIPER02View?
    private let router: GithubSearchVIPER02Wireframe
    private let interactor: GithubSearchVIPER02Usecase

    init(
        view: GithubSearchVIPER02View,
        interactor: GithubSearchVIPER02Usecase,
        router: GithubSearchVIPER02Wireframe
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension GithubSearchVIPER02Presenter: GithubSearchVIPER02Presentation {

    // 画面が呼ばれた直後とsearch buttonを押した時に呼ばれるメソッドとして共通化
    private func getSearch(word: String?, isAlert: Bool = true) {
        let parameters = GithubSearchParameters(searchWord: word)
        view?.startLoading()
        interactor.get(parameters: parameters) { [weak self] result in
            guard let self = self else { return }
            self.view?.finishLoading()
            switch result {
            case let .success(items):
                self.view?.reloadTable(items: items)
            case let .failure(error):
                // 初期値が空の場合はアラートを出さないようにするため場合分け
                // もっと良い方法がある気もする
                if isAlert {
                    self.router.showAlert(error: error)
                }
            }
        }
    }

    func viewDidLoad() {
        // view側に初期値を渡す
        view?.initView(searchWord: interactor.dependency.searchWord)
        // interactorを呼び出すメソッドのgetSearchを実行する
        getSearch(word: interactor.dependency.searchWord, isAlert: false)
    }

    func tapSearchButton(word: String?) {
        getSearch(word: word)
    }

    func selectItem(indexPath: IndexPath) {
        let githubSearchVIPER02Entity = interactor.getSearchedItems()[indexPath.row]
        let entity = WebVIPEREntity(urlStr: githubSearchVIPER02Entity.urlStr)
        let dependency = WebVIPERInteractor.Dependency(entity: entity)
        router.showWeb(dependency: dependency)
    }

    func getSearchedItems() -> [GithubSearchVIPER02Entity] {
        interactor.getSearchedItems()
    }
}
