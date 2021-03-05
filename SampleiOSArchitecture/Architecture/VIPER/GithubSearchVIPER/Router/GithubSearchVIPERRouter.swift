//
//  GithubSearchVIPERRouter.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/2/24.
//

import UIKit

//protocolを必ず用意
protocol GithubSearchVIPERWireframe: AnyObject {
  func showWeb(GithubSearchVIPEREntity: GithubSearchVIPEREntity)
}

final class GithubSearchVIPERRouter {
  private unowned let viewController: UIViewController

  private init(viewController: UIViewController) {
    self.viewController = viewController
  }

  //VIPERの全てのインスタンスを立ち上げてお互いを繋ぐメソッド
  //static methodなので厳密に言えば
  //View-Interactor-Presenter-Entity-Routerのどこに書いてもいいが
  //VIPERの設計上Routerが遷移を管理しているのでここに書いている
  static func assembleModules() -> UIViewController {

    let view = UIStoryboard.githubSearchVIPERViewController

    //他の部品と繋ぐ必要がない
    let interactor = GithubSearchVIPERInteractor()

    //UIKitの画面遷移の仕組み上,viewを知らないと次の画面に遷移できないためRouterと繋ぐ
    let router = GithubSearchVIPERRouter(viewController: view)

    //presenterが中継役なので全部と繋がる
    let presenter = GithubSearchVIPERPresenter(
      view: view,
      interactor: interactor,
      router: router
    )

    //viewからpresenterに通知する必要があるため繋ぐ
    //viewとpresenterは互いが互いを知っている
    view.inject(presenter: presenter)

    return view
  }
}

//用意したprotocolに準拠させる
extension GithubSearchVIPERRouter: GithubSearchVIPERWireframe {
  func showWeb(GithubSearchVIPEREntity: GithubSearchVIPEREntity){
    let next = WebVIPERRouter.assembleModules(viperEntity: GithubSearchVIPEREntity)
    viewController.show(next: next)
  }
}

//VIPERは個別にRouterの設定があるためここでUIStoryboardのextensionも用意してる
extension UIStoryboard {
  static var githubSearchVIPERViewController: GithubSearchVIPERViewController {
    UIStoryboard(name: "GithubSearchVIPER", bundle: nil).instantiateInitialViewController() as! GithubSearchVIPERViewController 
  }
}
