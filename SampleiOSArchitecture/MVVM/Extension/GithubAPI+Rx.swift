//
//  GithubAPI+MVVM.swift
//  SampleiOSArchitecture
//
//  Created by sakiyamaK on 2021/02/07.
//

import Foundation
import RxCocoa
import RxSwift

//自作のGithubAPIクラスのfunctionをRx対応させる
extension GithubAPI: ReactiveCompatible {}
extension Reactive where Base: GithubAPI {
  func get(searchWord: String, isDesc: Bool = true) -> Observable<[GithubModel]> {
    return Observable.create { observer in
      GithubAPI.shared.get(searchWord: searchWord, isDesc: isDesc) { (result) in
        switch result {
        case .success(let models):
          observer.on(.next(models))
        case .failure(let err):
          observer.on(.error(err))
        }
      }
      return Disposables.create()
    }.share(replay: 1, scope: .whileConnected)
  }
}
