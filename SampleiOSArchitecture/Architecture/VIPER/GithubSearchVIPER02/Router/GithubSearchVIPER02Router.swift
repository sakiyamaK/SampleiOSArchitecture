//
//  GithubSearchVIPER02Router.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/2/24.
//

import UIKit

// protocolを必ず用意
protocol GithubSearchVIPER02Wireframe: AnyObject {
    func showWeb(dependency: WebVIPERInteractor.Dependency)
    func showAlert(error: Error)
}

final class GithubSearchVIPER02Router {
    private unowned let viewController: UIViewController

    private init(viewController: UIViewController) {
        self.viewController = viewController
    }

    // assembleModulesで初期化パラメータを渡す
    static func assembleModules(dependency: GithubSearchVIPER02Interactor.Dependency = .init()) -> UIViewController {

        let view = UIStoryboard.githubSearchVIPER02ViewController
        let interactor = GithubSearchVIPER02Interactor(dependency: dependency)
        let router = GithubSearchVIPER02Router(viewController: view)
        let presenter = GithubSearchVIPER02Presenter(
            view: view,
            interactor: interactor,
            router: router
        )
        view.inject(presenter: presenter)

        return view
    }
}

extension GithubSearchVIPER02Router: GithubSearchVIPER02Wireframe {
    func showAlert(error: Error) {
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

// VIPER02は個別にRouterの設定があるためここでUIStoryboardのextensionも用意してる
extension UIStoryboard {
    static var githubSearchVIPER02ViewController: GithubSearchVIPER02ViewController {
        UIStoryboard(name: "GithubSearchVIPER02", bundle: nil).instantiateInitialViewController() as! GithubSearchVIPER02ViewController
    }
}
