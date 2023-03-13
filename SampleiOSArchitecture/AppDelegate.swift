//
//  AppDelegate.swift
//  SampleiOSArchitecture
//
//  Created by sakiyamaK on 2021/02/07.
//

import UIKit

// GithubSearchPresenterをテストするためのコード --------
final class TestGithubSearchPresenterOutput: GithubSearchPresenterOutput {
    func update(loading: Bool) {
        print(loading)
    }

    func update(githubModels: [GithubModel]) {
        print(githubModels)
    }

    func get(error: Error) {
        print(error)
    }

    func showWeb(githubModel: GithubModel) {
        print(githubModel)
    }
}

func testGithuhubSearchMVP() {
    let output = TestGithubSearchPresenterOutput()
    let presenter = GithubSearchPresenter(output: output)

    // presenterのsearchメソッドの動作確認
    ["", nil, "Swift", "higepaghei", "🍎"].forEach { searchWord in
        let parameters = GithubSearchParameters(searchWord: searchWord)
        presenter.search(parameters: parameters)
    }
}
// --------

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

//        testGithuhubSearchMVP()

        let window = UIWindow()
        Router.showRoot(window: window)
        self.window = window

        return true
    }
}
