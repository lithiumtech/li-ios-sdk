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
/**
 This class contains immutable copy of your community app credentials.
*/
public struct LiAppCredentials {
    /**
     Client id as set in Community API apps.
     */
    internal let clientId: String
    /**
     Client secret as set in Community API apps.
     */
    internal let clientSecret: String
    /**
     Community URL as set in Community API apps.
     */
    internal let communityURL: String
    ///URL used to make authorization call. It's obtained by appending path to the community url
    internal let authorizeURL: String
    ///URL used as redirect in authorization calls.
    internal let redirectURL: String
    /**
     Tenant Id as set in Community API apps.
     */
    internal let tenantID: String
    /**
     Api proxy host as set in Community API apps.
     */
    internal let apiProxyHost: String
    /**
     Client app name as set in Community API apps.
     */
    internal let clientAppName: String
    /**
     Creates a new instance of `LiAppCredentials`.
     
     - parameter clientId: Client id as set in Community API apps.
     - parameter clientSecret: Client secret as set in Community API apps.
     - parameter communityURL: Community URL as set in Community API apps.
     - parameter tenantID: Tenant Id as set in Community API apps.
     - parameter apiProxyHost: Api proxy host as set in Community API apps.
     - parameter clientAppName: Client app name as set in Community API apps.
     */
    public init(clientId: String, clientSecret: String, communityURL: String, tenantID: String, apiProxyHost: String, clientAppName: String) throws {
        self.clientId = try LiUtils.nonEmptyStringCheck(value: clientId, errorMessage: "SDK initalization failed: clientId cannot be empty.")
        self.clientSecret = try LiUtils.nonEmptyStringCheck(value: clientSecret, errorMessage: "SDK initalization failed: clientSecret cannot be empty.")
        self.communityURL = try LiUtils.urlValidation(url: communityURL, message: "SDK initalization failed: communityURL is in invalid format")
        self.tenantID = try LiUtils.nonEmptyStringCheck(value: tenantID, errorMessage: "SDK initalization failed: tenantID cannot be empty.")
        self.apiProxyHost = try LiUtils.nonEmptyStringCheck(value: apiProxyHost, errorMessage: "SDK initalization failed: apiProxyHost cannot be empty.")
        self.clientAppName = try LiUtils.nonEmptyStringCheck(value: clientAppName, errorMessage: "SDK initalization failed: clientAppName cannot be empty.")
        self.authorizeURL = communityURL + "/auth/oauth2/authorize"
        self.redirectURL =  communityURL.components(separatedBy: "//").last!.components(separatedBy: ".").reversed().joined(separator: ".") + "://oauth2callback"
    }
    /**
     Funtion to return URLRequest that initiates Lithium login.
     
     - returns: URLRequest containing the url and parameters for login.
     */
    func getURL() throws -> URLRequest {
        guard let url = URL(string: authorizeURL) else {
            throw LiBaseError(errorMessage: "Invalid LiCommunityUrl", httpCode: 0)
        }
        let urlRequest = URLRequest(url: url)
        let state = String(Date.timeIntervalSinceReferenceDate)
        let parameters = ["response_type": "code", "redirect_uri": redirectURL, "client_id": clientId, "state": state]
        do {
            let encodedURLRequest = try URLEncoding.queryString.encode(urlRequest, with: parameters)
            return encodedURLRequest
        } catch let error {
            throw error
        }
    }
}
