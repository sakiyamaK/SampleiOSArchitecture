//
//  UITableViewCell+.swift
//  SampleiOSArchitecture
//
//  Created by sakiyamaK on 2021/02/07.
//

import UIKit

extension UITableViewCell {
  static var nib: UINib { UINib(nibName: reuseIdentifier, bundle: nil) }
  static var reuseIdentifier: String { String(describing: Self.self) }
}
