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
        return keychainWrapperInstance.string(forKey: LiCoreConstants.UserDefaultConstants.liTenantId)
    }
    public var userId: String? {
        return keychainWrapperInstance.string(forKey: LiCoreConstants.UserDefaultConstants.liUserId)
    }
    public var refreshToken: String? {
        return keychainWrapperInstance.string(forKey: LiCoreConstants.UserDefaultConstants.liRefreshToken)
    }
    public var accessToken: String? {
        return keychainWrapperInstance.string(forKey: LiCoreConstants.UserDefaultConstants.liAccessToken)
    }
    public var lithiumUserID: String? {
        return keychainWrapperInstance.string(forKey: LiCoreConstants.UserDefaultConstants.liLithiumUserId)
    }
    public var expiryDate: NSDate? {
        return keychainWrapperInstance.object(forKey: LiCoreConstants.UserDefaultConstants.liExpiryDate) as? NSDate
    }
    public var visitOriginTime: String? {
        return keychainWrapperInstance.string(forKey: LiCoreConstants.UserDefaultConstants.liVisitOriginTime)
    }
    public var visitLastIssueTime: String? {
        return keychainWrapperInstance.string(forKey: LiCoreConstants.UserDefaultConstants.liVisitLastIssueTime)
    }
    public var deviceToken: String? {
        return keychainWrapperInstance.string(forKey: LiCoreConstants.UserDefaultConstants.liDeviceToken)
    }
    func set(deviceToken: String) {
        keychainWrapperInstance.set(deviceToken, forKey: LiCoreConstants.UserDefaultConstants.liDeviceToken)
    }
    func set(visitLastIssueTime: String) {
        keychainWrapperInstance.set(visitLastIssueTime, forKey: LiCoreConstants.UserDefaultConstants.liVisitLastIssueTime)
    }
    func set(visitOriginTime: String) {
        keychainWrapperInstance.set(visitOriginTime, forKey: LiCoreConstants.UserDefaultConstants.liVisitOriginTime)
    }
    func set(expiryDate: NSDate) {
        keychainWrapperInstance.set(expiryDate as NSCoding, forKey: LiCoreConstants.UserDefaultConstants.liExpiryDate)
    }
    func set(lithiumUserID: String) {
        keychainWrapperInstance.set(lithiumUserID, forKey: LiCoreConstants.UserDefaultConstants.liLithiumUserId)
    }
    func set(userID: String) {
        keychainWrapperInstance.set(userID, forKey: LiCoreConstants.UserDefaultConstants.liUserId)
    }
    func set(accessToken: String) {
       keychainWrapperInstance.set(accessToken, forKey: LiCoreConstants.UserDefaultConstants.liAccessToken)
    }
    func set(refreshToken: String) {
        keychainWrapperInstance.set(refreshToken, forKey: LiCoreConstants.UserDefaultConstants.liRefreshToken)
    }
    func set(tenantId: String) {
        keychainWrapperInstance.set(tenantId, forKey: LiCoreConstants.UserDefaultConstants.liTenantId)
    }
    var isLoggedIn: Bool {
        return UserDefaults.standard.bool(forKey: LiCoreConstants.UserDefaultConstants.liUserLoginStatus)
    }
    ///Id that identifies notification token in lia. Used to update notification token.
    var notificationId: String? {
        return keychainWrapperInstance.string(forKey: LiCoreConstants.UserDefaultConstants.liNotificationId)
    }
    func loginSuccessfull() {
        UserDefaults.standard.set(true, forKey: LiCoreConstants.UserDefaultConstants.liUserLoginStatus)
    }
    func set(notificationId value: String) {
        keychainWrapperInstance.set(value, forKey: LiCoreConstants.UserDefaultConstants.liNotificationId)
    }
}
