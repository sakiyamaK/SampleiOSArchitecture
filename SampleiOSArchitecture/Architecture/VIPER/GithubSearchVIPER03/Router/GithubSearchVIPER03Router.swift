//
//  GithubSearchVIPER03Router.swift
//  SampleiOSArchitecture
//
//  Created by  on 2023/5/13.
//

import UIKit

protocol GithubSearchVIPER03Wireframe: AnyObject {
    func showWeb(dependency: WebVIPERInteractor.Dependency)
    func showAlert(error: Error)
}

final class GithubSearchVIPER03Router {
    private unowned let viewController: UIViewController

    private init(viewController: UIViewController) {
        self.viewController = viewController
    }

    struct Dependencies {
        var github: GithubSearchVIPER03GithubInteractor.Dependency = .init()
        var qiita: GithubSearchVIPER03QiitaInteractor.Dependency = .init()
    }

    static func assembleModules(dependencies: Dependencies) -> UIViewController {

        let view = UIStoryboard.githubSearchVIPER03ViewController

        // 3つのinteractorを用意
        let mainInteractor = GithubSearchVIPER03Interactor()
        let githubInteractor = GithubSearchVIPER03GithubInteractor(dependency: dependencies.github)
        let qiitaInteractor = GithubSearchVIPER03QiitaInteractor(dependency: dependencies.qiita)

        let router = GithubSearchVIPER03Router(viewController: view)
        let presenter = GithubSearchVIPER03Presenter(
            view: view,
            mainInteractor: mainInteractor,
            githubInteractor: githubInteractor,
            qiitaInteractor: qiitaInteractor,
            router: router
        )
        view.inject(presenter: presenter)

        return view
    }
}

extension GithubSearchVIPER03Router: GithubSearchVIPER03Wireframe {
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

extension UIStoryboard {
    static var githubSearchVIPER03ViewController: GithubSearchVIPER03ViewController {
        UIStoryboard(name: "GithubSearchVIPER03", bundle: nil).instantiateInitialViewController() as! GithubSearchVIPER03ViewController
    }
}
