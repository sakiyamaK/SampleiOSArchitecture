import UIKit

extension UIStoryboard {

  static var rootViewController: RootViewController {
    UIStoryboard(name: "Root", bundle: nil).instantiateInitialViewController() as! RootViewController
  }

  static var mvcViewController: GithubSearchMVCViewController {
    UIStoryboard(name: "GithubSearchMVC", bundle: nil).instantiateInitialViewController() as! GithubSearchMVCViewController
  }

  static var mvpViewController: GithubSearchMVPViewController {
    UIStoryboard(name: "GithubSearchMVP", bundle: nil).instantiateInitialViewController() as! GithubSearchMVPViewController
  }

  static var mvvmViewController: GithubSearchMVVMViewController {
    UIStoryboard(name: "GithubSearchMVVM", bundle: nil).instantiateInitialViewController() as! GithubSearchMVVMViewController
  }

}
