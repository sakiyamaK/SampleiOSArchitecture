//
//  WebVIPERInteractor.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/2/24.
//

import Foundation

struct WebVIPERUsecaseInitParameters {
  var entity: GithubSearchVIPEREntity
}

protocol WebVIPERUsecase {
  func getInitParameters() -> WebVIPERUsecaseInitParameters
}

final class WebVIPERInteractor {

  private var initParameters: WebVIPERUsecaseInitParameters!

  init(initParameters: WebVIPERUsecaseInitParameters) {
    self.initParameters = initParameters
  }
}

extension WebVIPERInteractor: WebVIPERUsecase {
  func getInitParameters() -> WebVIPERUsecaseInitParameters { self.initParameters }
}
