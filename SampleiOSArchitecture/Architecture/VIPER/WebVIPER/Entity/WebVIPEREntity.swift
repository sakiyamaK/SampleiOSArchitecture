//
//  WebVIPEREntity.swift
//  SampleiOSArchitecture
//
//  Created by sakiyamaK on 2023/05/13.
//

import Foundation

struct WebVIPEREntity {
    let urlStr: String
    var url: URL? { URL(string: urlStr) }
}
