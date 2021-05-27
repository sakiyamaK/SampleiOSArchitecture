//
//  ShareDataVIPER02View.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/5/27.
//

import RxCocoa
import RxOptional
import RxSwift
import UIKit

protocol ShareDataVIPER02View: AnyObject {
  var itemsRelay: PublishRelay<[User2]> { get }
}

final class ShareDataVIPER02ViewController: UIViewController, ShareDataVIPER02View {
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
      heightDimension: .absolute(100)
    )
    // グループの水平設定に大きさとアイテムの種類を登録する
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

    // セクションにグループを登録する
    let section = NSCollectionLayoutSection(group: group)

    // レイアウトにセクションを登録する
    let layout = UICollectionViewCompositionalLayout(section: section)
    return layout
  }

  let itemsRelay: PublishRelay<[User2]> = .init()

  static func makeFromStoryboard() -> ShareDataVIPER02ViewController {
    let vc = UIStoryboard.loadShareDataVIPER02()
    return vc
  }

  private var presenter: ShareDataVIPER02Presentation!
  func inject(presenter: ShareDataVIPER02Presentation) {
    self.presenter = presenter
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    bind()
    presenter.viewDidLoad()
  }
}

private extension ShareDataVIPER02ViewController {
  func setup() {
    view.backgroundColor = .systemBlue
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

extension ShareDataVIPER02ViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: true)
    presenter.didSelectItem(index: indexPath.item)
  }
}

extension ShareDataVIPER02ViewController: UICollectionViewDataSource {
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
