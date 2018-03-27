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
A type of closure that is used to return success response from clients.
 - parameter response: Array of objects that conform to LiBaseModel protocol
 */
public typealias LiSuccessResponse = (_ response: [LiBaseModel]) -> Void
/**
 A type of closure that is used to return error response from clients.
 - parameter error: Error object.
 */
public typealias LiErrorResponse = (_ error: Error) -> Void
/**
 Use this class to perform network calls to clients.
 */
public struct LiClientManager {
    internal init() {}
    /**
     This method performs network calls to the provided client.
     
     - parameter client:    Pass the client of type `LiClient` with required parameters.
     - parameter success:   Closure containing the success response in the form of an array of objects conforming to LiBaseModel protocol from the network call.
     - parameter error:     Closure containing the failure response from the network call.
     */
    public func request(client: LiClient, success: @escaping LiSuccessResponse, failure: @escaping LiErrorResponse) {
        switch client {
        case .liUploadImageClient:
            LiRestClient.sharedInstance.upload(client: client, success: { (response: LiBaseResponse) in
                do {
                    let result = try LiResponse.getResult(for: client, from: response)
                    success(result)
                } catch (let error) {
                    failure(error)
                }
            }, failure: { (error: Error) in
                failure(error)
            })
        default:
            LiRestClient.sharedInstance.request(client: client, success: { (response: LiBaseResponse) in
                do {
                    let result = try LiResponse.getResult(for: client, from: response)
                    success(result)
                } catch (let error) {
                    failure(error)
                }
            }) { (error: Error) in
                failure(error)
            }
        }
    }
}
