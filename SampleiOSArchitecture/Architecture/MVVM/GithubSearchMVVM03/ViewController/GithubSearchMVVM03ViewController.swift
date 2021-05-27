//
//  GithubSearchMVVM03View.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/4/13.
//

import Combine
import CombineCocoa
import UIKit

final class GithubSearchMVVM03ViewController: UIViewController {
  private let dependency: GithubSearchMVVM03ViewModelDependency = GithubSearchMVVM03ViewModelDependencyImpl()
  private var input: GithubSearchMVVM03ViewModelInput = GithubSearchMVVM03ViewModelInputImpl()
  private var output: GithubSearchMVVM03ViewModelOutput!
  private var bindings = Set<AnyCancellable>()

  @IBOutlet private var urlTextField: UITextField!
  @IBOutlet private var searchButton: UIButton!

  @IBOutlet private var indicator: UIActivityIndicatorView!
  @IBOutlet private var tableView: UITableView! {
    didSet {
      tableView.register(GithubTableViewCell.nib, forCellReuseIdentifier: GithubTableViewCell.reuseIdentifier)
    }
  }

  static func makeFromStoryboard() -> GithubSearchMVVM03ViewController {
    let vc = UIStoryboard.githubSearchMVVM03ViewController
    vc.output = GithubSearchMVVM03ViewModelOutputImpl(input: vc.input, dependency: vc.dependency)
    return vc
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.isHidden = true
    indicator.isHidden = true
    setupViewModel()
  }
}

private extension GithubSearchMVVM03ViewController {
  func setupViewModel() {
    searchButton.tapPublisher
      .compactMap { self.urlTextField.text }
      .sink(receiveValue: { [weak self] text in self?.input.searchText = text })
      .store(in: &bindings)

    output.githubModelsPublisher
      .receive(on: RunLoop.main)
      .sink { [weak self] _ in
        self?.tableView.reloadData()
      }.store(in: &bindings)

    output.loadingPublisher
      .receive(on: RunLoop.main)
      .compactMap { $0 }
      .sink(receiveValue: { [weak self] loading in
        self?.tableView.isHidden = loading
        self?.indicator.isHidden = !loading
      }).store(in: &bindings)

    output.selectGithubModelPublisher
      .receive(on: RunLoop.main)
      .compactMap { $0 }
      .sink { [weak self] githubModel in
        guard let self = self else { return }
        Router.showWebMVVM(from: self, githubModel: githubModel)
      }.store(in: &bindings)
  }
}

extension GithubSearchMVVM03ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    input.selectIndex = indexPath.item
  }
}

extension GithubSearchMVVM03ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    output.githubModels.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let githubModel = output.githubModels[indexPath.item]
    let cell = tableView.dequeueReusableCell(withIdentifier: GithubTableViewCell.reuseIdentifier, for: indexPath) as! GithubTableViewCell
    cell.configure(githubModel: githubModel)
    return cell
  }
}
