//
//  Cell.swift
//  SampleiOSArchitecture
//
//  Created by sakiyamaK on 2021/05/27.
//

import UIKit

final class UserCollectionViewCell: UICollectionViewCell {
  @IBOutlet private var titleLabel: UILabel!
  @IBOutlet private var hasLikeView: UIView!

  func configure(user: UserProtocol) {
    titleLabel.text = user.name
    hasLikeView.backgroundColor = user.hasLike ? .systemRed : .systemBlue
  }
}
