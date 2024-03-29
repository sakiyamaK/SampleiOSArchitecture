//
//  File.swift
//  SampleRxSwift
//
//  Created by sakiyamaK on 2020/05/23.
//  Copyright © 2020 sakiyamaK. All rights reserved.
//

import UIKit

final class GithubSearchMVC01ViewController: UIViewController {
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

    private var githubModels: [GithubModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.isHidden = true
        tableView.isHidden = true
    }
}

@objc private extension GithubSearchMVC01ViewController {
    func tapSearchButton(_ button: UIButton) {
        guard
            let searchWord = urlTextField.text, !searchWord.isEmpty
        else { return }
        // リロード
        reload(searchWord: searchWord)
    }
}

private extension GithubSearchMVC01ViewController {
    // APIを叩いてテーブルをリロードするメソッド
    func reload(searchWord: String) {
        tableView.isHidden = true
        indicator.isHidden = false
        let parameters = GithubSearchParameters(searchWord: searchWord)
        GithubAPI.shared.get(parameters: parameters) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(models):
                    // APIからのデータを保存
                    self?.githubModels = models

                    self?.tableView.isHidden = false
                    self?.indicator.isHidden = true
                    // テーブルのリロード
                    self?.tableView.reloadData()

                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

extension GithubSearchMVC01ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let githubModel = githubModels[indexPath.item]
        Router.showWebMVC(from: self, githubModel: githubModel)
    }
}

extension GithubSearchMVC01ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        githubModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let githubModel = githubModels[indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: GithubTableViewCell.reuseIdentifier, for: indexPath) as! GithubTableViewCell
        cell.configure(githubModel: githubModel)
        return cell
    }
}
