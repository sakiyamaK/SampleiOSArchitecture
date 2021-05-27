//
//  ShareDataVIPER03View.swift
//  SampleiOSArchitecture

import RxCocoa
import RxOptional
import RxSwift
import UIKit

protocol ShareDataVIPER03View: AnyObject {
  var itemsRelay: PublishRelay<[User]> { get }
}

final class ShareDataVIPER03ViewController: UIViewController, ShareDataVIPER03View {
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

  let itemsRelay: PublishRelay<[User]> = .init()

  static func makeFromStoryboard() -> ShareDataVIPER03ViewController {
    let vc = UIStoryboard.loadShareDataVIPER03()
    return vc
  }

  private var presenter: ShareDataVIPER03Presentation!
  func inject(presenter: ShareDataVIPER03Presentation) {
    self.presenter = presenter
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    bind()
    presenter.viewDidLoad()
  }
}

private extension ShareDataVIPER03ViewController {
  func setup() {
    view.backgroundColor = .systemGreen
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

extension ShareDataVIPER03ViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: true)
    presenter.didSelectItem(index: indexPath.item)
  }
}

extension ShareDataVIPER03ViewController: UICollectionViewDataSource {
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
