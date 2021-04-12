//
//  WebMVVMView.swift
//  __TARGET__
//
//  Created by  on 2021/3/5.
//

import RxCocoa
import RxSwift
import UIKit
import WebKit

// Viewに関すること以外は何も書かない
// ifやforといった「制御」が入ることがないはず
final class WebMVVMViewController: UIViewController {
  @IBOutlet var webView: WKWebView!

  static func makeFromStoryboard(githubModel: GithubModel) -> WebMVVMViewController {
    let vc = UIStoryboard.webMVVMViewController
    vc.setupViewModel(githubModel: githubModel)
    return vc
  }

  // viewDidLoadしたときに送るストリーム
  private let viewDidLoadRelay: PublishRelay<Void> = .init()
  private var viewModel: WebMVVMViewModel!

  override func viewDidLoad() {
    super.viewDidLoad()
    viewDidLoadRelay.accept(())
  }
}

private extension WebMVVMViewController {
  func setupViewModel(githubModel: GithubModel) {
    // ストリームに流れる初期化パラメータ
    let initParameters = WebMVVMViewModel.InitParameters(githubModel: githubModel)
    viewModel = WebMVVMViewModel(input: self, initParameters: initParameters)

    viewModel.loadObservable.bind(to: Binder(self) { vc, urlRequest in
      vc.webView.load(urlRequest)
    }).disposed(by: rx.disposeBag)
  }
}

extension WebMVVMViewController: WebMVVMViewModelInput {
  var fetch: Observable<Void> { viewDidLoadRelay.asObservable() }
}
