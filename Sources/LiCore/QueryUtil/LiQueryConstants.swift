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
public struct LiQueryConstant {
    public struct BaseLiql {
        public static let liSubscriptionsClientBaseLiql = "SELECT id, target.author, target.id, target.subject, target.post_time, target.kudos.sum(weight), target.body, target.conversation.style, target.conversation.solved, target.conversation.last_post_time FROM subscriptions"
        public static let liBrowseClientBaseLiql = "select id, title, parent.id, parent.title, depth from nodes"
        public static let liCategoryClientBaseLiql = "select id, title, parent.id, parent.title, depth from nodes"
        public static let liUserDetailsClientBaseLiql = "SELECT email, href, last_visit_time, login, id, view_href, avatar from users"
        public static let liFloatedMessageClientBaseLiql = "select * from floated_messages"
        public static let liSdkSettingsClientBaseLiql = "select additional_information from app_sdk_settings"
        public static let liMessageListBaseLiql = "SELECT id, subject, view_href, board.id, post_time, kudos.sum(weight), conversation.style, conversation.solved, conversation.last_post_time, user_context, author, author.id, author.avatar, author.rank, author.login, author.href, author.email, parent.id, metrics, replies.count(*) FROM messages"
        public static let liMessageConversationBaseLiql = "SELECT id, body, subject, view_href, post_time, kudos.sum(weight), can_accept_solution, is_solution, user_context.kudo, user_context.can_kudo, user_context.can_reply, user_context.can_delete, user_context.read, author, author.id, author.href, author.email,  author.avatar, author.rank, author.login, parent.id, metrics, replies.count(*) FROM messages"
    }
    public struct ResponseType {
        public static let liAcceptSolutionType = "solution_data"
        public static let liKudoType = "kudo"
        public static let liPostQuestionType = "message"
        public static let liReplyMessageType = "message"
        public static let liArticlesClientType = "message"
        public static let liSubscriptionsClientType = "subscription"
        public static let liBrowseClientType = "node"
        public static let liSearchClientType = "message"
        public static let liMessageChildrenClientType = "message"
        public static let liQuestionsClientType = "message"
        public static let liCategoryClientType = "node"
        public static let liArticlesBrowseClientType = "message"
        public static let liUserDetailsClientType = "user"
        public static let liMessageClientType = "message"
        public static let liSdkSettingsClientType = "app_sdk_setting"
        public static let liUserDeviceIdFetchType = "user_device_data"
        public static let liApplicationType = "IOS"
        public static let liMarkMessageClientType = "message_read"
        public static let liImageType = "image"
        public static let liFloatedMessageClientType = "floated_message"
    }
    public struct QuerySettingType {
        public static let liArticlesQuerysettingsType = "article"
        public static let liSubscriptionQuerysettingsType = "subscription"
        public static let liBrowseQuerysettingsType = "node"
        public static let liBrowseByDepthQuerysettingsType = "node_depth"
        public static let liSearchQuerysettingsType = "search"
        public static let liMessageChildrenQuerysettingsType = "message_children"
        public static let liQuestionsQuerysettingsType = "questions"
        public static let liCategoryQuerysettingsType = "category"
        public static let liArticlesBrowseQuerysettingsType = "article_browse"
        public static let liUserDetailsQuerysettingsType = "user"
        public static let liMessageQuerysettingsType = "message"
        public static let liMessageByIdsQuerysettingsType = "messages_by_ids"
        public static let liFloatedMessageQuerysettingsType = "floated_message"
        public static let liSdkSettingsQuerysettingsType = "app_sdk_setting"
        public static let liGenericType = "generic_get"
        public static let liMarkAbuseType = "abuse_report"
    }
    public static let liMarkAsRead = "api.mark_read"
    public static let liForUISearch = "api.for_ui_search"
    public static let liInsertImageMacro = "<p><li-image id=%@ width=\"500\" height=\"500\" alt=%@ align=\"inline\" size=\"large\" sourcetype=\"new\"></li-image></p>"
    public static let liLineSeparator = "\n"
    public static let defaultLiqlQueryLimit = 25
    public static let liMessageType = "messages"
    public static let liSubscriptionType = "subscriptions"
    internal static let apiVersion = "0.1.0"
}
