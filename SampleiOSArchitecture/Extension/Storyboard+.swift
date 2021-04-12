import UIKit

extension UIStoryboard {
  static var rootViewController: RootViewController {
    UIStoryboard(name: "Root", bundle: nil).instantiateInitialViewController() as! RootViewController
  }
}

// MVC用
extension UIStoryboard {
  static var GithubSearchMVC01ViewController: GithubSearchMVC01ViewController {
    UIStoryboard(name: "GithubSearchMVC01", bundle: nil).instantiateInitialViewController() as! GithubSearchMVC01ViewController
  }

  static var webMVCViewController: WebMVCViewController {
    UIStoryboard(name: "WebMVC", bundle: nil).instantiateInitialViewController() as! WebMVCViewController
  }
}

// MVP用
extension UIStoryboard {
  static var githubSearchMVPViewController: GithubSearchMVPViewController {
    UIStoryboard(name: "GithubSearchMVP", bundle: nil).instantiateInitialViewController() as! GithubSearchMVPViewController
  }

  static var webMVPViewController: WebMVPViewController {
    UIStoryboard(name: "WebMVP", bundle: nil).instantiateInitialViewController() as! WebMVPViewController
  }
}

// MVVM01用
extension UIStoryboard {
  static var githubSearchMVVM01ViewController: GithubSearchMVVM01ViewController {
    UIStoryboard(name: "GithubSearchMVVM01", bundle: nil).instantiateInitialViewController() as! GithubSearchMVVM01ViewController
  }

  static var webMVVMViewController: WebMVVMViewController {
    UIStoryboard(name: "WebMVVM", bundle: nil).instantiateInitialViewController() as! WebMVVMViewController
  }
}

// MVVM02用
extension UIStoryboard {
  static var githubSearchMVVM02ViewController: GithubSearchMVVM02ViewController {
    UIStoryboard(name: "GithubSearchMVVM02", bundle: nil).instantiateInitialViewController() as! GithubSearchMVVM02ViewController
  }
}

// MVVM02用
extension UIStoryboard {
  static var githubSearchMVVM03ViewController: GithubSearchMVVM03ViewController {
    UIStoryboard(name: "GithubSearchMVVM03", bundle: nil).instantiateInitialViewController() as! GithubSearchMVVM03ViewController
  }
}
