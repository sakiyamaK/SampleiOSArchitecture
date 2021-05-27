//
//  ShareDataVIPER03Presentation.swift
//  SampleiOSArchitecture
//
//  Created by  on 2031/5/27.
//

import Foundation
import NSObject_Rx
import RxSwift

protocol ShareDataVIPER03Presentation: AnyObject {
  func viewDidLoad()
  func didSelectItem(index: Int)

  var items: [User] { get }
}

final class ShareDataVIPER03Presenter {
  private weak var view: ShareDataVIPER03View?
  private let router: ShareDataVIPER03Wireframe
  private let interactor: ShareDataVIPER03Usecase

  deinit { DLog() }

  init(
    view: ShareDataVIPER03View,
    interactor: ShareDataVIPER03Usecase,
    router: ShareDataVIPER03Wireframe
  ) {
    self.view = view
    self.interactor = interactor
    self.router = router
    bind()
  }
}

private extension ShareDataVIPER03Presenter {
  func bind() {
    guard let view = view else { return }
    let disposes: [Disposable] = [
      interactor.itemsObservable.bind(to: view.itemsRelay)
    ]

    disposeBag.insert(disposes)
  }
}

extension ShareDataVIPER03Presenter: ShareDataVIPER03Presentation, HasDisposeBag {
  func viewDidLoad() {
    Observable.just(()).bind(to: interactor.fetchRelay).disposed(by: disposeBag)
  }

  func didSelectItem(index: Int) {
    Observable.just(index).bind(to: interactor.didSelectRelay).disposed(by: disposeBag)
  }

  var items: [User] { interactor.items }
}
