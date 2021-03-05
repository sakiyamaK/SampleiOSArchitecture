//
//  WebMVVMView.swift
//  __TARGET__
//
//  Created by  on 2021/3/5.
//

import UIKit
import WebKit
import RxSwift
import RxCocoa

final class WebMVVMViewController: UIViewController {

  private var viewModel: WebMVVMViewModel!
  private var initGitHubModel: GithubModel!

  @IBOutlet weak var webView: WKWebView!

  static func makeFromStoryboard(githubModel: GithubModel) -> WebMVVMViewController {
    let vc = UIStoryboard.webMVVMViewController
    vc.initGitHubModel = githubModel
    vc.setupViewModel(githubModel: githubModel)
    return vc
  }
}

private extension WebMVVMViewController {
  func setupViewModel(githubModel: GithubModel) {
    viewModel = WebMVVMViewModel(input: self)
    viewModel.loadObservable.bind(to: Binder(self){ (vc, urlRequest) in
      vc.webView.load(urlRequest)
    }).disposed(by: rx.disposeBag)
  }
}

extension WebMVVMViewController: WebMVVMViewModelInput {
  var githubModel: BehaviorRelay<GithubModel> { .init(value: initGitHubModel) }
}
