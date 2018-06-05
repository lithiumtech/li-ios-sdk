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
public struct LiBaseError: Error {
    ///Error code
    public let httpCode: Int
    ///Response status
    public let status: String
    ///Error message
    public let errorMessage: String
    ///Error response
    public var errorJson: [String: Any]?
    public init(errorData: Data) throws {
        do {
            let jsonData = try JSONSerialization.jsonObject(with: errorData, options: []) as? [String: Any]
            if let data = jsonData?["data"] as? [String: Any], let errorCode = data["code"] as? Int {
                self.httpCode = errorCode
                self.status = data["status"] as? String ?? ""
                self.errorMessage = data["developer_message"] as? String ?? LiCoreSDKConstants.LiErrorMessages.unknownError
                self.errorJson = jsonData
            } else if let statusCode = jsonData?["statusCode"] as? Int,
                let status = jsonData?["status"] as? String,
                let errorMessage = jsonData?["message"] as? String {
                self.httpCode = statusCode
                self.status = status
                self.errorMessage = errorMessage
            } else {
                self.httpCode = jsonData?["httpCode"] as? Int ?? LiCoreSDKConstants.LiErrorCodes.jsonSyntaxError
                self.errorMessage = jsonData?["message"] as? String ?? LiCoreSDKConstants.LiErrorMessages.unknownError
                self.status = jsonData?["status"] as? String ?? "error"
                self.errorJson = jsonData
            }
        } catch let error {
            throw error
        }
    }
    init(errorMessage: String, httpCode: Int) {
        self.errorMessage = errorMessage
        self.httpCode = httpCode
        self.status = "error"
    }
    init(data: [String: Any]) {
        self.status = data["status"] as? String ?? ""
        self.errorMessage = data["message"] as? String ?? LiCoreSDKConstants.LiErrorMessages.unknownError
        self.httpCode = data["statusCode"] as? Int ?? data["httpCode"] as? Int ?? 400
    }
}
