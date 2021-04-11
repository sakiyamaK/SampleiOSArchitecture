//
//  GithubSearchMVVM02View.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/4/8.
//

import UIKit
import Combine
import CombineCocoa

final class GithubSearchMVVM02ViewController: UIViewController {

  private var viewModel: GithubSearchMVVM02ViewModel!
  private var bindings = Set<AnyCancellable>()

  @IBOutlet private weak var urlTextField: UITextField!
  @IBOutlet private weak var searchButton: UIButton!

  @IBOutlet private weak var indicator: UIActivityIndicatorView!
  @IBOutlet private weak var tableView: UITableView! {
    didSet {
      tableView.register(GithubTableViewCell.nib, forCellReuseIdentifier: GithubTableViewCell.reuseIdentifier)
    }
  }

  static func makeFromStoryboard() -> GithubSearchMVVM02ViewController {
    let vc = UIStoryboard.githubSearchMVVM02ViewController
    vc.viewModel = .init()
    return vc
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.isHidden = true
    self.indicator.isHidden = true
    setupViewModel()
  }
}

private extension GithubSearchMVVM02ViewController {
  func setupViewModel() {

    searchButton.tapPublisher
      .compactMap { self.urlTextField.text }
      .assign(to: \.searchText, on: viewModel)
      .store(in: &bindings)

    viewModel.$loading
      .receive(on: RunLoop.main)
      .compactMap { $0 }
      .sink(receiveValue: {[weak self] loading in
        self?.tableView.isHidden = loading
        self?.indicator.isHidden = !loading
      }).store(in: &bindings)

    viewModel.$githubModels
      .receive(on: RunLoop.main)
      .sink {[weak self] _ in
        self?.tableView.reloadData()
      }.store(in: &bindings)

    viewModel.$selectGithubModel
      .receive(on: RunLoop.main)
      .compactMap{ $0 }
      .sink {[weak self] githubModel in
        guard let self = self else { return }
        Router.showWebMVVM(from: self, githubModel: githubModel)
      }.store(in: &bindings)
  }
}


extension GithubSearchMVVM02ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    viewModel.selectIndex = indexPath.item
  }
}

extension GithubSearchMVVM02ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.githubModels.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let githubModel = viewModel.githubModels[indexPath.item]
    let cell = tableView.dequeueReusableCell(withIdentifier: GithubTableViewCell.reuseIdentifier, for: indexPath) as! GithubTableViewCell
    cell.configure(githubModel: githubModel)
    return cell
  }
}
