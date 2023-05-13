//
//  GithubSearchVIPER99Store.swift
//  SampleiOSArchitecture
//
//  Created by sakiyamaK on 2021/04/17.
//

import Combine
import UIKit

typealias GithubSearchVIPER99View = GithubSearchVIPER01View

final class GithubSearchVIPER99ViewHelper: ObservableObject {
  @Published var loading: Bool = false
  @Published var items: [GithubSearchVIPER99Entity] = []
  @Published var word: String = ""

  private var presenter: GithubSearchVIPER99Presentation!
  func inject(presenter: GithubSearchVIPER99Presentation) {
    self.presenter = presenter
  }

  func tapSearchButton() {
    presenter.tapSearchButton(word: word)
  }

  func tapCell(indexPath: IndexPath) {
    presenter.selectItem(indexPath: indexPath)
  }
}

extension GithubSearchVIPER99ViewHelper: GithubSearchVIPER99View {
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

  func reloadTable(items: [GithubSearchVIPER99Entity]) {
    DispatchQueue.main.async {
      self.items = items
    }
  }
}
