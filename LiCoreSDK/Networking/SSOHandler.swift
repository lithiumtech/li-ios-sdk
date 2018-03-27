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
class SSOHandler: RequestRetrier {
    typealias RefreshCompletion = (_ succeeded: Bool, _ accessToken: String?, _ refreshToken: String?, _ expiresIn: Double?, _ error: Error?) -> Void
    private let sessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        return SessionManager(configuration: configuration)
    }()
    private let lock = NSLock()
    private var isRefreshing = false
    private var requestsToRetry: [RequestRetryCompletion] = []
    func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
        let data = request.delegate.data
        do {
            let error = try LiApiResponse.getLiBaseError(data: data)
            if error.httpCode == 401 {
                requestsToRetry.append(completion)
                if !isRefreshing {
                    refreshTokens { [weak self] succeeded, accessToken, refreshToken, expiresIn, error in
                        guard let strongSelf = self else { return }
                        strongSelf.lock.lock() ; defer { strongSelf.lock.unlock() }
                        if error != nil {
                            strongSelf.requestsToRetry.forEach { $0(false, 0.0) }
                            strongSelf.requestsToRetry.removeAll()
                            return
                        }
                        if let accessToken = accessToken, let refreshToken = refreshToken, let expiresIn = expiresIn {
                            LiSDKManager.shared().liAuthState.set(accessToken: accessToken)
                            LiSDKManager.shared().liAuthState.set(refreshToken: refreshToken)
                            let currentDate = NSDate()
                            let newDate = NSDate(timeInterval: expiresIn, since: currentDate as Date)
                            LiSDKManager.shared().liAuthState.set(expiryDate: newDate)
                        }
                        strongSelf.requestsToRetry.forEach { $0(succeeded, 0.0) }
                        strongSelf.requestsToRetry.removeAll()
                    }
                }
            } else {
                completion(false, 0.0)
            }
        } catch {
            completion(false, 0.0)
        }
    }
    func refreshTokens(completion: @escaping RefreshCompletion) {
        guard !isRefreshing else { return }
        isRefreshing = true
        sessionManager.request(LiClient.refreshAccessToken)
            .responseJSON { [weak self] response in
                guard let strongSelf = self else { return }
                switch response.result {
                case .success:
                    if let responseData = response.data {
                        do {
                            let json =  try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any]
                            if let jsonData = json?["response"] as? [String: Any] {
                                guard let data = jsonData["data"] as? [String: Any] else {
                                    let error = LiBaseError(data: jsonData)
                                    completion(false, nil, nil, nil, error)
                                    return
                                }
                                let accessToken = data["access_token"] as? String
                                let refreshToken = data["refresh_token"] as? String
                                let expiresIn = data["expires_in"] as? Double
                                strongSelf.isRefreshing = false
                                completion(true, accessToken, refreshToken, expiresIn, nil)
                            } else {
                                strongSelf.isRefreshing = false
                                if let jsonData = json {
                                    let error = LiBaseError(data: jsonData)
                                    completion(false, nil, nil, nil, error)
                                } else {
                                    completion(false, nil, nil, nil, LiBaseError(errorMessage: "Failed to refresh access token.", httpCode: LiCoreSDKConstants.LiErrorCodes.httpCodeServerError))
                                }
                            }
                        } catch let error {
                            completion(false, nil, nil, nil, error)
                        }
                    } else {
                        completion(false, nil, nil, nil, LiBaseError(errorMessage: "Failed to refresh access token.", httpCode: LiCoreSDKConstants.LiErrorCodes.httpCodeUnauthorized))
                    }
                case .failure:
                    completion(false, nil, nil, nil, response.error)
                }
        }
    }
}
