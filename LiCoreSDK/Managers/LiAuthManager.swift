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
/**
 Provides methods to login into the community.
 */
public class LiAuthManager: NSObject, InternalLiLoginDelegate {
    var deviceToken: String?
    var notificationProvider: String?
    ///delegate for `LiAuthorizationDelegate`
    weak public var liLoginDelegate: LiAuthorizationDelegate?
    weak var sdkManager: LiSDKManager?
    init(sdkManager: LiSDKManager) {
        self.sdkManager = sdkManager
    }
    //MARK: - Public
    /**
     Use this function to initiate web view based login.
     
     - parameter viewController:         View controller from which login is initaited.
     - parameter deviceToken:            Optional device token obtained from the `didRegisterForRemoteNotificationsWithDeviceToken` method in `AppDelegate`.
     - parameter notificationProvider:   Optional Your notification provider. Possible values - 'APNS', 'FIREBASE'.
     */
    public func initLoginFlow(from viewController: UIViewController, deviceToken: String?, notificationProvider: String?) {
        guard let sdkManager = sdkManager else {
            assert(self.sdkManager == nil, "LiSDKManger should not be nil")
            return
        }
        self.deviceToken = deviceToken
        self.notificationProvider = notificationProvider
        let authService: LiAuthService
        authService = LiAuthService.init(context: viewController, ssoToken: nil, sdkManager: sdkManager)
        authService.authDelegate = self
        authService.startLoginFlow()
    }
    /**
     Use this function to initiate sso token based login.
     
     - parameter viewController:         View controller from which login is initaited.
     - parameter ssoToken:               SSO token.
     - parameter deviceToken:            Optional device token obtained from the `didRegisterForRemoteNotificationsWithDeviceToken` method in `AppDelegate`.
     - parameter notificationProvider:   Optional Your notification provider. Possible values - 'APNS', 'FIREBASE'.
     */
    public func initLoginFlow(from viewController: UIViewController, withSSOToken ssoToken: String, deviceToken: String?, notificationProvider: String?) {
        guard let sdkManager = sdkManager else {
            assert(self.sdkManager == nil, "LiSDKManger should not be nil")
            return
        }
        self.deviceToken = deviceToken
        self.notificationProvider = notificationProvider
        let authService: LiAuthService
        authService = LiAuthService.init(context: viewController, ssoToken: ssoToken, sdkManager: sdkManager)
        authService.authDelegate = self
        authService.startLoginFlow()
    }
    /**
     Use this function to check the status of login.
     - returns: `true` if user is logged in, `false` otherwise.
     */
    public func isUserLoggedIn() -> Bool {
        guard let sdkManager = sdkManager else {
            return false
        }
        return sdkManager.liAuthState.isLoggedIn
    }
    /**
     Use this function to logout the logged in user.
     */
    public func logoutUser() {
        KeychainWrapper.standard.removeObject(forKey: LiCoreSDKConstants.LiUserDefaultConstants.liAccessToken)
        KeychainWrapper.standard.removeObject(forKey: LiCoreSDKConstants.LiUserDefaultConstants.liRefreshToken)
        KeychainWrapper.standard.removeObject(forKey: LiCoreSDKConstants.LiUserDefaultConstants.liUserLoginStatus)
        KeychainWrapper.standard.removeObject(forKey: LiCoreSDKConstants.LiUserDefaultConstants.liNotificationId)
        KeychainWrapper.standard.removeObject(forKey: LiCoreSDKConstants.LiUserDefaultConstants.liVisitLastIssueTime)
        KeychainWrapper.standard.removeObject(forKey: LiCoreSDKConstants.LiUserDefaultConstants.liVisitOriginTime)
        KeychainWrapper.standard.removeObject(forKey: LiCoreSDKConstants.LiUserDefaultConstants.liExpiryDate)
        KeychainWrapper.standard.removeObject(forKey: LiCoreSDKConstants.LiUserDefaultConstants.liLithiumUserId)
        KeychainWrapper.standard.removeObject(forKey: LiCoreSDKConstants.LiUserDefaultConstants.liUserId)
        KeychainWrapper.standard.removeObject(forKey: LiCoreSDKConstants.LiUserDefaultConstants.liApiProxyHost)
        KeychainWrapper.standard.removeObject(forKey: LiCoreSDKConstants.LiUserDefaultConstants.liTenantId)
        URLCache.shared.removeAllCachedResponses()
        URLCache.shared.diskCapacity = 0
        URLCache.shared.memoryCapacity = 0
        let storage = HTTPCookieStorage.shared
        if let cookies = storage.cookies {
            for cookie in cookies {
                storage.deleteCookie(cookie)
            }
        }
    }
    //MARK: - Internal
    func login(status: Bool, userId: String?, error: Error?) {
        if status {
            if let notificationProvider = notificationProvider, let deviceToken = deviceToken {
                LiNotificationManager.add(deviceToken: deviceToken, notificationProvider: notificationProvider)
            }
            sdkManager?.syncSettings()
        }
        liLoginDelegate?.login(status: status, userId: userId, error: error)
    }
}
