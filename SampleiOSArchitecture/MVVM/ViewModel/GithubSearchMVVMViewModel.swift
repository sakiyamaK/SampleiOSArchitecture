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
  var didSelectRelay: BehaviorRelay<Int> { get }
}

//ViewModelの出力に関するprotocol
protocol GithubSearchMVVMViewModelOutput {
  var loadingObservable: Observable<Bool> { get }
  var updateItemsObservable: Observable<[GithubModel]> { get }
  var items: [GithubModel] { get }
}

//ViewModelはInputとOutputのprotocolに準拠する
final class GithubSearchMVVMViewModel: GithubSearchMVVMViewModelOutput, HasDisposeBag {

  /*outputについての記述*/

  private let _loading: BehaviorRelay<Bool> = .init(value: false)
  lazy var loadingObservable: Observable<Bool> = _loading.asObservable()
  //出力側の定型文的な書き方
  private let _updateItems: BehaviorRelay<[GithubModel]> = .init(value: [])
  lazy var updateItemsObservable = _updateItems.asObservable()
  private(set) var items: [GithubModel]

  private var input: GithubSearchMVVMViewModelInput!
  private var api: GithubAPIProtocol!

  //初期化時にストリームを決める
  init(input: GithubSearchMVVMViewModelInput, api: GithubAPIProtocol = GithubAPI.shared) {
    self.input = input
    self.api = api
    self.items = []

    let searchTextObservable = input.searchTextObservable
      .filterNil()
      .filter { $0.count > 0 }
      .distinctUntilChanged()

    input.didSelectRelay.asObservable().subscribe(onNext: {[weak self] (index) in
      let item = self!.items[index]
      print(item)
    }).disposed(by: disposeBag)

    searchTextObservable.flatMapLatest({ (searchWord) -> Observable<[GithubModel]> in
      GithubAPI.shared.rx.get(searchWord: searchWord, isDesc: true)
    }).do(onNext: {[weak self] _ in
      self?._loading.accept(true)
    }).map {[weak self] (items) -> [GithubModel] in
      //最後に得たデータを保存
      self?.items = items
      self?._loading.accept(false)
      return items
    }.bind(to: _updateItems).disposed(by: disposeBag)
  }
}
