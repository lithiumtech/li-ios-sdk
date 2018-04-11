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
import Alamofire

typealias Success = (_ data: LiBaseResponse) -> Void
typealias Failure = (_ error: Error) -> Void
class LiRestClient {
    static let sharedInstance = LiRestClient()
    internal let sessionManager = SessionManager()
    private let oauthHandler = SSOHandler()
    init() {
        sessionManager.retrier = oauthHandler
    }
    fileprivate func logBeaconCall(_ response: (DataResponse<Any>)) {
        if let path = response.request?.url?.path.contains("becon") {
            if path {
                if let visitLastIssueTime = response.response?.allHeaderFields["Visit-Last-Issue-Time"] as? String {
                    LiSDKManager.shared().liAuthState.set(visitLastIssueTime: visitLastIssueTime)
                }
                if let visitOriginTime = response.response?.allHeaderFields["Visit-Origin-Time"] as? String {
                    LiSDKManager.shared().liAuthState.set(visitOriginTime: visitOriginTime)
                }
            }
        }
    }
    func request <T: Router> (client: T, success: @escaping Success, failure: @escaping Failure) {
        accessToken(client: client) { [weak self] (isValid, error) in
            guard let strongSelf = self else { return }
            if isValid {
                strongSelf.sessionManager.request(client).validate().responseJSON { response in
                    switch response.result {
                    case .success:
                        do {
                            strongSelf.logBeaconCall(response)
                            let data = try LiApiResponse.getLiBaseResponse(data: response.data)
                            success(data)
                        } catch let error {
                            failure(error)
                        }
                    case .failure:
                        // when api proxy is loaded it sends 503 error with no json payload.
                        // this is a check for that. Load test again and see.
                        if response.response?.statusCode == 503 {
                            if let err = response.error {
                                failure(err)
                                return
                            }
                        }
                        do {
                            let data = try LiApiResponse.getLiBaseError(data: response.data)
                            failure(data)
                        } catch let error {
                            failure(error)
                        }
                    }
                }
            } else {
                failure(error ?? LiBaseError(errorMessage: "Failed to refresh access token.", httpCode: LiCoreSDKConstants.LiErrorCodes.httpCodeUnauthorized))
            }
        }
    }
    private func accessToken <T: Router> (client: T, isValid: @escaping (Bool, Error?) -> Void) {
        if !LiSDKManager.shared().liAuthManager.isUserLoggedIn() {
            isValid(true, nil)
        } else {
            if isAccessTokenValid() {
                isValid(true, nil)
            } else {
                oauthHandler.refreshTokens(completion: { succeeded, accessToken, refreshToken, expiresIn, error in
                    if succeeded {
                        if let accessToken = accessToken, let refreshToken = refreshToken, let expiresIn = expiresIn {
                            LiSDKManager.shared().liAuthState.set(accessToken: accessToken)
                            LiSDKManager.shared().liAuthState.set(refreshToken: refreshToken)
                            let currentDate = NSDate()
                            let newDate = NSDate(timeInterval: expiresIn, since: currentDate as Date)
                            LiSDKManager.shared().liAuthState.set(expiryDate: newDate)
                        }
                        isValid(true, nil)
                    } else {
                        isValid(false, error)
                    }
                })
            }
        }
    }
    private func isAccessTokenValid() -> Bool {
        let todaysDate = NSDate()
        if let waitingDate: NSDate = LiSDKManager.shared().liAuthState.expiryDate {
            if todaysDate.compare(waitingDate as Date) == ComparisonResult.orderedDescending {
                return false
            } else {
                return true
            }
        }
        return false
    }
}
