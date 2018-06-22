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

struct LiAuthResponse {
    var accessToken: String?
    var refreshToken: String?
    var expiresIn: String?
    var userId: String?
    var lithiumUserId: String?
    //TODO:- Move the logic to parse and save tokens here.
    func setAuthResponse(data: [String: Any]) -> Error? {
        guard let accessToken = data["access_token"] as? String,
            let refreshToken = data["refresh_token"] as? String,
            let userID = data["userId"] as? String,
            let lithiumUserID = data["lithiumUserId"] as? String,
            let expiresIn = data["expires_in"] as? Double else {
                let error = LiBaseError(errorMessage: LiCoreConstants.ErrorMessages.invalidAccessToken, httpCode: LiCoreConstants.ErrorCodes.forbidden)
                //self.loginViewController?.dismiss(animated: true, completion: nil)
                // self.authDelegate?.login(status: false, userId: nil, error: error)
                return error
        }
        LiSDKManager.shared().authState.set(accessToken: accessToken)
        LiSDKManager.shared().authState.set(refreshToken: refreshToken)
        LiSDKManager.shared().authState.set(userID: userID)
        LiSDKManager.shared().authState.set(lithiumUserID: lithiumUserID)
        let currentDate = NSDate()
        let newDate = NSDate(timeInterval: expiresIn, since: currentDate as Date)
        LiSDKManager.shared().authState.set(expiryDate: newDate)
        return nil
    }
}
