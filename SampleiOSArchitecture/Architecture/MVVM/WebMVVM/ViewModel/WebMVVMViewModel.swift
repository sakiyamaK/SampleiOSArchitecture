import Foundation
import RxSwift
import RxCocoa
import NSObject_Rx

//ViewModelの入力に関するprotocol
protocol WebMVVMViewModelInput {
  var githubModel: BehaviorRelay<GithubModel> { get }
}

//ViewModelの出力に関するprotocol
protocol WebMVVMViewModelOutput {
  var loadObservable: Observable<URLRequest> { get }
}


final class WebMVVMViewModel: WebMVVMViewModelOutput, HasDisposeBag {

  /*outputについての記述*/
  //出力側の定型文的な書き方
  private let _loadObservable: PublishRelay<URLRequest> = .init()
  lazy var loadObservable: Observable<URLRequest> = _loadObservable.asObservable()


  init(input: WebMVVMViewModelInput) {

    input.githubModel.map { (githubModel) -> URLRequest? in
      guard let url = URL(string: githubModel.urlStr) else { return nil }
      return URLRequest(url: url)
    }.filterNil()
    .bind(to: _loadObservable)
    .disposed(by: disposeBag)
  }
}
