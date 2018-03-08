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
public final class LiSDKManager: LiAuthManager {
    //Mark: - Internal
    var liAppCredentials: LiAppCredentials
    var visitorId: String? {
        return UserDefaults.standard.string(forKey: LiCoreSDKConstants.LiUserDefaultConstants.liVisitorId)
    }
    private override init() {
        var clientId: String = ""
        var clientSecret: String = ""
        var communityURL: String = ""
        var tenantID: String = ""
        var apiProxyHost: String = ""
        var clientAppName: String = ""
        if UserDefaults.standard.string(forKey: LiCoreSDKConstants.LiUserDefaultConstants.liVisitorId) == nil {
            UserDefaults.standard.set(UUID.init().uuidString.replacingOccurrences(of: "-", with: ""), forKey: LiCoreSDKConstants.LiUserDefaultConstants.liVisitorId)
        }
        if let fileUrl = Bundle.main.url(forResource: "Info", withExtension: "plist") {
            do {
                let data = try Data(contentsOf: fileUrl)
                if let result = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any] {
                    if let SDKKeys = result["LiAPICredentials"] as? [String: String] {
                        clientId = SDKKeys["LiClientId"]?.trimmingCharacters(in: .whitespaces) ?? ""
                        clientSecret = SDKKeys["LiClientSecret"]?.trimmingCharacters(in: .whitespaces) ?? ""
                        communityURL = SDKKeys["LiCommunityUrl"]?.trimmingCharacters(in: .whitespaces) ?? ""
                        tenantID = SDKKeys["LiTenantId"]?.trimmingCharacters(in: .whitespaces) ?? ""
                        apiProxyHost = SDKKeys["LiApiProxyHost"]?.trimmingCharacters(in: .whitespaces) ?? ""
                        clientAppName = SDKKeys["LiClientAppName"] ?? "communityId-sdk"
                    } else {
                        print("SDK initalization failed: LiAPICredentials are missing.")
                    }
                }
            } catch let error {
                print("SDK initalization failed: \(error)")
            }
        }
        let cred = LiAppCredentials(clientId: clientId, clientSecret: clientSecret, communityURL: communityURL, tenantID: tenantID, apiProxyHost: apiProxyHost, clientAppName: clientAppName)
        liAppCredentials = cred
    }
    //MARK: - Public
    /// Returns the singleton instance of `LiSDKManager`.
    public static let sharedInstance = LiSDKManager()
    public var liAuthState: LiAuthState = LiAuthState()
    /**
     This function should used to get response_limit and discussion_style set by admin from the community server.
     */
    public func syncSettings() {
        if isUserLoggedIn() {
            //TODO: - Add do catch
            let requestParams = try! LiSdkSettingsClientRequestParams(clientId: liAppCredentials.clientId)
            LiRestClient.sharedInstance.request(client: LiClient.liSdkSettingsClient(requestParams: requestParams), success: { (response: LiBaseResponse) in
                if let settingsArray = response.data["items"] as? [[String:Any]] {
                    if let settings = settingsArray.first {
                        if let responseLimit = settings["response_limit"] as? String {
                            LiAppSdkSettings.set(responseLimit: responseLimit)
                        }
                        if let discussionStyle = response.data["discussion_style"] as? [String] {
                            LiAppSdkSettings.set(discussionStyle: discussionStyle)
                        }
                    }
                }
            }, failure: { (error: Error?) in
                print("Settings sync failed: \(error.debugDescription)")
            })
        }
    }
    /**
     This function should used to update notification device token in case it was changed.
     
     - parameter deviceToken: Device token from the `didRegisterForRemoteNotificationsWithDeviceToken` method in `AppDelegate`.
     */
    public func update(deviceToken: String) {
        if isUserLoggedIn() {
            syncSettings()
            LiNotificationManager.update(deviceToken: deviceToken)
        }
    }
}
