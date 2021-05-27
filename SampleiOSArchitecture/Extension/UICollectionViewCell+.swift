//
//  UICollectionViewCell+.swift
//  SampleiOSArchitecture
//
//  Created by sakiyamaK on 2021/05/27.
//

import UIKit

extension UICollectionViewCell {
  static var nib: UINib { UINib(nibName: reuseIdentifier, bundle: nil) }
  static var reuseIdentifier: String { String(describing: Self.self) }
}
