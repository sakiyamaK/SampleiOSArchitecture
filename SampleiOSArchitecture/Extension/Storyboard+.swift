import UIKit

extension UIStoryboard {

  static var rootViewController: RootViewController {
    UIStoryboard(name: "Root", bundle: nil).instantiateInitialViewController() as! RootViewController
  }

  static var mvvmViewController: GithubSearchMVVMViewController {
    UIStoryboard(name: "GithubSearchMVVM", bundle: nil).instantiateInitialViewController() as! GithubSearchMVVMViewController
  }
}

//MVC用
extension UIStoryboard {
  static var githubSearchMVCViewController: GithubSearchMVCViewController {
    UIStoryboard(name: "GithubSearchMVC", bundle: nil).instantiateInitialViewController() as! GithubSearchMVCViewController
  }

  static var webMVCViewController: WebMVCViewController {
    UIStoryboard(name: "WebMVC", bundle: nil).instantiateInitialViewController() as! WebMVCViewController
  }
}


//MVP用
extension UIStoryboard {
  static var githubSearchMVPViewController: GithubSearchMVPViewController {
    UIStoryboard(name: "GithubSearchMVP", bundle: nil).instantiateInitialViewController() as! GithubSearchMVPViewController
  }

  static var webMVPViewController: WebMVPViewController {
    UIStoryboard(name: "WebMVP", bundle: nil).instantiateInitialViewController() as! WebMVPViewController
  }
}
