// Copyright (c) 2020 Nomad5. All rights reserved.

import UIKit
import WebKit

class ViewController: UIViewController {

    /// The "hacked" webview
    private var webview: WKWebView!

    /// The configuration used for the wk webview
    private lazy var webViewConfig: WKWebViewConfiguration = {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = false
        config.mediaTypesRequiringUserActionForPlayback = []
        config.applicationNameForUserAgent = "Version/13.0.1 Safari/605.1.15"
        config.userContentController.addScriptMessageHandler(WebViewControllerBridge(), contentWorld: WKContentWorld.page, name: "controller")
        return config
    }()

    /// View will be shown shortly
    override func viewDidLoad() {
        super.viewDidLoad()
        // configure webview
        webview = WKWebView(frame: view.bounds, configuration: webViewConfig)
        webview.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webview)
        webview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        webview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        webview.navigationDelegate = self
        // trigger login path
        webview.load(URLRequest(url: Config.Url.login))
    }

}

extension ViewController: WKNavigationDelegate {

    /// When a stadia page finished loading, inject the controller override script
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if let url = webview.url?.absoluteString, url.starts(with: Config.Url.stadia.absoluteString) {
            webview.injectControllerScript()
        }
    }

    /// After successfully logging in, forward user to stadia
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url?.absoluteString, url.starts(with: Config.Url.loggedIn.absoluteString) {
            decisionHandler(.cancel)
            webView.navigateToStadia()
            return
        }
        decisionHandler(.allow)
    }
}
