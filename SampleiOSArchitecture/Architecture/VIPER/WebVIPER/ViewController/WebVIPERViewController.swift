//
//  WebVIPERView.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/2/24.
//

import UIKit
import WebKit

protocol WebVIPERView: AnyObject {
  func fetch(url: URL)
}

final class WebVIPERViewController: UIViewController {
  @IBOutlet private var webVIPERView: WKWebView!

  private var presenter: WebVIPERPresentation!
  func inject(presenter: WebVIPERPresentation) {
    self.presenter = presenter
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.viewDidLoad()
  }
}

extension WebVIPERViewController: WebVIPERView {
  func fetch(url: URL) {
    webVIPERView.load(URLRequest(url: url))
  }
}
