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
class SSOHandler: RequestAdapter, RequestRetrier {
    private let sessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        return SessionManager(configuration: configuration)
    }()
    private let lock = NSLock()
    private var isRefreshing = false
    private var requestsToRetry: [RequestRetryCompletion] = []
    // MARK: - RequestAdapter
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        if LiSDKManager.shared().authManager.isUserLoggedIn() {
            if let accessToken = LiSDKManager.shared().authState.accessToken {
                var urlRequest = urlRequest
                urlRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
                urlRequest.setValue("default", forHTTPHeaderField: "Auth-Service-Authorization")
                return urlRequest
            } else {
                throw LiBaseError(errorMessage: LiCoreConstants.ErrorMessages.emptyAccessTokenError, httpCode: LiCoreConstants.ErrorCodes.emptyAccessTokenError)
            }
        }
        return urlRequest
    }
    // MARK: - RequestRetrier
    func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
        lock.lock() ; defer { lock.unlock() }
        if request.retryCount == LiCoreConstants.maxRetry {
            completion(false, 0.0)
            return
        }
        let httpCode = request.response?.statusCode
        switch httpCode {
        case LiCoreConstants.ErrorCodes.unauthorized, LiCoreConstants.ErrorCodes.forbidden:
            requestsToRetry.append(completion)
            if !isRefreshing {
                refreshTokens { [weak self] succeeded, error in
                    guard let strongSelf = self else { return }
                    strongSelf.lock.lock() ; defer { strongSelf.lock.unlock() }
                    if error != nil {
                        strongSelf.requestsToRetry.forEach { $0(false, 0.0) }
                        strongSelf.requestsToRetry.removeAll()
                        return
                    }
                    strongSelf.requestsToRetry.forEach { $0(succeeded, 0.0) }
                    strongSelf.requestsToRetry.removeAll()
                    return
                }
            }
        case LiCoreConstants.ErrorCodes.internalServerError:
            request.request?.httpMethod?.lowercased() == "get" ? completion(false, 0.0) : completion(true, 1.0)
        case LiCoreConstants.ErrorCodes.clientTimeout, LiCoreConstants.ErrorCodes.badGateway, LiCoreConstants.ErrorCodes.serviceUnavailable, LiCoreConstants.ErrorCodes.gatewayTimeout:
            completion(true, 1.0)
        default:
            completion(false, 0.0)
        }
    }
    func refreshTokens(completion: @escaping RefreshCompletion) {
        guard !isRefreshing else { return }
        isRefreshing = true
        sessionManager.retrier = self
        sessionManager.request(LiClient.refreshAccessToken).validate()
            .responseJSON { [weak self] response in
                guard let strongSelf = self else { return }
                switch response.result {
                case .success:
                    let error = AuthResponse().setAuthResponse(data: response.data)
                    strongSelf.isRefreshing = false
                    if error == nil {
                        completion(true, nil)
                    } else {
                        completion(false, error)
                    }
                case .failure:
                    strongSelf.isRefreshing = false
                    completion(false, response.error)
                }
        }
    }
}
