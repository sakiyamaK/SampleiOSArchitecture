//
//  GithubSearchVIPER99.swift
//  SampleiOSArchitecture
//
//  Created by sakiyamaK on 2021/04/17.
//

import SwiftUI

struct GithubSearchVIPER99ViewSwiftUI: View {
  @ObservedObject var viewHelper: GithubSearchVIPER99ViewHelper

  var body: some View {
    VStack {
      HStack {
        TextField("", text: $viewHelper.word)
          .textFieldStyle(RoundedBorderTextFieldStyle())
        Button(action: {
          viewHelper.tapSearchButton()
        }, label: {
          Image(systemName: "magnifyingglass")
        })
      }
      .padding(.init(top: 8, leading: 16, bottom: 8, trailing: 16))
      if viewHelper.loading {
        ActivityIndicatorView(isAnimating: .constant(true), style: .medium)
      } else if !$viewHelper.items.isEmpty {
        ScrollView {
          ForEach(Array(viewHelper.items.enumerated()), id: \.offset) { offset, element in
            Button(action: {
              viewHelper.tapCell(indexPath: IndexPath(item: offset, section: 0))
            }, label: {
              GithubSearchVIPER99Cell(githubModel: element)
            })
          }
        }
        .layoutPriority(10)
      }
      Spacer()
        .frame(maxHeight: .infinity)
    }
  }
}

struct GithubSearchVIPER99View_Previews: PreviewProvider {
  static var previews: some View {
    return GithubSearchVIPER99Router.assembleModules()
  }
}
