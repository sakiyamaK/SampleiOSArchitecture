//
//  WebMVCViewController.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/3/5.
//

import UIKit
import WebKit

final class WebMVCViewController: UIViewController {

  @IBOutlet private weak var webView: WKWebView!

  private var initUrlStr: String?

  static func makeFromStoryboard(githubModel: GithubModel) -> WebMVCViewController {
    let vc = UIStoryboard.webMVCViewController
    vc.initUrlStr = githubModel.urlStr
    return vc
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    guard let urlStr = initUrlStr, let url = URL(string: urlStr) else {
      return
    }
    webView.load(URLRequest(url: url))
  }
}
