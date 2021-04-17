//
//  GithubSearchVIPER02View.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/4/17.
//

import UIKit

protocol GithubSearchVIPER02View: AnyObject {
}

final class GithubSearchVIPER02ViewController: UIViewController {
  var presenter: GithubSearchVIPER02Presentation!

  static func makeFromStoryboard() -> GithubSearchVIPER02ViewController {
    let vc = UIStoryboard.loadGithubSearchVIPER02()
    return vc
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.viewDidLoad()
  }
}

extension GithubSearchVIPER02ViewController: GithubSearchVIPER02View {
}