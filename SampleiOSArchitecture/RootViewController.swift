//
//  ViewController.swift
//  SampleiOSArchitecture
//
//  Created by sakiyamaK on 2021/02/07.
//

import UIKit

class RootViewController: UIViewController {

  @IBOutlet private weak var mvcButton: UIButton!
  @IBOutlet private weak var mvpButton: UIButton!
  @IBOutlet private weak var mvvmButton: UIButton!
  private lazy var buttons: [UIButton] = [mvcButton, mvpButton, mvvmButton]



  override func viewDidLoad() {
    super.viewDidLoad()
    buttons.forEach { $0.addTarget(self, action: #selector(tapButton(_:)), for: .touchUpInside)
    }
  }
}

private extension RootViewController {
  @objc func tapButton(_ sender: UIButton) {
    switch sender {
    case mvcButton:
      Router.showMVC(from: self)
    case mvpButton:
      Router.showMVP(from: self)
    case mvvmButton:
      Router.showMVVM(from: self)
    default:
      break
    }
  }
}

