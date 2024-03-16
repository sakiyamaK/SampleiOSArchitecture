//
//  WebVIPERInteractor.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/2/24.
//

import Foundation

protocol WebVIPERUsecase {
  var url: URL? { get }
}

final class WebVIPERInteractor {
  struct Dependency {
    var entity: WebVIPEREntity
  }

  let dependency: Dependency!
  init(dependency: Dependency) {
    self.dependency = dependency
  }
}

extension WebVIPERInteractor: WebVIPERUsecase {
  var url: URL? { dependency.entity.url }
}
