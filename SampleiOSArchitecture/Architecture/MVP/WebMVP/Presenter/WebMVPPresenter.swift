import Foundation

protocol WebMVPPresenterInput {
  func viewDidLoaded()
}

protocol WebMVPPresenterOutput: AnyObject {
  func load(request: URLRequest)
}

final class WebMVPPresenter {

  private weak var view: WebMVPPresenterOutput!
  private var githubModel: GithubModel

  init(view: WebMVPPresenterOutput, githubModel: GithubModel) {
    self.view = view
    self.githubModel = githubModel
  }
}


extension WebMVPPresenter: WebMVPPresenterInput {
  func viewDidLoaded() {
    guard let url = URL(string: githubModel.urlStr) else { return }
    self.view.load(request: URLRequest(url: url))
  }
}
