//
//  GithubSearchVIPERView.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/2/24.
//

import UIKit

// protocolを必ず用意
protocol GithubSearchVIPERView: AnyObject {
  func initView()
  func startLoading()
  func finishLoading()
  func reloadTable(items: [GithubSearchVIPEREntity])
}

// Viewに関すること以外は何も書かない
// ifやforといった「制御」が入ることがないはず
final class GithubSearchVIPERViewController: UIViewController {
  @IBOutlet private var indicator: UIActivityIndicatorView!
  @IBOutlet private var urlTextField: UITextField!

  @IBOutlet private var tableView: UITableView! {
    didSet {
      tableView.register(GithubTableViewCell.nib, forCellReuseIdentifier: GithubTableViewCell.reuseIdentifier)
    }
  }

  @IBOutlet private var searchButton: UIButton! {
    didSet {
      searchButton.addTarget(self, action: #selector(tapSearchButton(_:)), for: .touchUpInside)
    }
  }

  private var presenter: GithubSearchVIPERPresentation!
  func inject(presenter: GithubSearchVIPERPresentation) {
    self.presenter = presenter
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.viewDidLoad()
  }
}

private extension GithubSearchVIPERViewController {
  @objc func tapSearchButton(_ sender: UIResponder) {
    presenter.tapSearchButton(word: urlTextField.text)
  }
}

// 用意したprotocolに準拠させる
extension GithubSearchVIPERViewController: GithubSearchVIPERView {
  func initView() {
    DispatchQueue.main.async {
      self.tableView.isHidden = true
      self.indicator.isHidden = true
    }
  }

  func startLoading() {
    DispatchQueue.main.async {
      self.tableView.isHidden = true
      self.indicator.isHidden = false
    }
  }

  func finishLoading() {
    DispatchQueue.main.async {
      self.tableView.isHidden = false
      self.indicator.isHidden = true
    }
  }

  func reloadTable(items: [GithubSearchVIPEREntity]) {
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
}

extension GithubSearchVIPERViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    presenter.selectItem(indexPath: indexPath)
  }
}

extension GithubSearchVIPERViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    presenter.getSearchedItems().count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: GithubTableViewCell.reuseIdentifier) as! GithubTableViewCell
    let item = presenter.getSearchedItems()[indexPath.row]
    cell.configure(githubModel: item)
    return cell
  }
}
