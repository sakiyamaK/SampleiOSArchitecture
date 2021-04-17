//
//  GithubSearchVIPER02.swift
//  SampleiOSArchitecture
//
//  Created by sakiyamaK on 2021/04/17.
//

import SwiftUI

struct GithubSearchVIPER02View: View {
  @ObservedObject var store: GithubSearchVIPER02Store

  var body: some View {
    VStack {
      HStack {
        TextField("", text: $store.word)
          .textFieldStyle(RoundedBorderTextFieldStyle())
        Button(action: {
          store.tapSearchButton()
        }, label: {
          Image(systemName: "magnifyingglass")
        })
      }
      .padding(.init(top: 8, leading: 16, bottom: 8, trailing: 16))
      if store.loading {
        ActivityIndicatorView(isAnimating: .constant(true), style: .large)
      } else if !store.items.isEmpty {
        ForEach(Array(store.items.enumerated()), id: \.offset) { offset, element in
          Button(action: {
            store.tapCell(indexPath: IndexPath(item: offset, section: 0))
          }, label: {
            GithubSearchVIPER02Cell(githubModel: element)
          })
        }
      }
    }
    Spacer().frame(maxHeight: .infinity)
  }
}

struct GithubSearchVIPER02View_Previews: PreviewProvider {
  static var previews: some View {
    return GithubSearchVIPER02Router.assembleModules()
  }
}
