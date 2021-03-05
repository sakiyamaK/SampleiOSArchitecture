//
//  __PREFIX__View.swift
//  __TARGET__
//
//  Created by __USERNAME__ on __YEAR__/__MONTH__/__DAY__.
//

import UIKit
import RxSwift
import RxCocoa

final class __PREFIX__ViewController: UIViewController {

  private var viewModel: __PREFIX__ViewModel!
  private let disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupViewModel()
  }
}

private extension __PREFIX__ViewController {
  func setupViewModel() {
    viewModel = .init(
      input: __PREFIX__ViewModel.Input(),
      depedency: __PREFIX__ViewModel.Depedency()
    )
  }
}