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
    var url: URLRequest
    // swiftlint:disable:next weak_delegate
    var delegate: LiLoginViewControllerProtocol?
    // swiftlint:disable:next weak_delegate
    public var authDelegate: LiAuthorizationDelegate?
    var sdkManager: LiSDKManager
    init(url: URLRequest, sdkManager: LiSDKManager) {
        self.url = url
        self.sdkManager = sdkManager
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    fileprivate func setupWebView() {
        let webView = UIWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.loadRequest(url)
        webView.delegate = self
        self.view.addSubview(webView)
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    fileprivate func setupTitle() {
        title = "Login"
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(LiLoginViewController.onClose))
        self.navigationItem.setRightBarButton(cancelItem, animated: true)
    }
    override func viewDidLoad() {
        setupTitle()
        setupWebView()
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
                    sdkManager.authState.set(tenantId: tenantId)
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
