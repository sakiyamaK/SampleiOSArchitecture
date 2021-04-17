//
//  GithubSearchVIPER02Presentation.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/4/17.
//

import Foundation

protocol GithubSearchVIPER02Presentation: AnyObject {
  func viewDidLoad()
}

final class GithubSearchVIPER02Presenter {
  private weak var view: GithubSearchVIPER02View?
  private let router: GithubSearchVIPER02Wireframe
  private let interactor: GithubSearchVIPER02Usecase

  init(
    view: GithubSearchVIPER02View,
    interactor: GithubSearchVIPER02Usecase,
    router: GithubSearchVIPER02Wireframe
  ) {
    self.view = view
    self.interactor = interactor
    self.router = router
  }
}

extension GithubSearchVIPER02Presenter: GithubSearchVIPER02Presentation {
  func viewDidLoad() {
  }
}