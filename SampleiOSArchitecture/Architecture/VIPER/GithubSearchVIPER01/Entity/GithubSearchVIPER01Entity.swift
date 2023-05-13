//
//  GithubSearchVIPER01Entity.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/2/24.
//

import Foundation

// Entityは画面ごとにひとつのものではないので無理に1:1で用意しなくてもいい
// 今回は対応を分かりやすくするためGithubSearchVIPER01Entityを用意した
// 実態は他のアーキテクチャで使っているModelなど
typealias GithubSearchVIPER01EntityResponse = GithubResponse
typealias GithubSearchVIPER01Entity = GithubModel
typealias GithubSearchVIPER01EntityError = GithubError
