//
//  ShareDataVIPER03Interactor.swift
//  SampleiOSArchitecture
//
//  Created by  on 2031/5/27.
//

import Foundation
import NSObject_Rx
import RxCocoa
import RxOptional
import RxSwift

protocol ShareDataVIPER03Usecase {
  var fetchRelay: PublishRelay<Void> { get }
  var didSelectRelay: PublishRelay<Int> { get }

  var items: [User] { get }
  var itemsObservable: Observable<[User]> { get }
}

final class ShareDataVIPER03Interactor: ShareDataVIPER03Usecase, HasDisposeBag {
  var fetchRelay: PublishRelay<Void> = .init()
  var didSelectRelay: PublishRelay<Int> = .init()

  private let _items: BehaviorRelay<[User]> = .init(value: [])
  lazy var itemsObservable: Observable<[User]> = _items.asObservable()
  var items: [User] { _items.value }

  deinit { DLog() }

  init(shareData: ShareData = ShareDataImpl.shared) {
    let inputDisposes: [Disposable] = [
      fetchRelay.asObservable().map { _ -> [User] in User.testData }.bind(to: _items),
      didSelectRelay.asObservable().bind(to: Binder(self) { interactor, idx in
        guard var item = interactor.items[safe: idx] else { return }
        item.hasLike.toggle()
        shareData.userRelay.accept(item)
      }),
      shareData.userRelay.asObservable().bind(to: Binder(self) { interactor, user in
        var items = interactor.items
        items = items.map {
          if $0.id == user.id {
            var newItem = $0
            newItem.name = user.name
            newItem.hasLike = user.hasLike
            return newItem
          }
          return $0
        }
        interactor._items.accept(items)
      })
    ]

    disposeBag.insert(inputDisposes)
  }
}
