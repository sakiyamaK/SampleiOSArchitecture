//
//  MVPViewController.swift
//  SampleMVP
//
//  Created by sakiyamaK on 2020/12/28.
//

import UIKit

final class GithubSearchMVPViewController: UIViewController {

  @IBOutlet private weak var indicator: UIActivityIndicatorView!
  @IBOutlet private weak var urlTextField: UITextField!

  @IBOutlet private weak var tableView: UITableView! {
    didSet {
      tableView.register(GithubTableViewCell.nib, forCellReuseIdentifier: GithubTableViewCell.reuseIdentifier)
    }
  }
  @IBOutlet private weak var searchButton: UIButton! {
    didSet {
      searchButton.addTarget(self, action: #selector(tapSearchButton(_:)), for: .touchUpInside)
    }
  }

  @objc private func tapSearchButton(_ button: UIButton) {
    guard
      let searchWord = urlTextField.text, searchWord.count > 0
    else { return }
    self.presenter.searchText(searchWord, sortType: true)
  }

  private var presenter: GithubSearchPresenter!
  func inject(presenter: GithubSearchPresenter) {
    self.presenter = presenter
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.isHidden = true
    self.indicator.isHidden = true
  }
}

extension GithubSearchMVPViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    presenter.didSelect(index: indexPath.row)
  }
}

extension GithubSearchMVPViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    presenter.numberOfItems
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: GithubTableViewCell.reuseIdentifier, for: indexPath) as! GithubTableViewCell
    let githubModel = presenter.item(index: indexPath.item)
    cell.configure(githubModel: githubModel)
    return cell
  }
}

extension GithubSearchMVPViewController: GithubSearchPresenterOutput {
  func update(loading: Bool) {
    DispatchQueue.main.async {
      self.tableView.isHidden = loading
      self.indicator.isHidden = !loading
    }
  }

  func update(items: [GithubModel]) {
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }

  func get(error: Error) {
    DispatchQueue.main.async {
      print(error.localizedDescription)
    }
  }
}
