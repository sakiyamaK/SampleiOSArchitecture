//
//  ShareDataVIPER01View.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/5/27.
//

import RxCocoa
import RxOptional
import RxSwift
import UIKit

protocol ShareDataVIPER01View: AnyObject {
  var itemsRelay: PublishRelay<[User]> { get }
}

final class ShareDataVIPER01ViewController: UIViewController, ShareDataVIPER01View {
  deinit { DLog() }

  @IBOutlet private var collectionView: UICollectionView! {
    didSet {
      collectionView.collectionViewLayout = layout
      collectionView.register(UserCollectionViewCell.nib, forCellWithReuseIdentifier: UserCollectionViewCell.reuseIdentifier)
      collectionView.dataSource = self
      collectionView.delegate = self
    }
  }

  var layout: UICollectionViewLayout {
    // アイテム(セル)の大きさをグループの大きさと同じにする
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .fractionalHeight(1.0)
    )

    // アイテム設定に大きさを登録してインスタンスを作る
    let item = NSCollectionLayoutItem(layoutSize: itemSize)

    // グループサイズの横幅をコレクションビューの横幅と同じ、高さを44にる
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .absolute(300)
    )
    // グループの水平設定に大きさとアイテムの種類を登録する
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

    // セクションにグループを登録する
    let section = NSCollectionLayoutSection(group: group)

    // レイアウトにセクションを登録する
    let layout = UICollectionViewCompositionalLayout(section: section)
    return layout
  }

  let itemsRelay: PublishRelay<[User]> = .init()

  static func makeFromStoryboard() -> ShareDataVIPER01ViewController {
    let vc = UIStoryboard.loadShareDataVIPER01()
    return vc
  }

  private var presenter: ShareDataVIPER01Presentation!
  func inject(presenter: ShareDataVIPER01Presentation) {
    self.presenter = presenter
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    bind()
    presenter.viewDidLoad()
  }
}

private extension ShareDataVIPER01ViewController {
  func setup() {
    view.backgroundColor = .systemRed
    let buttonItem = UIBarButtonItem(title: "次へ", style: .done, target: self, action: #selector(tapBarButton(_:)))
    navigationItem.rightBarButtonItems = [buttonItem]
  }

  func bind() {
    let disposes: [Disposable] = [
      itemsRelay.bind(to: Binder(self) { vc, _ in
        vc.collectionView.reloadData()
      })
    ]

    rx.disposeBag.insert(disposes)
  }
}

@objc private extension ShareDataVIPER01ViewController {
  func tapBarButton(_ sender: UIResponder) {
    presenter.tapBarButton()
  }
}

extension ShareDataVIPER01ViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: true)
    presenter.didSelectItem(index: indexPath.item)
  }
}

extension ShareDataVIPER01ViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    presenter.items.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserCollectionViewCell.reuseIdentifier, for: indexPath) as? UserCollectionViewCell,
      let item = presenter.items[safe: indexPath.item]
    else {
      fatalError()
    }
    cell.configure(user: item)
    return cell
  }
}
