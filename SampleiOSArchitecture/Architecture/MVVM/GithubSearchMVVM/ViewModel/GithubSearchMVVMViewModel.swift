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
protocol GithubSearchMVVMViewModelInput {
  var searchTextObservable: Observable<String?> { get }
  var didSelectRelay: PublishRelay<Int> { get }
}

//ViewModelの出力に関するprotocol
protocol GithubSearchMVVMViewModelOutput {
  var loadingObservable: Observable<Bool> { get }
  var updateGithubModelsObservable: Observable<[GithubModel]> { get }
  var selectGithubModelObservable: Observable<GithubModel> { get }
  var githubModels: [GithubModel] { get }
}

//ViewModelはInputとOutputのprotocolに準拠する
final class GithubSearchMVVMViewModel: GithubSearchMVVMViewModelOutput, HasDisposeBag {
  /*outputについての記述*/
  //出力側の定型文的な書き方
  private let _loading: BehaviorRelay<Bool> = .init(value: false)
  lazy var loadingObservable: Observable<Bool> = _loading.asObservable()
  private let _updateGithubModels: BehaviorRelay<[GithubModel]> = .init(value: [])
  lazy var updateGithubModelsObservable = _updateGithubModels.asObservable()
  private let _selectGithubModel: PublishRelay<GithubModel> = .init()
  lazy var selectGithubModelObservable: Observable<GithubModel> = _selectGithubModel.asObservable()

  private(set) var githubModels: [GithubModel]

  //初期化時にストリームを決める
  init(input: GithubSearchMVVMViewModelInput, api: GithubAPIProtocol = GithubAPI.shared) {

    self.githubModels = []

    let searchTextObservable = input.searchTextObservable
      .debug()
      .filterNil()
      .filter { $0.count > 0 }
      .distinctUntilChanged()

    input.didSelectRelay.asObservable()
      .debug()
      .filter { $0 < self.githubModels.count - 1 }
      .map { self.githubModels[$0] }
      .debug()
      .bind(to: _selectGithubModel).disposed(by: disposeBag)

    searchTextObservable
      .debug()
      .flatMapLatest({ (searchWord) -> Observable<[GithubModel]> in
      GithubAPI.shared.rx.get(searchWord: searchWord, isDesc: true)
    }).do(onNext: {[weak self] _ in
      self?._loading.accept(true)
    }).map {[weak self] (githubModels) -> [GithubModel] in
      //最後に得たデータを保存
      self?.githubModels = githubModels
      self?._loading.accept(false)
      return githubModels
    }.bind(to: _updateGithubModels).disposed(by: disposeBag)
  }
}
