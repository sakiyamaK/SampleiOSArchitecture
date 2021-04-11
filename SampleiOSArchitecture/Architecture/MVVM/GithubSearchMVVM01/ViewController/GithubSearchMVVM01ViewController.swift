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

final class GithubSearchMVVM01ViewController: UIViewController {

  @IBOutlet private weak var urlTextField: UITextField!
  @IBOutlet private weak var searchButton: UIButton!

  @IBOutlet private weak var indicator: UIActivityIndicatorView!
  @IBOutlet private weak var tableView: UITableView! {
    didSet {
      tableView.register(GithubTableViewCell.nib, forCellReuseIdentifier: GithubTableViewCell.reuseIdentifier)
    }
  }
  //セルを選択したときに送るストリーム
  //本来はこんな変数用意したくないが、delegateまみれのUIKitとRxSwiftがどうも相性よく書けない...
  private let didSelectRelay: PublishRelay<Int> = .init()
  private var viewModel: GithubSearchMVVM01ViewModel!

  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.isHidden = true
    self.indicator.isHidden = true

    self.setupViewModel()
  }
}

private extension GithubSearchMVVM01ViewController {
  func setupViewModel() {
    viewModel = GithubSearchMVVM01ViewModel(input: self)

    //viewModelから通知がきたら何をするか先に宣言しておく

    viewModel.updateGithubModelsObservable.bind(to: Binder(self){ (vc, _) in
      vc.tableView.reloadData()
    }).disposed(by: rx.disposeBag)

    viewModel.loadingObservable
      .debug()
      .bind(to: Binder(self){ (vc, loading) in
        vc.tableView.isHidden = loading
        vc.indicator.isHidden = !loading
      }).disposed(by: rx.disposeBag)

    viewModel.selectGithubModelObservable
      .bind(to: Binder(self){ (vc, githubModel) in
        Router.showWebMVVM(from: vc, githubModel: githubModel)
      }).disposed(by: rx.disposeBag)
  }
}

//ViewModel内部に通知するパラメータたち
extension GithubSearchMVVM01ViewController: GithubSearchMVVM01ViewModelInput {
  var searchTextObservable: Observable<String?> {
    self.searchButton.rx.tap.map { self.urlTextField.text }
  }
  var didSelectObservable: Observable<Int> {
    self.didSelectRelay.asObservable()
  }
}

extension GithubSearchMVVM01ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.didSelectRelay.accept(indexPath.item)
  }
}

extension GithubSearchMVVM01ViewController: UITableViewDataSource {
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
