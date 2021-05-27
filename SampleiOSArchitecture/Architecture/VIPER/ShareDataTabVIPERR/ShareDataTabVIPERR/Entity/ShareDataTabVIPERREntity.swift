//
//  ShareDataTabVIPERREntity.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/5/27.
//

import Foundation
import RxCocoa
import RxSwift

struct User: Decodable, UserProtocol, Equatable {
  let id: Int
  var name: String
  var hasLike: Bool
}

struct User2: Decodable, UserProtocol, Equatable {
  let id: Int
  var name: String
  var hasLike: Bool
}

private var jsonStr: String {
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
  },
  {
  "id": 4,
  "name": "No.4",
  "hasLike": true
  },
  {
  "id": 5,
  "name": "No.5",
  "hasLike": false
  },
  {
  "id": 6,
  "name": "No.6",
  "hasLike": true
  },
  {
  "id": 7,
  "name": "No.7",
  "hasLike": false
  },
  {
  "id": 8,
  "name": "No.8",
  "hasLike": true
  }
  ]
  """
}

extension User {
  static var testData: [User] {
    try! JSONDecoder().decode(
      [User].self,
      from: jsonStr.data(using: .utf8)!
    )
  }
}

extension User2 {
  static var testData: [User2] {
    try! JSONDecoder().decode(
      [User2].self,
      from: jsonStr.data(using: .utf8)!
    )
  }
}

typealias ShareDataTabVIPERREntity = User
