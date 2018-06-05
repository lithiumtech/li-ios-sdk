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
public struct LiCoreSDKConstants {
    public struct LiErrorCodes {
        public static let httpCodeForbidden = 403
        public static let httpCodeUnauthorized = 401
        public static let httpCodeServerError = 500
        public static let httpCodeServiceUnavailable = 503
        ///Thrown when unknown error json format is recieved.
        public static let jsonSyntaxError = 104
        public static let noResponseFound = 105
    }
    public struct LiErrorMessages {
        public static let unknownError = "Something seems wrong with the service. Please try again."
    }
    public struct LiUserDefaultConstants {
        public static let liAccessToken = "LiAccessToken"
        public static let liRefreshToken = "LiRefreshToken"
        public static let liUserId = "LiUserId"
        public static let liLithiumUserId = "LiLithiumUserId"
        public static let liExpiryDate = "LiExpiryDate"
        public static let liVisitOriginTime = "LiVisitOriginTime"
        public static let liVisitLastIssueTime = "LiVisitLastIssueTime"
        public static let liUserLoginStatus = "LiUserLoginStatus"
        public static let liNotificationId = "LiNotificationId"
        public static let liTenantId = "LiTenantId"
        public static let liVisitorId = "LiVisitorId"
    }
}
