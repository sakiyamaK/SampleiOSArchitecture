//
//  VIPERView.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/2/24.
//

import UIKit

protocol VIPERView: AnyObject {
  func initView()
  func startLoading()
  func finishLoading()
  func showAlert(error: Error)
  func reloadTable(items: [VIPEREntity])
}

final class VIPERViewController: UIViewController {

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

  var presenter: VIPERPresentation!

  private var items: [VIPEREntity] = []

  static func makeFromStoryboard() -> VIPERViewController {
    let vc = UIStoryboard.loadVIPER()
    return vc
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.viewDidLoad()
  }
}

private extension VIPERViewController {
  @objc func tapSearchButton(_ sender: UIResponder) {
    guard let word = urlTextField.text else { return }
    presenter.search(word: word)
  }
}

extension VIPERViewController: VIPERView {
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

  func reloadTable(items: [VIPEREntity]) {
    DispatchQueue.main.async {
      self.items = items
      self.tableView.reloadData()
    }
  }
}

extension VIPERViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let item = items[indexPath.row]
    presenter.showWeb(viperEntity: item)
  }
}
extension VIPERViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: GithubTableViewCell.reuseIdentifier) as! GithubTableViewCell
    let item = items[indexPath.row]
    cell.configure(githubModel: item)
    return cell
  }
}
