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
//MARK: - Internal protocol
protocol InternalLiLoginDelegate: class {
    func login(status: Bool, userId: String?, error: Error?)
}
/**
 Initiates login and requests access token.
 */
class LiAuthService {
    /// View controller from which login is initaited.
    let fromViewController: UIViewController
    /// SSO token for login
    let ssoToken: String?
    var webView: UIWebView?
    var loginViewController: LiLoginViewController?
    weak var authDelegate: InternalLiLoginDelegate?
    var sdkManager: LiSDKManager
    /**
     Creates instance of `LiAuthService`
     - parameter context:  View controller from which login is initaited.
     - parameter ssoToken: Optional sso token used for sso login.
     */
    init(context: UIViewController, ssoToken: String?, sdkManager: LiSDKManager) {
        fromViewController = context
        self.ssoToken = ssoToken
        self.sdkManager = sdkManager
    }
    func startLoginFlow() {
        if ssoToken != nil {
            performSSOAuthorizationRequest()
        } else {
            do {
                /**
                 Performs login using webView.
                 */
                let url = try sdkManager.appCredentials.getURL()
                loginViewController = LiLoginViewController(url: url, sdkManager: sdkManager)
                loginViewController?.delegate = self
                guard let vc = loginViewController else { return }
                let navController = UINavigationController(rootViewController: vc)
                fromViewController.present(navController, animated: true, completion: nil)
            } catch let error {
                self.authDelegate?.login(status: false, userId: nil, error: error)
            }
        }
    }
    /**
     Performs login using SSO token.
     */
    func performSSOAuthorizationRequest() {
        if let token = ssoToken {
            LiRestClient.sharedInstance.request(client: LiClient.liSSOTokenRequest(ssoToken: token), success: { (response: LiBaseResponse) in
                do {
                    let authObject = try LiSSOAuthResponse(data: response.data)
                    if let tenantId = authObject.tenantId {
                        self.sdkManager.authState.set(tenantId: tenantId)
                    }
                    self.requestAccessToken(authCode: authObject.authCode)
                } catch let error {
                    self.authDelegate?.login(status: false, userId: nil, error: error)
                }
            }, failure: { (error: Error) in
                self.authDelegate?.login(status: false, userId: nil, error: error)
            })
        }
    }
}

extension LiAuthService: LiLoginViewControllerProtocol {
    func webViewLoginFailure(error: Error) {
        authDelegate?.login(status: false, userId: nil, error: error)
    }
    /**
     Gets access token.
     - parameter authCode: AuthCode obtained from login successfully with either webview or sso token.
     */
    func requestAccessToken(authCode: String) {
        LiRestClient.sharedInstance.request(client: LiClient.getAccessToken(code: authCode), success: { [weak self] (response: LiBaseResponse) in
            //TODO: Move this logic to LiAuthResponse
            let error = LiAuthResponse().setAuthResponse(data: response.data)
            if error != nil {
                self?.loginViewController?.dismiss(animated: true, completion: nil)
                self?.authDelegate?.login(status: false, userId: nil, error: error)
                return
            }
            self?.sdkManager.authState.loginSuccessfull()
            self?.loginViewController?.dismiss(animated: true, completion: { self?.loginViewController?.delegate = nil })
            self?.authDelegate?.login(status: true, userId: self?.sdkManager.authState.userId, error: nil)
            return
        }) { [weak self](error) in
            self?.loginViewController?.dismiss(animated: true, completion: nil)
            self?.authDelegate?.login(status: false, userId: nil, error:error)
        }
    }
}
