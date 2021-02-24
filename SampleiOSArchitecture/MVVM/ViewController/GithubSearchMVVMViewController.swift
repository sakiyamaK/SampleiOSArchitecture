//
//  File.swift
//  SampleRxSwift
//
//  Created by sakiyamaK on 2020/05/23.
//  Copyright © 2020 sakiyamaK. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxOptional

final class GithubSearchMVVMViewController: UIViewController {

  @IBOutlet private weak var indicator: UIActivityIndicatorView!
  @IBOutlet private weak var urlTextField: UITextField!

  @IBOutlet private weak var tableView: UITableView! {
    didSet {
      tableView.register(GithubTableViewCell.nib, forCellReuseIdentifier: GithubTableViewCell.reuseIdentifier)
    }
  }

  @IBOutlet private weak var searchButton: UIButton!

  private var viewModel: GithubSearchMVVMViewModel!
  private var output: GithubSearchMVVMViewModelOutput!

  override func viewDidLoad() {
    super.viewDidLoad()

    viewModel = GithubSearchMVVMViewModel(input: self)
    output = viewModel

    self.tableView.isHidden = true
    self.indicator.isHidden = true

    bindOutputStream()
  }

  private func bindOutputStream() {
    output.updateItemsObservable.bind(to: Binder(self){ (vc, _) in
      vc.tableView.reloadData()
    }).disposed(by: rx.disposeBag)

    output.loadingObservable
      .debug()
      .bind(to: Binder(self){ (vc, loading) in
        vc.tableView.isHidden = loading
        vc.indicator.isHidden = !loading
      }).disposed(by: rx.disposeBag)
  }
}

extension GithubSearchMVVMViewController: GithubSearchMVVMViewModelInput {
  var searchTextObservable: Observable<String?> {
    self.searchButton.rx.tap.map { self.urlTextField.text }
  }
  var didSelectRelay: BehaviorRelay<Int> {
    .init(value: 0)
  }
}

extension GithubSearchMVVMViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.didSelectRelay.accept(indexPath.item)
  }
}

extension GithubSearchMVVMViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    output.items.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let githubModel = output.items[indexPath.item]
    let cell = tableView.dequeueReusableCell(withIdentifier: GithubTableViewCell.reuseIdentifier, for: indexPath) as! GithubTableViewCell
    cell.configure(githubModel: githubModel)
    return cell
  }
}
