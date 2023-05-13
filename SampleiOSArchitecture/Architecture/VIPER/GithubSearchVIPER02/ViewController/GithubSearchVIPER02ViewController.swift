//
//  GithubSearchVIPER02View.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/2/24.
//

import UIKit

// protocolを必ず用意
protocol GithubSearchVIPER02View: AnyObject {
    func initView(searchWord: String?)
    func startLoading()
    func finishLoading()
    func reloadTable(items: [GithubSearchVIPER02Entity])
}

// Viewに関すること以外は何も書かない
// ifやforといった「制御」が入ることがないはず
final class GithubSearchVIPER02ViewController: UIViewController {
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

    private var presenter: GithubSearchVIPER02Presentation!
    func inject(presenter: GithubSearchVIPER02Presentation) {
        self.presenter = presenter
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

private extension GithubSearchVIPER02ViewController {
    @objc func tapSearchButton(_ sender: UIResponder) {
        presenter.tapSearchButton(word: urlTextField.text)
    }
}

// 用意したprotocolに準拠させる
extension GithubSearchVIPER02ViewController: GithubSearchVIPER02View {
    func initView(searchWord: String?) {
        DispatchQueue.main.async {
            self.urlTextField.text = searchWord
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

    func reloadTable(items: [GithubSearchVIPER02Entity]) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension GithubSearchVIPER02ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.selectItem(indexPath: indexPath)
    }
}

extension GithubSearchVIPER02ViewController: UITableViewDataSource {
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
