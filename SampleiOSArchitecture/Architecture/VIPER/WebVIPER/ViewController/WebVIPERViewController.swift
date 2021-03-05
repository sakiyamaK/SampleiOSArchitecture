//
//  WebVIPERView.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/2/24.
//

import UIKit
import WebKit

protocol WebVIPERView: AnyObject {
  func setInitParameters(_ viperEntity: GithubSearchVIPEREntity)
  func fetch()
}

final class WebVIPERViewController: UIViewController {

  @IBOutlet private weak var WebVIPERView: WKWebView!
  private var initViperEntity: GithubSearchVIPEREntity?

  var presenter: WebVIPERPresentation!

  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.viewDidLoad()
  }
}

extension WebVIPERViewController: WebVIPERView {
  func setInitParameters(_ viperEntity: GithubSearchVIPEREntity){
    initViperEntity = viperEntity
  }

  func fetch() {
    guard
      let viperEntity = initViperEntity,
      let url = URL(string: viperEntity.urlStr) else { return }
    self.WebVIPERView.load(URLRequest(url: url))
  }
}
