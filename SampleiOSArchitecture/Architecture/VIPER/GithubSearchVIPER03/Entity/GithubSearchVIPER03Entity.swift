//
//  GithubSearchVIPER03Entity.swift
//  SampleiOSArchitecture
//
//  Created by  on 2023/5/13.
//

import Foundation

typealias GithubSearchVIPER03GithubEntity = GithubModel
typealias GithubSearchVIPER03QiitaEntity = QiitaModel
typealias GithubSearchVIPER03EntityError = GithubError

struct GithubSearchVIPER03Entity {
    let name: String
    let urlStr: String
}

struct QiitaSearchParameters {
  let searchWord: String?
  private var _searchWord: String { searchWord ?? "" }

  var validation: Bool {
    _searchWord.isNotEmpty
  }

  var queryParameter: String {
    "query=\(_searchWord)"
  }
}
