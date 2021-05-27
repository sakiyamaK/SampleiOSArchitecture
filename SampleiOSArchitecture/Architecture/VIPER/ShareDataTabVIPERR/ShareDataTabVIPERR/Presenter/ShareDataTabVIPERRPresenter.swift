//
//  ShareDataTabVIPERRPresentation.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/5/27.
//

import Foundation

protocol ShareDataTabVIPERRPresentation: AnyObject {
  func viewWillAppear()
}

final class ShareDataTabVIPERRPresenter {
  private weak var view: ShareDataTabVIPERRView?
  private let router: ShareDataTabVIPERRWireframe
  private let interactor: ShareDataTabVIPERRUsecase

  init(
    view: ShareDataTabVIPERRView,
    interactor: ShareDataTabVIPERRUsecase,
    router: ShareDataTabVIPERRWireframe
  ) {
    self.view = view
    self.interactor = interactor
    self.router = router
  }
}

extension ShareDataTabVIPERRPresenter: ShareDataTabVIPERRPresentation {
  func viewWillAppear() {
  }
}
