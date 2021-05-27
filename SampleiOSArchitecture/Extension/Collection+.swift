//
//  Array+.swift
//  SampleiOSArchitecture
//
//  Created by sakiyamaK on 2021/05/27.
//

import Foundation

extension Collection {
  subscript(safe index: Index) -> Element? {
    return indices.contains(index) ? self[index] : nil
  }
}
