import Combine

// ViewModel: GithubSearchMVVM02ViewModelInput, GithubSearchMVVM02ViewModelOutput タイプ

protocol GithubSearchMVVM02ViewModelInput {
  var searchText: String { get set }
  var selectIndex: Int? { get set }
}

protocol GithubSearchMVVM02ViewModelOutput {
  var githubModels: [GithubModel] { get }
  var githubModelsPublisher: Published<[GithubModel]>.Publisher { get }
  var selectGithubModel: GithubModel? { get }
  var selectGithubModelPublisher: Published<GithubModel?>.Publisher { get }
  var loading: Bool? { get }
  var loadingPublisher: Published<Bool?>.Publisher { get }
}

final class GithubSearchMVVM02ViewModel: GithubSearchMVVM02ViewModelInput, GithubSearchMVVM02ViewModelOutput {
  @Published var searchText: String = ""
  @Published var selectIndex: Int?

  @Published private(set) var githubModels: [GithubModel] = []
  var githubModelsPublisher: Published<[GithubModel]>.Publisher { $githubModels }
  @Published private(set) var selectGithubModel: GithubModel?
  var selectGithubModelPublisher: Published<GithubModel?>.Publisher { $selectGithubModel }
  @Published private(set) var loading: Bool?
  var loadingPublisher: Published<Bool?>.Publisher { $loading }

  private var bindings = Set<AnyCancellable>()

  init(api: GithubAPI = GithubAPI.shared) {
    let searchTextPublisher = $searchText
      .compactMap { $0 }
      .removeDuplicates()
      .filter { !$0.isEmpty }
      .map { GithubSearchParameters(searchWord: $0) }
      .eraseToAnyPublisher()

    searchTextPublisher
      .sink { [weak self] in
        guard let self = self else { return }
        self.loading = true
        api.get(parameters: $0).sink { completion in
          self.loading = false
          switch completion {
          case let .failure(error):
            print(error.localizedDescription)
          case .finished:
            break
          }
        } receiveValue: { models in
          self.loading = false
          self.githubModels = models
        }.store(in: &self.bindings)
      }.store(in: &bindings)

    let selectIndexPublisher = $selectIndex
      .compactMap { $0 }
      .map { self.githubModels[$0] }

    selectIndexPublisher
      .sink(receiveValue: { self.selectGithubModel = $0 })
      .store(in: &bindings)
  }
}
