import Foundation

protocol __PREFIX__PresenterInput {
}

protocol __PREFIX__PresenterOutput: AnyObject {
}

final class __PREFIX__Presenter: __PREFIX__PresenterInput {

  private weak var view: __PREFIX__PresenterOutput!
  private var model: __PREFIX__ModdelInput!

  init(view: __PREFIX__PresenterOutput, model: __PREFIX__ModdelInput) {
    self.view = view
    self.model = model
  }
}