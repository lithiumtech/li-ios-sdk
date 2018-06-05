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
        let clientName: String = LiSDKManager.shared().appCredentials.tenantID
        let communityURL: String = LiSDKManager.shared().appCredentials.communityURL
        switch client {
        case .liUploadImageClient, .liCreateReplyClient, .liKudoClient, .liBeaconClient, .liNoLiqlClient, .liMessagesClient, .liRepliesClient, .liSearchClient, .liCategoryClient, .liBoardsByDepthClient, .liCategoryBoardsClient, .liMessagesByBoardIdClient, .liFloatedMessagesClient, .liCreateMessageClient, .liSdkSettingsClient, .liUserSubscriptionsClient, .liUserMessagesClient, .liUserDetailsClient, .liMessageClient, .liMessagesByIdsClient, .liAcceptSolutionClient, .liReportAbuseClient, .liDeviceIdFetchClient, .liCreateUserClient, .liSubscriptionPostClient, .liSubscriptionDeleteClient, .liMarkMessagePostClient, .liMarkMessagesPostClient, .liMarkTopicPostClient, .liUpdateMessageClient, .liUpdateUserClient, .liGenericPutClient, .liGenericPostClient, .liDeviceIdUpdateClient, .liGenericGetClient, .liGenericDeleteClient, .liMessageDeleteClient, .liUnKudoClient, .getAccessToken, .refreshAccessToken:
            return communityURL + "/" + clientName + "/api/2.0/"
        case .liSSOTokenRequest:
            return LiSDKManager.shared().appCredentials.communityURL
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
