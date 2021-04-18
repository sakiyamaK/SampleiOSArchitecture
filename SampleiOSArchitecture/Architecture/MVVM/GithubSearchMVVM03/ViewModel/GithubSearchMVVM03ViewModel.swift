import Combine

// ViewModel(input: GithubSearchMVVM03ViewModelInput, dependency: GithubSearchMVVM03ViewModelDependency)タイプ
// initパラメータの全てがプロトコルになっている
// @PublishedのためにImplな実装がそれぞれ用意されている

protocol GithubSearchMVVM03ViewModelInput {
  var searchText: String { get set }
  var searchTextPublisher: Published<String>.Publisher { get }
  var selectIndex: Int? { get set }
  var selectIndexPublisher: Published<Int?>.Publisher { get }
}

final class GithubSearchMVVM03ViewModelInputImpl: GithubSearchMVVM03ViewModelInput {
  @Published var searchText: String = ""
  var searchTextPublisher: Published<String>.Publisher { $searchText }

  @Published var selectIndex: Int?
  var selectIndexPublisher: Published<Int?>.Publisher { $selectIndex }
}

protocol GithubSearchMVVM03ViewModelDependency {
  var api: GithubAPIProtocol { get }
}

final class GithubSearchMVVM03ViewModelDependencyImpl: GithubSearchMVVM03ViewModelDependency {
  var api: GithubAPIProtocol = GithubAPI.shared
}

protocol GithubSearchMVVM03ViewModelOutput {
  var githubModels: [GithubModel] { get }
  var githubModelsPublisher: Published<[GithubModel]>.Publisher { get }
  var selectGithubModel: GithubModel? { get }
  var selectGithubModelPublisher: Published<GithubModel?>.Publisher { get }
  var loading: Bool? { get }
  var loadingPublisher: Published<Bool?>.Publisher { get }
}

final class GithubSearchMVVM03ViewModelOutputImpl: GithubSearchMVVM03ViewModelOutput {
  @Published private(set) var githubModels: [GithubModel] = []
  var githubModelsPublisher: Published<[GithubModel]>.Publisher { $githubModels }
  @Published private(set) var selectGithubModel: GithubModel?
  var selectGithubModelPublisher: Published<GithubModel?>.Publisher { $selectGithubModel }
  @Published private(set) var loading: Bool?
  var loadingPublisher: Published<Bool?>.Publisher { $loading }

  private var bindings = Set<AnyCancellable>()

  init(input: GithubSearchMVVM03ViewModelInput, dependency: GithubSearchMVVM03ViewModelDependency) {
    let searchTextPublisher = input.searchTextPublisher
      .compactMap { $0 }
      .removeDuplicates()
      .filter { !$0.isEmpty }
      .map { GithubSearchParameters(searchWord: $0) }
      .eraseToAnyPublisher()

    searchTextPublisher
      .sink { [weak self] in
        guard let self = self else { return }
        self.loading = true
        dependency.api.get(parameters: $0).sink { completion in
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

    let selectIndexPublisher = input.selectIndexPublisher
      .compactMap { $0 }
      .map { self.githubModels[$0] }

    selectIndexPublisher
      .sink(receiveValue: { self.selectGithubModel = $0 })
      .store(in: &bindings)
  }
}
