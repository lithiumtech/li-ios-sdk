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

struct LiClientConfig {
    // swiftlint:disable cyclomatic_complexity
    static func getBaseQuery(client: LiClient) -> String {
        switch client {
        case .liMessagesByBoardIdClient, .liMessagesClient, .liSearchClient, .liUserMessagesClient:
            return LiQueryConstant.BaseLiql.liMessageListBaseLiql
        case .liCategoryBoardsClient, .liBoardsByDepthClient:
            return LiQueryConstant.BaseLiql.liBrowseClientBaseLiql
        case .liCategoryClient:
            return LiQueryConstant.BaseLiql.liCategoryClientBaseLiql
        case .liFloatedMessagesClient:
            return LiQueryConstant.BaseLiql.liFloatedMessageClientBaseLiql
        case .liMessageClient, .liMessagesByIdsClient, .liRepliesClient:
            return LiQueryConstant.BaseLiql.liMessageConversationBaseLiql
        case .liSdkSettingsClient:
            return LiQueryConstant.BaseLiql.liSdkSettingsClientBaseLiql
        case .liUserSubscriptionsClient:
            return LiQueryConstant.BaseLiql.liSubscriptionsClientBaseLiql
        case .liUserDetailsClient:
            return LiQueryConstant.BaseLiql.liUserDetailsClientBaseLiql
        default:
            return ""
        }
    }
    static func getType(client: LiClient) -> String {
        switch client {
        case .liMessagesByBoardIdClient:
            return LiQueryConstant.ResponseType.liArticlesBrowseClientType
        case .liCategoryBoardsClient, .liBoardsByDepthClient:
            return LiQueryConstant.ResponseType.liBrowseClientType
        case .liMessagesClient:
            return LiQueryConstant.ResponseType.liArticlesClientType
        case .liCategoryClient:
            return LiQueryConstant.ResponseType.liCategoryClientType
        case .liFloatedMessagesClient:
            return LiQueryConstant.ResponseType.liFloatedMessageClientType
        case .liRepliesClient:
            return LiQueryConstant.ResponseType.liMessageChildrenClientType
        case .liMessageClient, .liMessagesByIdsClient:
            return LiQueryConstant.ResponseType.liMessageClientType
        case .liUserMessagesClient:
            return LiQueryConstant.ResponseType.liQuestionsClientType
        case .liSdkSettingsClient:
            return LiQueryConstant.ResponseType.liSdkSettingsClientType
        case .liSearchClient:
            return LiQueryConstant.ResponseType.liSearchClientType
        case .liUserSubscriptionsClient:
            return LiQueryConstant.ResponseType.liSubscriptionsClientType
        case .liUserDetailsClient:
            return LiQueryConstant.ResponseType.liUserDetailsClientType
        default:
            return ""
        }
    }
    static func getQuerySettingType(client: LiClient) -> String {
        switch client {
        case .liMessagesByBoardIdClient:
            return LiQueryConstant.QuerySettingType.liArticlesBrowseQuerysettingsType
        case .liCategoryBoardsClient:
            return LiQueryConstant.QuerySettingType.liBrowseQuerysettingsType
        case .liMessagesClient:
            return LiQueryConstant.QuerySettingType.liArticlesQuerysettingsType
        case .liCategoryClient:
            return LiQueryConstant.QuerySettingType.liCategoryQuerysettingsType
        case .liFloatedMessagesClient:
            return LiQueryConstant.QuerySettingType.liFloatedMessageQuerysettingsType
        case .liRepliesClient:
            return LiQueryConstant.QuerySettingType.liMessageChildrenQuerysettingsType
        case .liMessageClient:
            return LiQueryConstant.QuerySettingType.liMessageQuerysettingsType
        case .liUserMessagesClient:
            return LiQueryConstant.QuerySettingType.liQuestionsQuerysettingsType
        case .liSdkSettingsClient:
            return LiQueryConstant.QuerySettingType.liSdkSettingsQuerysettingsType
        case .liSearchClient:
            return LiQueryConstant.QuerySettingType.liSearchQuerysettingsType
        case .liUserSubscriptionsClient:
            return LiQueryConstant.QuerySettingType.liSubscriptionQuerysettingsType
        case .liUserDetailsClient:
            return LiQueryConstant.QuerySettingType.liUserDetailsQuerysettingsType
        case .liBoardsByDepthClient:
            return LiQueryConstant.QuerySettingType.liBrowseByDepthQuerysettingsType
        case .liMessagesByIdsClient:
            return LiQueryConstant.QuerySettingType.liMessageByIdsQuerysettingsType
        default:
            return ""
        }
    }
}
