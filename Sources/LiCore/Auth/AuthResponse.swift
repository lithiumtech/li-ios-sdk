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

struct AuthResponse {
    func setAuthResponse(data: [String: Any]) -> Error? {
        guard let accessToken = data["access_token"] as? String,
            let refreshToken = data["refresh_token"] as? String,
            let expiresIn = data["expires_in"] as? Double else {
                let error = LiBaseError(errorMessage: LiCoreConstants.ErrorMessages.invalidAccessToken, httpCode: LiCoreConstants.ErrorCodes.forbidden)
                return error
        }
        LiSDKManager.shared().authState.set(accessToken: accessToken)
        LiSDKManager.shared().authState.set(refreshToken: refreshToken)
        if let userId =  data["userId"] as? String {
            LiSDKManager.shared().authState.set(userID: userId)
        }
        if let lithiumUserId =  data["lithiumUserId"] as? String {
            LiSDKManager.shared().authState.set(lithiumUserID: lithiumUserId)
        }
        let currentDate = NSDate()
        let newDate = NSDate(timeInterval: expiresIn, since: currentDate as Date)
        LiSDKManager.shared().authState.set(expiryDate: newDate)
        return nil
    }
    func setAuthResponse(data: Data?) -> Error? {
        guard let responseData = data else {
            return LiBaseError(errorMessage: LiCoreConstants.ErrorMessages.refreshFailed, httpCode: LiCoreConstants.ErrorCodes.forbidden)
        }
        do {
            let json =  try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any]
            if let data = json?["data"] as? [String: Any] {
                let error =  AuthResponse().setAuthResponse(data: data)
                return error
            } else {
                if let jsonData = json {
                    let error = LiBaseError(data: jsonData)
                    return error
                } else {
                    return LiBaseError(errorMessage: LiCoreConstants.ErrorMessages.refreshFailed, httpCode: LiCoreConstants.ErrorCodes.forbidden)
                }
            }
        } catch let error {
            return error
        }
    }
}
