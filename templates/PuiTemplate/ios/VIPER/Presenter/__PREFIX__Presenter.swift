//
//  __PREFIX__Presentation.swift
//  __TARGET__
//
//  Created by __USERNAME__ on __YEAR__/__MONTH__/__DAY__.
//

import Foundation

protocol __PREFIX__Presentation: AnyObject {
  func viewDidLoad()
}

final class __PREFIX__Presenter {
  private weak var view: __PREFIX__View?
  private let router: __PREFIX__Wireframe
  private let interactor: __PREFIX__Usecase

  init(
    view: __PREFIX__View,
    interactor: __PREFIX__Usecase,
    router: __PREFIX__Wireframe
  ) {
    self.view = view
    self.interactor = interactor
    self.router = router
  }
}

extension __PREFIX__Presenter: __PREFIX__Presentation {
  func viewDidLoad() {
  }
}