//
//  GithubSearchVIPER01Router.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/2/24.
//

import UIKit

// protocolを必ず用意
protocol GithubSearchVIPER01Wireframe: AnyObject {
    func showWeb(dependency: WebVIPERInteractor.Dependency)
    func showAlert(error: Error)
}

final class GithubSearchVIPER01Router {
    private unowned let viewController: UIViewController

    private init(viewController: UIViewController) {
        self.viewController = viewController
    }

    // VIPERの全てのインスタンスを立ち上げてお互いを繋ぐメソッド
    // static methodなので厳密に言えば
    // View-Interactor-Presenter-Entity-Routerのどこに書いてもいいが
    // VIPERの設計上Routerが遷移を管理しているのでここに書いている
    static func assembleModules() -> UIViewController {

        let view = UIStoryboard.githubSearchVIPER01ViewController
        
        // 他の部品と繋ぐ必要がない
        let interactor = GithubSearchVIPER01Interactor()

        //        // UIKitの画面遷移の仕組み上,viewを知らないと次の画面に遷移できないためRouterと繋ぐ
        let router = GithubSearchVIPER01Router(viewController: view)

        // presenterが中継役なので全部と繋がる
        let presenter = GithubSearchVIPER01Presenter(
            view: view,
            interactor: interactor,
            router: router
        )

        // viewからpresenterに通知する必要があるため繋ぐ
        // viewとpresenterは互いが互いを知っている
        view.inject(presenter: presenter)

        return view
    }
}

// 用意したprotocolに準拠させる
extension GithubSearchVIPER01Router: GithubSearchVIPER01Wireframe {
    func showAlert(error: Error) {
        // アラート画面のRouterを呼ぶ
        let alert = UIAlertController(title: "error", message: error.localizedDescription, preferredStyle: .alert)
        let button = UIAlertAction(title: "OK", style: .default)
        alert.addAction(button)
        viewController.present(alert, animated: true)
    }

    func showWeb(dependency: WebVIPERInteractor.Dependency) {
        let next = WebVIPERRouter.assembleModules(dependency: dependency)
        viewController.show(next: next)
    }
}

// VIPERは個別にRouterの設定があるためここでUIStoryboardのextensionも用意してる
extension UIStoryboard {
    static var githubSearchVIPER01ViewController: GithubSearchVIPER01ViewController {
        UIStoryboard(name: "GithubSearchVIPER01", bundle: nil).instantiateInitialViewController() as! GithubSearchVIPER01ViewController
    }
}
