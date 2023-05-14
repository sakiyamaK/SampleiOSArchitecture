//
//  GithubSearchVIPER03View.swift
//  SampleiOSArchitecture
//
//  Created by  on 2023/5/13.
//

import UIKit

protocol GithubSearchVIPER03View: AnyObject {
    func initView()
    func startLoading()
    func finishLoading()
    func reloadTable(items: [GithubSearchVIPER03Entity])
}

final class GithubSearchVIPER03ViewController: UIViewController {

    @IBOutlet private var indicator: UIActivityIndicatorView!
    @IBOutlet private var urlTextField: UITextField!

    @IBOutlet private var tableView: UITableView! {
        didSet {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
        }
    }

    @IBOutlet private var searchButton: UIButton! {
        didSet {
            searchButton.addTarget(self, action: #selector(tapSearchButton(_:)), for: .touchUpInside)
        }
    }

    private var presenter: GithubSearchVIPER03Presentation!
    func inject(presenter: GithubSearchVIPER03Presentation) {
        self.presenter = presenter
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

private extension GithubSearchVIPER03ViewController {
    @objc func tapSearchButton(_ sender: UIResponder) {
        presenter.tapSearchButton(word: urlTextField.text)
    }
}

extension GithubSearchVIPER03ViewController: GithubSearchVIPER03View {
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

    func reloadTable(items: [GithubSearchVIPER03Entity]) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension GithubSearchVIPER03ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.selectItem(indexPath: indexPath)
    }
}

extension GithubSearchVIPER03ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.getSearchedItems().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier)!
        let item = presenter.getSearchedItems()[indexPath.row]
        cell.textLabel?.text = item.name
        return cell
    }
}
