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
/**
 This class contains the methods to add and update device token and notification provider
 */
public struct LiNotificationManager {
    /**
     Funtion to add deviceToken and notificationProvider to LIA for the given user.
     - parameter deviceToken: Device token from the `didRegisterForRemoteNotificationsWithDeviceToken` method in AppDelegate.
     - parameter notificationProvider: Your notification provider. Possible values - 'APNS', 'FIREBASE'
     */
    public static func add(deviceToken: String, notificationProvider: String) {
        //TODO:- Handel errors here
        let requestParams = try! LiDeviceIdFetchClientRequestParams(deviceId: deviceToken, pushNotificationProvider: notificationProvider)
        LiRestClient.sharedInstance.request(client: LiClient.liDeviceIdFetchClient(requestParams: requestParams), success: { (response: LiBaseResponse) in
            if let notificationId = response.data["id"] as? String {
                LiSDKManager.sharedInstance.liAuthState.set(notificationId: notificationId)
            }
        }) { (error : Error) in
            print("Failed to update device token: - \(error)")
        }
    }
    /**
     Funtion to update deviceToken.
     - parameter deviceToken: Updated device token from the `didRegisterForRemoteNotificationsWithDeviceToken` method in AppDelegate.
     */
    public static func update(deviceToken: String) {
        //TODO: - get notificationId
        let id = LiSDKManager.sharedInstance.liAuthState.notificationId ?? ""
        let requestParams = try! LiDeviceIdUpdateClientRequestParams(deviceId: deviceToken, id: id)
        LiRestClient.sharedInstance.request(client: LiClient.liDeviceIdUpdateClient(requestParams: requestParams), success: { (_: LiBaseResponse) in
        }) { (error: Error) in
            print("Failed to update device token: - \(error)")
        }
    }
}
