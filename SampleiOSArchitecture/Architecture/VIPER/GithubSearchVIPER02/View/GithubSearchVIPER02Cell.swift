//
//  GithubSearchVIPER02Cell.swift
//  SampleiOSArchitecture
//
//  Created by sakiyamaK on 2021/04/17.
//

import SwiftUI

struct GithubSearchVIPER02Cell: View {
  var githubModel: GithubModel

  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text(githubModel.name).font(.system(size: 21))
        .foregroundColor(.black)
      Text(githubModel.urlStr).font(.system(size: 17))
        .foregroundColor(.black)
      Divider()
        .frame(height: 1)
        .padding(.horizontal, 30)
        .background(Color.gray)
    }.padding()
  }
}

struct GithubSearchVIPER02Cell_Previews: PreviewProvider {
  static var previews: some View {
    GithubSearchVIPER02Cell(githubModel: GithubModel.testData)
      .previewLayout(.fixed(width: 500, height: 100.0))
  }
}
