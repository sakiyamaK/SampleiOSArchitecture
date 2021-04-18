//
//  GithubSearchVIPER02Store.swift
//  SampleiOSArchitecture
//
//  Created by sakiyamaK on 2021/04/17.
//

import Combine
import UIKit

final class GithubSearchVIPER02ViewHelper: ObservableObject {
  @Published var loading: Bool = false
  @Published var items: [GithubSearchVIPER02Entity] = []
  @Published var word: String = ""

  private var presenter: GithubSearchVIPER02Presentation!
  func inject(presenter: GithubSearchVIPER02Presentation) {
    self.presenter = presenter
  }

  func tapSearchButton() {
    presenter.tapSearchButton(word: word)
  }

  func tapCell(indexPath: IndexPath) {
    presenter.selectItem(indexPath: indexPath)
  }
}

extension GithubSearchVIPER02ViewHelper: GithubSearchVIPERView {
  func initView() {}

  func startLoading() {
    DispatchQueue.main.async {
      self.loading = true
    }
  }

  func finishLoading() {
    DispatchQueue.main.async {
      self.loading = false
    }
  }

  func reloadTable(items: [GithubSearchVIPEREntity]) {
    DispatchQueue.main.async {
      self.items = items
    }
  }
}
