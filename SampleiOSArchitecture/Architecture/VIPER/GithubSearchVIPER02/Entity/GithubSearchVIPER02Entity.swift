//
//  GithubSearchVIPEREntity.swift
//  SampleiOSArchitecture
//
//  Created by  on 2021/2/24.
//

import Foundation

// Entityは画面ごとにひとつのものではないので無理に1:1で用意しなくてもいい
// 今回は対応を分かりやすくするためGithubSearchVIPEREntityを用意した
// 実態は他のアーキテクチャで使っているModelなど
typealias GithubSearchVIPER02EntityResponse = GithubResponse
typealias GithubSearchVIPER02Entity = GithubModel
typealias GithubSearchVIPER02EntityError = GithubError
