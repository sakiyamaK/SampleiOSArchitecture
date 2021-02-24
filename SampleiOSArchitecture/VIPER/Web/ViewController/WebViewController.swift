//
//  WebView.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/2/24.
//

import UIKit
import WebKit

protocol WebView: AnyObject {
  func setInitParameters(_ viperEntity: VIPEREntity)
  func loadInitWeb()
}

final class WebViewController: UIViewController {

  @IBOutlet private weak var webView: WKWebView!
  private var initViperEntity: VIPEREntity?

  var presenter: WebPresentation!

  static func makeFromStoryboard() -> WebViewController {
    let vc = UIStoryboard.loadWeb()
    return vc
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.viewDidLoad()
  }
}

extension WebViewController: WebView {
  func setInitParameters(_ viperEntity: VIPEREntity){
    initViperEntity = viperEntity
  }

  func loadInitWeb() {
    guard
      let viperEntity = initViperEntity,
      let url = URL(string: viperEntity.urlStr) else { return }
    self.webView.load(URLRequest(url: url))
  }
}
