//
//  ViewController.swift
//  SampleiOSArchitecture
//
//  Created by sakiyamaK on 2021/02/07.
//

import UIKit

final class RootViewController: UIViewController {
  enum SegueButton: String, CaseIterable {
    case mvc, mvp, mvvm01, mvvm02, mvvm03, viper01, viper02, shareDataViper

    var button: UIButton {
      let button = UIButton()
      button.setTitle(rawValue, for: .normal)
      button.setTitleColor(.systemBlue, for: .normal)
      button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
      return button
    }

    func segue(from: UIViewController) {
      switch self {
      case SegueButton.mvc:
        Router.showMVC(from: from)
      case SegueButton.mvp:
        Router.showMVP(from: from)
      case SegueButton.mvvm01:
        Router.showMVVM01(from: from)
      case SegueButton.mvvm02:
        Router.showMVVM02(from: from)
      case SegueButton.mvvm03:
        Router.showMVVM03(from: from)
      case SegueButton.viper01:
        Router.showVIPER(from: from)
      case SegueButton.viper02:
        Router.showVIPER02(from: from)
      case SegueButton.shareDataViper:
        Router.showShareDataVIPER(from: from)
      }
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .fillEqually
    view.addSubview(stackView)

    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
    view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true

    SegueButton.allCases.map { $0.button }.forEach { button in
      stackView.addArrangedSubview(button)
    }
  }
}

private extension RootViewController {
  @objc func tapButton(_ sender: UIButton) {
    guard let text = sender.titleLabel?.text else { return }
    SegueButton(rawValue: text)?.segue(from: self)
  }
}
