//
//  ShareDataVIPER02Presentation.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/5/27.
//

import Foundation
import NSObject_Rx
import RxSwift

protocol ShareDataVIPER02Presentation: AnyObject {
  func viewDidLoad()
  func didSelectItem(index: Int)

  var items: [User2] { get }
}

final class ShareDataVIPER02Presenter {
  private weak var view: ShareDataVIPER02View?
  private let router: ShareDataVIPER02Wireframe
  private let interactor: ShareDataVIPER02Usecase

  deinit { DLog() }

  init(
    view: ShareDataVIPER02View,
    interactor: ShareDataVIPER02Usecase,
    router: ShareDataVIPER02Wireframe
  ) {
    self.view = view
    self.interactor = interactor
    self.router = router
    bind()
  }
}

private extension ShareDataVIPER02Presenter {
  func bind() {
    guard let view = view else { return }
    let disposes: [Disposable] = [
      interactor.itemsObservable.bind(to: view.itemsRelay)
    ]

    disposeBag.insert(disposes)
  }
}

extension ShareDataVIPER02Presenter: ShareDataVIPER02Presentation, HasDisposeBag {
  func viewDidLoad() {
    Observable.just(()).bind(to: interactor.fetchRelay).disposed(by: disposeBag)
  }

  func didSelectItem(index: Int) {
    Observable.just(index).bind(to: interactor.didSelectRelay).disposed(by: disposeBag)
  }

  var items: [User2] { interactor.items }
}
