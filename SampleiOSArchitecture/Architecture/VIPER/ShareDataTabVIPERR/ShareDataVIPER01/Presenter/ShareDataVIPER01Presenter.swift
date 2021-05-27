//
//  ShareDataVIPER01Presentation.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/5/27.
//

import Foundation
import NSObject_Rx
import RxSwift

protocol ShareDataVIPER01Presentation: AnyObject {
  func viewDidLoad()
  func tapBarButton()
  func didSelectItem(index: Int)

  var items: [User] { get }
}

final class ShareDataVIPER01Presenter {
  private weak var view: ShareDataVIPER01View?
  private let router: ShareDataVIPER01Wireframe
  private let interactor: ShareDataVIPER01Usecase

  deinit { DLog() }

  init(
    view: ShareDataVIPER01View,
    interactor: ShareDataVIPER01Usecase,
    router: ShareDataVIPER01Wireframe
  ) {
    self.view = view
    self.interactor = interactor
    self.router = router
    bind()
  }
}

private extension ShareDataVIPER01Presenter {
  func bind() {
    guard let view = view else { return }
    let disposes: [Disposable] = [
      interactor.itemsObservable.bind(to: view.itemsRelay)
    ]

    disposeBag.insert(disposes)
  }
}

extension ShareDataVIPER01Presenter: ShareDataVIPER01Presentation, HasDisposeBag {
  func viewDidLoad() {
    Observable.just(()).bind(to: interactor.fetchRelay).disposed(by: disposeBag)
  }

  func didSelectItem(index: Int) {
    Observable.just(index).bind(to: interactor.didSelectRelay).disposed(by: disposeBag)
  }

  func tapBarButton() {
    router.showShareDataVIPER03()
  }

  var items: [User] { interactor.items }
}
