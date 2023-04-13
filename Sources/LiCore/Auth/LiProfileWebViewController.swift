//
//  LiProfileWebViewController.swift
//  LiUIComponents
//
//  Created by Paul Kwak on 4/13/23.
//

import UIKit
import WebKit

/**
 View controller used to present the webView used in Profile.
 */
public class LiProfileWebViewController: UIViewController, WKNavigationDelegate {
    var url: URLRequest
    var webView: WKWebView
    public init(url: URLRequest) {
        self.url = url
        let websiteDataStore = WKWebsiteDataStore.nonPersistent()
        if let cookies = HTTPCookieStorage.shared.cookies {
            for cookie in cookies {
                websiteDataStore.httpCookieStore.setCookie(cookie)
            }
        }
        let config = WKWebViewConfiguration()
        config.websiteDataStore = websiteDataStore
        self.webView = WKWebView(frame: CGRectZero, configuration: config)
        super.init(nibName: nil, bundle: nil)
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    fileprivate func setupWebView() {
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        webView.load(url)
        self.view.addSubview(webView)
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    fileprivate func setupTitle() {
        title = "Profile"
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(LiProfileWebViewController.onClose))
        self.navigationItem.setRightBarButton(cancelItem, animated: true)
    }
    open override func viewDidLoad() {
        setupTitle()
        setupWebView()
    }
    @objc func onClose() {
        self.dismiss(animated: true)
    }
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if #available(iOS 13.0, *) {
            let communityURL: String = LiSDKManager.shared().appCredentials.communityURL
            if let urlString = navigationAction.request.url?.absoluteString, let htAccessString = KeychainWrapper.standard.string(forKey: "htaccess"), urlString.contains(communityURL) && navigationAction.request.allHTTPHeaderFields?["Authorization"] == nil {
                let loginData = htAccessString.data(using: String.Encoding.utf8)!
                let base64LoginString = loginData.base64EncodedString()
                let newRequest: NSMutableURLRequest = (navigationAction.request as NSURLRequest).mutableCopy() as! NSMutableURLRequest
                newRequest.addValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
                decisionHandler(.cancel)
                webView.load(newRequest as URLRequest)
                return
            }
        }

        let queryParameters = navigationAction.request.url?.liQueryItems ?? [:]
        if queryParameters["response_type"] != nil {
            decisionHandler(.allow)
            return
        }
        //Check for auth code in the redirected url.
        decisionHandler(.allow)
    }
}
