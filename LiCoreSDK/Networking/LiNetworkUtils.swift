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
struct LiUrlConstructor {
    static func getBaseURL(client: LiClient) -> String {
        let clientName: String
        let apiProxyHost: String
        if let tenantId = LiSDKManager.shared().liAuthState.tenantId {
            clientName = tenantId
        } else {
            clientName = LiSDKManager.shared().liAppCredentials.tenantID
        }
        if let apiProxy = LiSDKManager.shared().liAuthState.apiProxyHost {
            apiProxyHost = apiProxy
        } else {
            apiProxyHost = LiSDKManager.shared().liAppCredentials.apiProxyHost
        }
        switch client {
        case .liUploadImageClient, .liCreateReplyClient, .liKudoClient, .liBeaconClient, .liNoLiqlClient, .liMessagesClient, .liRepliesClient, .liSearchClient, .liCategoryClient, .liBoardsByDepthClient, .liCategoryBoardsClient, .liMessagesByBoardIdClient, .liFloatedMessagesClient, .liCreateMessageClient, .liSdkSettingsClient, .liUserSubscriptionsClient, .liUserMessagesClient, .liUserDetailsClient, .liMessageClient, .liMessagesByIdsClient, .liAcceptSolutionClient, .liReportAbuseClient, .liDeviceIdFetchClient, .liCreateUserClient, .liSubscriptionPostClient, .liSubscriptionDeleteClient, .liMarkMessagePostClient, .liMarkMessagesPostClient, .liMarkTopicPostClient, .liUpdateMessageClient, .liUpdateUserClient, .liGenericPutClient, .liGenericPostClient, .liDeviceIdUpdateClient, .liGenericGetClient, .liGenericDeleteClient, .liMessageDeleteClient, .liUnKudoClient:
            return "https://" + apiProxyHost + "/community/2.0/" + clientName
        case .liSSOTokenRequest:
            return LiSDKManager.shared().liAppCredentials.communityURL
        case .getAccessToken, .refreshAccessToken:
            return "https://" + apiProxyHost
        }
    }
    static func getLiqlQuery(client: LiClient) -> String {
        if LiQueryConstant.QuerySettingType.liGenericType == client.querySettingType {
            return client.activityLIQL
        }
        let query = LiQueryBuilder.getQuery(baseQuery: client.activityLIQL, client: client.querySettingType)
        return query
    }
}
