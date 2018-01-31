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
public struct LiAuthState {
    let keychainWrapperInstance: KeychainWrapper
    init() {
        keychainWrapperInstance = KeychainWrapper.standard
    }
    public var tenantId: String? {
        return keychainWrapperInstance.string(forKey: LiCoreSDKConstants.LiUserDefaultConstants.liTenantId)
    }
    public var apiProxyHost: String? {
        return keychainWrapperInstance.string(forKey: LiCoreSDKConstants.LiUserDefaultConstants.liApiProxyHost)
    }
    public var userId: String? {
        return keychainWrapperInstance.string(forKey: LiCoreSDKConstants.LiUserDefaultConstants.liUserId)
    }
    public var refreshToken: String? {
        return keychainWrapperInstance.string(forKey: LiCoreSDKConstants.LiUserDefaultConstants.liRefreshToken)
    }
    public var accessToken: String? {
        return keychainWrapperInstance.string(forKey: LiCoreSDKConstants.LiUserDefaultConstants.liAccessToken)
    }
    public var lithiumUserID: String? {
        return keychainWrapperInstance.string(forKey: LiCoreSDKConstants.LiUserDefaultConstants.liLithiumUserId)
    }
    public var expiryDate: NSDate? {
        return keychainWrapperInstance.object(forKey: LiCoreSDKConstants.LiUserDefaultConstants.liExpiryDate) as? NSDate
    }
    public var visitOriginTime: String? {
        return keychainWrapperInstance.string(forKey: LiCoreSDKConstants.LiUserDefaultConstants.liVisitOriginTime)
    }
    public var visitLastIssueTime: String? {
        return keychainWrapperInstance.string(forKey: LiCoreSDKConstants.LiUserDefaultConstants.liVisitLastIssueTime)
    }
    func set(visitLastIssueTime: String) {
        keychainWrapperInstance.set(visitLastIssueTime, forKey: LiCoreSDKConstants.LiUserDefaultConstants.liVisitLastIssueTime)
    }
    func set(visitOriginTime: String) {
        keychainWrapperInstance.set(visitOriginTime, forKey: LiCoreSDKConstants.LiUserDefaultConstants.liVisitOriginTime)
    }
    func set(expiryDate: NSDate) {
        keychainWrapperInstance.set(expiryDate as NSCoding, forKey: LiCoreSDKConstants.LiUserDefaultConstants.liExpiryDate)
    }
    func set(lithiumUserID: String) {
        keychainWrapperInstance.set(lithiumUserID, forKey: LiCoreSDKConstants.LiUserDefaultConstants.liLithiumUserId)
    }
    func set(userID: String) {
        keychainWrapperInstance.set(userID, forKey: LiCoreSDKConstants.LiUserDefaultConstants.liUserId)
    }
    func set(accessToken: String) {
       keychainWrapperInstance.set(accessToken, forKey: LiCoreSDKConstants.LiUserDefaultConstants.liAccessToken)
    }
    func set(refreshToken: String) {
        keychainWrapperInstance.set(refreshToken, forKey: LiCoreSDKConstants.LiUserDefaultConstants.liRefreshToken)
    }
    func set(tenantId: String) {
        keychainWrapperInstance.set(tenantId, forKey: LiCoreSDKConstants.LiUserDefaultConstants.liTenantId)
    }
    func set(apiProxyHost: String) {
        keychainWrapperInstance.set(apiProxyHost, forKey: LiCoreSDKConstants.LiUserDefaultConstants.liApiProxyHost)
    }
    var isLoggedIn: Bool {
        if let loggedIn = keychainWrapperInstance.bool(forKey: LiCoreSDKConstants.LiUserDefaultConstants.liUserLoginStatus){
            return loggedIn
        }
        return false
    }
    ///Id that identifies notification token in lia. Used to update notification token.
    var notificationId: String? {
        return keychainWrapperInstance.string(forKey: LiCoreSDKConstants.LiUserDefaultConstants.liNotificationId)
    }
    func loginSuccessfull() {
        keychainWrapperInstance.set(true, forKey: LiCoreSDKConstants.LiUserDefaultConstants.liUserLoginStatus)
    }
    func set(notificationId value: String) {
        keychainWrapperInstance.set(value, forKey: LiCoreSDKConstants.LiUserDefaultConstants.liNotificationId)
    }
}
