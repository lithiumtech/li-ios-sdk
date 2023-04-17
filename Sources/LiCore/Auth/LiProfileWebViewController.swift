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
    var webView: WKWebView
    public init() {
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
        let profileUrl: String = LiSDKManager.shared().appCredentials.communityURL + "/t5/user/myprofilepage/tab/personal-profile"
        if let url = URL(string: profileUrl) {
            webView.translatesAutoresizingMaskIntoConstraints = false
            webView.navigationDelegate = self
            webView.load(URLRequest(url: url))
            self.view.addSubview(webView)
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        } else {
            self.dismiss(animated: true)
        }
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
    
    public func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        let communityURL: String = LiSDKManager.shared().appCredentials.communityURL
        
        if let htAccessString = KeychainWrapper.standard.string(forKey: "htaccess"),  (webView.url?.absoluteString.contains(communityURL)) != nil {
            let components = htAccessString.split(separator: ":")
            if (components.count == 2) {
                let user = String(components[0])
                let password = String(components[1])
                let credential = URLCredential(user: user, password: password, persistence: .forSession)
                challenge.sender?.use(credential, for: challenge)
                completionHandler(.useCredential, credential)
            } else {
                completionHandler(.performDefaultHandling, nil)
            }
        } else {
            completionHandler(.performDefaultHandling, nil)
        }
    }
}
