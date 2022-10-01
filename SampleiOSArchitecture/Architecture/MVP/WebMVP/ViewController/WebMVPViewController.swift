//
//  WebMVPView.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/3/5.
//

import UIKit
import WebKit

final class WebMVPViewController: UIViewController {
  private var presenter: WebMVPPresenterInput!

  @IBOutlet private var webView: WKWebView!
    
  func inject(presenter: WebMVPPresenterInput) {
    self.presenter = presenter
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.viewDidLoad()
  }
}

extension WebMVPViewController: WebMVPPresenterOutput {
  func load(request: URLRequest) {
    webView.load(request)
  }
}
