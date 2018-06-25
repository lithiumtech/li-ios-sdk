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
        //Do specific check for 401/403. Failure should return 401 according to oauth docs, check with team.
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
            }
        } else {
            completion(false, 0.0)
        }
    }
    func refreshTokens(completion: @escaping RefreshCompletion) {
        guard !isRefreshing else { return }
        isRefreshing = true
        sessionManager.request(LiClient.refreshAccessToken).validate()
            .responseJSON { [weak self] response in
                guard let strongSelf = self else { return }
                switch response.result {
                case .success:
                    let error = LiAuthResponse().setAuthResponse(data: response.data)
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
