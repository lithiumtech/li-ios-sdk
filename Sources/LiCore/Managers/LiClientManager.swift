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
 Contains the result of api request
 - success: Returns the data on success of the network call.
 - failure: Returns error on failure of the network call.
 */
public enum Result<T> {
    case success(T)
    case failure(Error)
}
/**
 Use this class to perform network calls to clients.
 */
public struct LiClientManager {
    internal init() {}
    /**
     This method performs network calls to the provided client.
     
     - parameter client:    Pass the client of type `LiClient` with required parameters.
     - parameter completionHandler:   Closure containing the success response in the form of an array of objects conforming to LiBaseModel protocol from the network call.
     */
    public func request<T: LiBaseModel>(client: LiClient, completionHandler: @escaping (Result<[T]>) -> Void) {
        switch client {
        case .liUploadImageClient:
            LiRestClient.sharedInstance.upload(client: client, success: { (response: LiBaseResponse) in
                let data = T(data: response.data)
                completionHandler(Result.success([data]))
            }, failure: { (error: Error) in
                completionHandler(Result.failure(error))
            })
        default:
            LiRestClient.sharedInstance.request(client: client, success: { (response: LiBaseResponse) in
                if let items: [[String: Any]] = response.data["items"] as? [[String: Any]] {
                    var messages: [T] = []
                    for elm in items {
                        let message = T(data: elm)
                        messages.append(message)
                    }
                    completionHandler(Result.success(messages))
                } else {
                    let data = T(data: response.data)
                    completionHandler(Result.success([data]))
                }
            }) { (error: Error) in
                completionHandler(Result.failure(error))
            }
        }
    }
}
