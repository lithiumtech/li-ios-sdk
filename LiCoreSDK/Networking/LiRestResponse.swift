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
 This class parses the network response to the appropriate model based on the client.
 */
struct LiResponse {
    static func getResult(for client: LiClient, from response: LiBaseResponse) throws -> [LiBaseModel] {
        switch client {
            /*
             Clients that return [LiMessage]
             */
        case .liMessagesClient, .liMessagesByBoardIdClient, .liRepliesClient, .liSearchClient, .liUserMessagesClient, .liMessagesByIdsClient, .liMessageClient:
            guard let items: [[String: Any]] = response.data["items"] as? [[String: Any]] else {
                throw LiBaseError(errorMessage: "Response parsing failed.", httpCode: LiCoreSDKConstants.LiErrorCodes.jsonSyntaxError)
            }
            var messages: [LiMessage] = []
            for elm in items {
                let message = LiMessage(data: elm)
                messages.append(message)
            }
            return messages
            /*
             Clients that return [LiBrowse]
             */
        case .liCategoryBoardsClient, .liBoardsByDepthClient, .liCategoryClient:
            guard let items: [[String: Any]] = response.data["items"] as? [[String: Any]] else {
                throw LiBaseError(errorMessage: "Response parsing failed.", httpCode: LiCoreSDKConstants.LiErrorCodes.jsonSyntaxError)
            }
            var categories: [LiBrowse] = []
            for elm in items {
                let data = LiBrowse(data: elm)
                categories.append(data)
            }
            return categories
            /*
             Clients that return [LiFloatedMessage]
             */
        case .liFloatedMessagesClient:
            guard let items: [[String: Any]] = response.data["items"] as? [[String: Any]] else {
                throw LiBaseError(errorMessage: "Response parsing failed.", httpCode: LiCoreSDKConstants.LiErrorCodes.jsonSyntaxError)
            }
            var messages: [LiFloatedMessage] = []
            for elm in items {
                let message = LiFloatedMessage(data: elm)
                messages.append(message)
            }
            return messages
            /*
             Clients that return [LiImageResponse]
             */
        case .liUploadImageClient:
            let imageResponse = LiImageResponse(data: response.data)
            return [imageResponse]
            /*
             Clients that return [LiMessage] with data at index 0.
             */
        case .liKudoClient, .liUnKudoClient, .liUpdateMessageClient:
            let data = LiMessage(data: response.data)
            return [data]
            /*
             Clients that return [LiUser]
             */
        case .liUserDetailsClient:
            guard let items: [[String: Any]] = response.data["items"] as? [[String: Any]], let firstItem = items.first else {
                throw LiBaseError(errorMessage: "Response parsing failed.", httpCode: LiCoreSDKConstants.LiErrorCodes.jsonSyntaxError)
            }
            let data = LiUser(data: firstItem)
            return [data]
            /*
             Clients that return [LiSubscriptions]
             */
        case .liUserSubscriptionsClient:
            guard let items: [[String: Any]] = response.data["items"] as? [[String: Any]] else {
                throw LiBaseError(errorMessage: "Response parsing failed.", httpCode: LiCoreSDKConstants.LiErrorCodes.jsonSyntaxError)
            }
            var subscriptions: [LiSubscriptions] = []
            for elm in items {
                let subscription = LiSubscriptions(data: elm)
                subscriptions.append(subscription)
            }
            return subscriptions
            /*
             Clients that return [LiSubscriptions]
             */
        case .liSubscriptionPostClient:
            let data = LiSubscriptions(data: response.data)
            return [data]
            /*
             Clients that return [LiGenericQueryResponse]
             */
        default:
            let data = LiGenericQueryResponse(data: response.data)
            return [data]
        }
    }
}
