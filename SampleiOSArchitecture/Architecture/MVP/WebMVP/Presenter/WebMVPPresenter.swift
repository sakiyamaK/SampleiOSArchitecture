import Foundation

protocol WebMVPPresenterInput {
  func viewDidLoad()
}

protocol WebMVPPresenterOutput: AnyObject {
  func load(request: URLRequest)
}

final class WebMVPPresenter {
  private weak var output: WebMVPPresenterOutput!
  private var githubModel: GithubModel

  init(output: WebMVPPresenterOutput, githubModel: GithubModel) {
    self.output = output
    self.githubModel = githubModel
  }
}

extension WebMVPPresenter: WebMVPPresenterInput {
  func viewDidLoad() {
    guard let url = URL(string: githubModel.urlStr) else { return }
    output.load(request: URLRequest(url: url))
  }
}
