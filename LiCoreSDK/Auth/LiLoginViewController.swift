// Copyright 2018 Lithium Technologies 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import Foundation
import UIKit

///Internal protocol to communicate between LiLoginViewController and LiAuthService.
protocol LiLoginViewControllerProtocol {
    func requestAccessToken(authCode: String)
    func webViewLoginFailure(error: Error)
}
/**
 View controller used to present the webView used in login.
 */
class LiLoginViewController: UIViewController, UIWebViewDelegate {
    var url: URLRequest?
    // swiftlint:disable:next weak_delegate
    var delegate: LiLoginViewControllerProtocol?
    // swiftlint:disable:next weak_delegate
    public var authDelegate: LiAuthorizationDelegate?
    override func viewDidLoad() {
        let nav = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 64))
        self.view.addSubview(nav)
        let navItem = UINavigationItem(title: "Login")
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(LiLoginViewController.onClose))
        navItem.rightBarButtonItem = cancelItem
        nav.setItems([navItem], animated: false)
        let webViewFrame = CGRect(x: 0, y: 65, width: self.view.frame.size.width, height: self.view.frame.size.height - 65)
        let webView = UIWebView(frame: webViewFrame)
        webView.loadRequest(url!)
        webView.delegate = self
        self.view.addSubview(webView)
    }
    func onClose() {
        self.dismiss(animated: true)
    }
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let queryParameters = request.url?.liQueryItems ?? [:]
        if queryParameters["response_type"] != nil {
            return true
        }
        //Check for auth code in the redirected url.
        if queryParameters["code"] != nil {
            do {
                let authObject = try LiSSOAuthResponse(data: queryParameters)
                if let tenantId = authObject.tenantId {
                    LiSDKManager.sharedInstance.liAuthState.set(tenantId: tenantId)
                }
                if let apiProxyHost = authObject.apiProxyHost {
                    LiSDKManager.sharedInstance.liAuthState.set(apiProxyHost: apiProxyHost)
                }
                delegate?.requestAccessToken(authCode: authObject.authCode)
            } catch let error {
                delegate?.webViewLoginFailure(error: error)
            }
        }
        return true
    }
}
extension URL {
    /**
     returns query parameters for an encoded url. Returns them in the form of [String: String].
     */
    public var liQueryItems: [String: String] {
        var params = [String: String]()
        return URLComponents(url: self, resolvingAgainstBaseURL: false)?
            .queryItems?
            .reduce([:], { (_, item) -> [String: String] in
                params[item.name] = item.value
                return params
            }) ?? [:]
    }
}
