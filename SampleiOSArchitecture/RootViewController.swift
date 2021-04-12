//
//  ViewController.swift
//  SampleiOSArchitecture
//
//  Created by sakiyamaK on 2021/02/07.
//

import UIKit

class RootViewController: UIViewController {
  @IBOutlet private var mvcButton: UIButton!
  @IBOutlet private var mvpButton: UIButton!
  @IBOutlet private var mvvm01Button: UIButton!
  @IBOutlet private var mvvm02Button: UIButton!
  @IBOutlet var mvvm03Button: UIButton!
  @IBOutlet private var viperButton: UIButton!

  private lazy var buttons: [UIButton] =
    [mvcButton, mvpButton, mvvm01Button, mvvm02Button, mvvm03Button, viperButton]

  override func viewDidLoad() {
    super.viewDidLoad()
    buttons.forEach {
      $0.addTarget(self, action: #selector(tapButton(_:)), for: .touchUpInside)
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
    case mvvm01Button:
      Router.showMVVM01(from: self)
    case mvvm02Button:
      Router.showMVVM02(from: self)
    case mvvm03Button:
      Router.showMVVM03(from: self)
    case viperButton:
      Router.showVIPER(from: self)
    default:
      break
    }
  }
}
