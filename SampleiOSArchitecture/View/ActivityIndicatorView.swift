//
//  ActivityIndicatorView.swift
//  SampleiOSArchitecture
//
//  Created by sakiyamaK on 2021/04/17.
//

import SwiftUI

struct ActivityIndicatorView: UIViewRepresentable {
  typealias UIViewType = UIActivityIndicatorView

  @Binding var isAnimating: Bool
  let style: UIActivityIndicatorView.Style

  func makeUIView(context: UIViewRepresentableContext<ActivityIndicatorView>) -> ActivityIndicatorView.UIViewType {
    UIActivityIndicatorView(style: style)
  }

  func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicatorView>) {
    isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
  }
}
