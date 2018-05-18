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
    var vc: LiLoginViewController?
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
                let url = try sdkManager.liAppCredentials.getURL()
                vc = LiLoginViewController(url: url, sdkManager: sdkManager)
                vc?.delegate = self
                guard let vc = vc else { return }
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
                        self.sdkManager.liAuthState.set(tenantId: tenantId)
                    }
                    if let proxyHost = authObject.apiProxyHost {
                        self.sdkManager.liAuthState.set(apiProxyHost: proxyHost)
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
        LiRestClient.sharedInstance.request(client: LiClient.getAccessToken(code: authCode), success: { (response: LiBaseResponse) in
            guard let accessToken = response.data["access_token"] as? String,
                let refreshToken = response.data["refresh_token"] as? String,
                let userID = response.data["userId"] as? String,
                let lithiumUserID = response.data["lithiumUserId"] as? String,
                let expiresIn = response.data["expires_in"] as? Double else {
                    let error = LiBaseError(errorMessage: "Invalid access token received", httpCode: LiCoreSDKConstants.LiErrorCodes.httpCodeForbidden)
                    self.vc?.dismiss(animated: true, completion: nil)
                    self.authDelegate?.login(status: false, userId: nil, error: error)
                    return
            }
            self.sdkManager.liAuthState.set(accessToken: accessToken)
            self.sdkManager.liAuthState.set(refreshToken: refreshToken)
            self.sdkManager.liAuthState.set(userID: userID)
            self.sdkManager.liAuthState.set(lithiumUserID: lithiumUserID)
            let currentDate = NSDate()
            let newDate = NSDate(timeInterval: expiresIn, since: currentDate as Date)
            self.sdkManager.liAuthState.set(expiryDate: newDate)
            self.sdkManager.liAuthState.loginSuccessfull()
            self.vc?.dismiss(animated: true, completion: { self.vc?.delegate = nil })
            self.authDelegate?.login(status: true, userId: userID, error: nil)
            return
        }) { (error) in
            self.vc?.dismiss(animated: true, completion: nil)
            self.authDelegate?.login(status: false, userId: nil, error:error)
        }
    }
}
