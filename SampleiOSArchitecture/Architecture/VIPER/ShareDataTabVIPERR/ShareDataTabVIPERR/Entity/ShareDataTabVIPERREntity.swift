//
//  ShareDataTabVIPERREntity.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/5/27.
//

import Foundation
import RxSwift
import RxCocoa

protocol ShareData {
  var userRelay: PublishRelay<UserProtocol> { get }
}

final class ShareDataImpl: ShareData {
  private var disposeBag = DisposeBag()
  var userRelay: PublishRelay<UserProtocol> = .init()

  private init() {}
  static let shared: ShareDataImpl = .init()
}

protocol UserProtocol {
  var id: Int { get }
  var name: String { get }
  var hasLike: Bool { get }
}

struct User: Decodable, UserProtocol {
  let id: Int
  var name: String
  var hasLike: Bool
}

struct User2: Decodable, UserProtocol {
  let id: Int
  var name: String
  var hasLike: Bool
}

extension User {
  private static var jsonStr: String {
    """
    [
    {
    "id": 1,
    "name": "No.1",
    "hasLike": false
    },
    {
    "id": 2,
    "name": "No.2",
    "hasLike": true
    },
    {
    "id": 3,
    "name": "No.3",
    "hasLike": false
    }
    ]
    """
  }

  static var testData: [User] {
    try! JSONDecoder().decode(
      [User].self,
      from:
        User.jsonStr.data(using: .utf8)!
    )
  }
}

extension User2 {
  private static var jsonStr: String {
    """
    [
    {
    "id": 1,
    "name": "No.1",
    "hasLike": false
    },
    {
    "id": 2,
    "name": "No.2",
    "hasLike": true
    },
    {
    "id": 3,
    "name": "No.3",
    "hasLike": false
    }
    ]
    """
  }

  static var testData: [User2] {
    try! JSONDecoder().decode(
      [User2].self,
      from:
        User2.jsonStr.data(using: .utf8)!
    )
  }
}

typealias ShareDataTabVIPERREntity = User
