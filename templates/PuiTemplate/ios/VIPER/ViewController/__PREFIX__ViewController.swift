//
//  __PREFIX__View.swift
//  __TARGET__
//
//  Created by __USERNAME__ on __YEAR__/__MONTH__/__DAY__.
//

import UIKit

protocol __PREFIX__View: AnyObject {
}

final class __PREFIX__ViewController: UIViewController {
  var presenter: __PREFIX__Presentation!

  static func makeFromStoryboard() -> __PREFIX__ViewController {
    let vc = UIStoryboard.load__PREFIX__()
    return vc
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.viewDidLoad()
  }
}

extension __PREFIX__ViewController: __PREFIX__View {
}