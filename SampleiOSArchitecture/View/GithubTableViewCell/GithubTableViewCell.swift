//
//  GithubTableViewCell.swift
//  SampleMVP
//
//  Created by sakiyamaK on 2020/12/28.
//

import UIKit

protocol GithubTableViewCellProtocol: AnyObject {
  func tapNext(githubModel: GithubModel)
  func tapCancel(githubModel: GithubModel)
}

final class GithubTableViewCell: UITableViewCell {

  weak var delegate: GithubTableViewCellProtocol?

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet private weak var urlLabel: UILabel!


  private var githubModel: GithubModel?
  // nextButton delegate?.tapNext(self.indexPath, self.githubModel)
  // cancelButton delegate?.tapCancel(self.githubModel)

  func configure(githubModel: GithubModel) {
    titleLabel.text = githubModel.name
    urlLabel.text = githubModel.urlStr

    self.githubModel = githubModel
  }
}
