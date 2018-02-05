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
struct LiBaseResponse {
    let httpCode: Int
    let status: String
    let message: String
    let data: [String: Any]
    init(responseData: Data) throws {
        do {
            let jsonData = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any]
            if let data = jsonData?["data"] as? [String: Any] {
                if let errorCode = data["code"] as? Int {
                    if errorCode == 301 || errorCode == 403 {
                        do {
                            throw try LiBaseError(errorData: responseData)
                        } catch let error {
                            throw error
                        }
                    }
                }
            }
            if let data = jsonData?["response"] as? [String: Any] {
                guard let statusCode = data["httpCode"] as? Int,
                    let status = data["status"] as? String,
                    let message = data["message"] as? String
                    else {
                        throw LiBaseError(data: data)
                }
                if let data = data["data"] as? [String: Any] {
                    self.data = data
                } else {
                    self.data = [:]
                }
                self.httpCode = statusCode
                self.status = status
                self.message = message
            } else if let statusCode = jsonData?["http_code"] as? Int {
                guard let status = jsonData?["status"] as? String,
                    let message = jsonData?["message"] as? String
                    else {
                        do {
                           throw try LiBaseError(errorData: responseData)
                        } catch let error {
                            throw error
                        }
                }
                if let data = jsonData?["data"] as? [String: Any] {
                    self.data = data
                } else {
                    self.data = [:]
                }
                self.httpCode = statusCode
                self.status = status
                self.message = message
            } else if let data = jsonData?["data"] as? [String: Any], let status = jsonData?["status"] as? String {
                self.data = data
                self.status = status
                self.message = ""
                self.httpCode = 200
            } else {
                do {
                    throw try LiBaseError(errorData: responseData)
                } catch let error {
                    throw error
                }
            }
        } catch let error {
            throw error
        }
    }
}
