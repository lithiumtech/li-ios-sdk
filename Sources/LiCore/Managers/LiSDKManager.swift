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
public final class LiSDKManager {
    //Mark: - Internal
    var appCredentials: LiAppCredentials
    private static var sharedInstance: LiSDKManager!
    private(set) var visitorId: String? {
        get {
            return UserDefaults.standard.string(forKey: LiCoreSDKConstants.LiUserDefaultConstants.liVisitorId)
        }
        set (value) {
            UserDefaults.standard.set(value, forKey: LiCoreSDKConstants.LiUserDefaultConstants.liVisitorId)
        }
    }
    private init(credentials: LiAppCredentials) {
        appCredentials = credentials
        LiSDKManager.sharedInstance = self
    }
    //MARK: - Public
    public var authState: LiAuthState = LiAuthState()
    public let clientManager: LiClientManager = LiClientManager()
    public lazy var authManager: LiAuthManager = {
        [unowned self] in
        let liAuthManager = LiAuthManager(sdkManager: self)
        return liAuthManager
        }()
    /**
     Use this function to congfigure community credentials.
     Note: Call this function before using any SDK functionality. Preferably in AppDelegate on app launch.
     
     - parameter credentials: LiAppCredentials object
     */
    public class func setup(credentials: LiAppCredentials) {
        sharedInstance = LiSDKManager(credentials: credentials)
        if sharedInstance.visitorId == nil {
            sharedInstance.visitorId = UUID.init().uuidString.replacingOccurrences(of: "-", with: "")
        }
    }
    /**
     Returns the sharedInstance for the LiSDKManager singleton.
     Note: This will throw a fatalError if this function is called before calling `setup`.
     */
    public static func shared() -> LiSDKManager {
        if LiSDKManager.sharedInstance == nil {
            fatalError("Please call setup function before using this class.")
        }
        return sharedInstance
    }
    /**
     This function should used to get response_limit and discussion_style set by admin from the community server.
     */
    public func syncSettings() {
        if authManager.isUserLoggedIn() {
            let requestParams = try! LiSdkSettingsClientRequestParams(clientId: appCredentials.clientId)
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
                print("Settings sync failed: \(String(describing: error))")
            })
        }
    }
    /**
     This function should used to update notification device token in case it was changed.
     
     - parameter deviceToken: Device token from the `didRegisterForRemoteNotificationsWithDeviceToken` method in `AppDelegate`.
     */
    public func update(deviceToken: String) {
        if authManager.isUserLoggedIn() {
            syncSettings()
            LiNotificationManager.update(deviceToken: deviceToken)
        }
    }
}
