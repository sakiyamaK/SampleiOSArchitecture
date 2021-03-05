//
//  GithubSearchVIPERView.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/2/24.
//

import UIKit

//protocolを必ず用意
protocol GithubSearchVIPERView: AnyObject {
  func initView()
  func startLoading()
  func finishLoading()
  func showAlert(error: Error)
  func reloadTable(items: [GithubSearchVIPEREntity])
}

//Viewに関すること以外は何も書かない
//ifやforといった「制御」が入ることがないはず
final class GithubSearchVIPERViewController: UIViewController {

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

  private var presenter: GithubSearchVIPERPresentation!
  func inject(presenter: GithubSearchVIPERPresentation) {
    self.presenter = presenter
  }

  //状態をもつ ただし明確なルールではなさそう Presenter以外なら良いんじゃないか
  private var items: [GithubSearchVIPEREntity] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.viewDidLoad()
  }
}

private extension GithubSearchVIPERViewController {
  @objc func tapSearchButton(_ sender: UIResponder) {
    guard let word = urlTextField.text else { return }
    presenter.tapSearchButton(word: word)
  }
}

//用意したprotocolに準拠させる
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

  func showAlert(error: Error) {
    DispatchQueue.main.async {
      //何か他にControllerで処理することがあるならここに書く
      self.presenter.showAleart(error: error)
    }
  }

  func reloadTable(items: [GithubSearchVIPEREntity]) {
    DispatchQueue.main.async {
      self.items = items
      self.tableView.reloadData()
    }
  }
}

extension GithubSearchVIPERViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let item = items[indexPath.row]
    presenter.selectItem(GithubSearchVIPEREntity: item)
  }
}
extension GithubSearchVIPERViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    items.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: GithubTableViewCell.reuseIdentifier) as! GithubTableViewCell
    let item = items[indexPath.row]
    cell.configure(githubModel: item)
    return cell
  }
}
