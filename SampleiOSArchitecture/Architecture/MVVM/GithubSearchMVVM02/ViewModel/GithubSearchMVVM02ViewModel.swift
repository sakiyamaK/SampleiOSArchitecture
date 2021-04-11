import Combine

final class GithubSearchMVVM02ViewModel {

  @Published var searchText: String = ""
  @Published var selectIndex: Int?

  @Published private(set) var githubModels: [GithubModel] = []
  @Published private(set) var selectGithubModel: GithubModel?
  @Published private(set) var loading: Bool?

  private var bindings = Set<AnyCancellable>()

  init(api: GithubAPI = GithubAPI.shared) {

    let searchTextPublisher = $searchText
      .compactMap { $0 }
      .removeDuplicates()
      .filter { !$0.isEmpty }
      .eraseToAnyPublisher()

    searchTextPublisher
      .map { GithubSearchParameters(searchWord: $0) }
      .sink {[weak self] in
        guard let self = self else { return }
        self.loading = true
        api.get(parameters: $0).sink { (completion) in
          self.loading = false
          switch completion {
          case .failure(let error):
            print(error.localizedDescription)
          case .finished:
            break
          }
        } receiveValue: {(models) in
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
