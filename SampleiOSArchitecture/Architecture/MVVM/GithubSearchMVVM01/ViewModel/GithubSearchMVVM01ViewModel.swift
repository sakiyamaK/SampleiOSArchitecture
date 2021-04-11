//
//  RxGithubSearchMVVMViewModel.swift
//  SampleRxSwift
//
//  Created by sakiyamaK on 2020/05/23.
//  Copyright © 2020 sakiyamaK. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import NSObject_Rx

//ViewModelの入力に関するprotocol
protocol GithubSearchMVVM01ViewModelInput {
  var searchTextObservable: Observable<String?> { get }
  var didSelectObservable: Observable<Int> { get }
}

//ViewModelの出力に関するprotocol
protocol GithubSearchMVVM01ViewModelOutput {
  var loadingObservable: Observable<Bool> { get }
  var updateGithubModelsObservable: Observable<[GithubModel]> { get }
  var selectGithubModelObservable: Observable<GithubModel> { get }
  var githubModels: [GithubModel] { get }
}

//ViewModelはInputとOutputのprotocolに準拠する
final class GithubSearchMVVM01ViewModel: GithubSearchMVVM01ViewModelOutput, HasDisposeBag {
  /*outputについての記述*/
  //出力側の定型文的な書き方
  private let _loading: PublishRelay<Bool> = .init()
  lazy var loadingObservable: Observable<Bool> = _loading.asObservable()
  private let _updateGithubModels: BehaviorRelay<[GithubModel]> = .init(value: [])
  lazy var updateGithubModelsObservable = _updateGithubModels.asObservable()
  private let _selectGithubModel: PublishRelay<GithubModel> = .init()
  lazy var selectGithubModelObservable: Observable<GithubModel> = _selectGithubModel.asObservable()

  private(set) var githubModels: [GithubModel]

  //初期化時にストリームを決める
  init(input: GithubSearchMVVM01ViewModelInput, api: GithubAPIProtocol = GithubAPI.shared) {

    self.githubModels = []

    input.didSelectObservable
      .filter { $0 < self.githubModels.count - 1 }
      .map { self.githubModels[$0] }
      .bind(to: _selectGithubModel).disposed(by: disposeBag)

    let searchTextObservable = input.searchTextObservable
      .filterNil()
      .filter { $0.count > 0 }
      .distinctUntilChanged()

    //loadingをtrueにする
    searchTextObservable.map {_ in return true }.bind(to: _loading).disposed(by: disposeBag)

    searchTextObservable
      .map { GithubSearchParameters(searchWord: $0) }
      .flatMapLatest({ (parameters) -> Observable<[GithubModel]> in
      GithubAPI.shared.rx.get(parameters: parameters)
    }).map {[weak self] (githubModels) -> [GithubModel] in
      //最後に得たデータを保存
      self?.githubModels = githubModels
      //loadingをfalseにする
      self?._loading.accept(false)
      // 取得した値をストリームに流す(今のところ使ってないから流す必要はないけど一応)
      return githubModels
    }.bind(to: _updateGithubModels).disposed(by: disposeBag)
  }
}
