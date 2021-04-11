//
//  GithubAPI+MVVM.swift
//  SampleiOSArchitecture
//
//  Created by sakiyamaK on 2021/02/07.
//

import Foundation
import RxCocoa
import RxSwift

//自作のGithubAPIクラスのfunctionをRx対応させる定型文

//これでrx.hogehogeとできるようになる
extension GithubAPI: ReactiveCompatible {}
//GithubAPIのrxにメソッドを追加する
extension Reactive where Base: GithubAPI {
  //戻り値はObservable型にすること
  func get(parameters: GithubSearchParameters) -> Observable<[GithubModel]> {
    //Observableを作成するクラスメソッド
    return Observable.create { observer in
      //実際の処理
      GithubAPI.shared.get(parameters: parameters) { (result) in
        switch result {
        case .success(let models):
          //戻り値の成功パターン
          observer.on(.next(models))
        case .failure(let err):
          //戻り値のエラーパターン
          observer.on(.error(err))
        }
      }
      //Disposablesを作成するクラスメソッドを返す
      return Disposables.create()
    }.share(replay: 1, scope: .whileConnected)//通信系の処理はshareをしておくこと
  }
}
