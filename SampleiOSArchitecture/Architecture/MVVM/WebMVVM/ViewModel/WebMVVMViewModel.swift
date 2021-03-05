import Foundation
import RxSwift
import RxCocoa
import NSObject_Rx

//ViewModelの入力に関するprotocol
protocol WebMVVMViewModelInput {
  var fetch: Observable<Void> { get }
}

//ViewModelの出力に関するprotocol
protocol WebMVVMViewModelOutput {
  var loadObservable: Observable<URLRequest> { get }
}

//制御の全てを書く
//その制御は全てリアクティブであり、最初に全て宣言する宣言型
final class WebMVVMViewModel: WebMVVMViewModelOutput, HasDisposeBag {

  struct InitParameters {
    var githubModel: GithubModel
  }
  /*outputについての記述*/
  //出力側の定型文的な書き方
  private let _loadObservable: PublishRelay<URLRequest> = .init()
  lazy var loadObservable: Observable<URLRequest> = _loadObservable.asObservable()

  init(input: WebMVVMViewModelInput, initParameters: InitParameters) {

    input.fetch.map {_ in initParameters.githubModel}.map { (githubModel) -> URLRequest? in
      guard let url = URL(string: githubModel.urlStr) else { return nil }
      return URLRequest(url: url)
    }.filterNil()
    .bind(to: _loadObservable)
    .disposed(by: disposeBag)
  }
}
