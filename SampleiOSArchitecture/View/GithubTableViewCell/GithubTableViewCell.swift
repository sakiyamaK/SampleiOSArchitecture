//
//  GithubTableViewCell.swift
//  SampleMVP
//
//  Created by sakiyamaK on 2020/12/28.
//

import UIKit

final class GithubTableViewCell: UITableViewCell {
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet private var urlLabel: UILabel!

  func configure(githubModel: GithubModel) {
    titleLabel.text = githubModel.name
    urlLabel.text = githubModel.urlStr
  }
}
