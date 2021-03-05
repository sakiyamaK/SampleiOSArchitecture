//
//  __PREFIX__View.swift
//  __TARGET__
//
//  Created by __USERNAME__ on __YEAR__/__MONTH__/__DAY__.
//

import UIKit

final class __PREFIX__ViewController: UIViewController {
  private var presenter: __PREFIX__Presenter!
  func inject(presenter: __PREFIX__Presenter) {
    self.presenter = presenter
  }
}