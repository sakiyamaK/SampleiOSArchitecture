//
//  ShareData.swift
//  SampleiOSArchitecture
//
//  Created by sakiyamaK on 2021/05/27.
//

import Foundation
import RxCocoa
import RxSwift

// UserProtocolに準拠したデータを画面間で連動させる

protocol UserProtocol {
  var id: Int { get }
  var name: String { get }
  var hasLike: Bool { get }
}

// 連動させるためのRelayをもつProtocol
protocol ShareData {
  var userRelay: PublishRelay<UserProtocol> { get }
}

// 画面間で連動させるためにシングルトン
final class ShareDataImpl: ShareData {
  private var disposeBag = DisposeBag()
  var userRelay: PublishRelay<UserProtocol> = .init()

  private init() {}
  static let shared: ShareDataImpl = .init()
}
