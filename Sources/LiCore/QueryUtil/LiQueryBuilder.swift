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
public class LiQueryBuilder {
    fileprivate static let `where` = "WHERE"
    fileprivate static let space = " "
    fileprivate static let orderBy = "ORDER BY"
    fileprivate static let limit = "LIMIT"
    private static func getDefault(client: String) -> [String: Any] {
        // swiftlint:disable:next force_cast
        return LiDefaultQueryHelper.sharedInstance.defaultSettings[client] as! [String: Any]
    }
    static func getClientJsonSetting(client: String) -> [String: Any] {
        let clientSettings  = getDefault(client: client)
        let serverSettings = getSettingFromServer()
        return overrideDefaultSettings(clientSettings: clientSettings, serverSettings: serverSettings)
    }
    static func getSettingFromServer() -> [String: Any] {
        var settingsFromServer: [String: Any] = [:]
        if let responseLimit = LiAppSdkSettings.responseLimit {
            settingsFromServer["response_limit"] = responseLimit
        }
        if let discussionStyle = LiAppSdkSettings.discussionStyle {
            settingsFromServer["discussion_style"] = discussionStyle
        }
        return settingsFromServer
    }
    static func overrideDefaultSettings(clientSettings: [String: Any], serverSettings: [String: Any]) -> [String: Any] {
        var newSettings = clientSettings
        if let responseLimit = serverSettings["response_limit"] as? String {
            newSettings["limit"] = responseLimit
        }
        if let discussionStyle = serverSettings["discussion_style"] as? [String] {
            var conversationStyleSB = ""
            var isFirst = true
            conversationStyleSB.append("(")
            for styleElem in discussionStyle {
                if isFirst {
                    isFirst = false
                } else {
                    conversationStyleSB.append(", ")
                }
                conversationStyleSB.append("'")
                conversationStyleSB.append(styleElem)
                conversationStyleSB.append("'")
            }
            conversationStyleSB.append(")")
            if var whereClauses = newSettings["whereClauses"] as? [[String: Any]] {
                var index = 0
                for whereClause in whereClauses {
                    if let key = whereClause["key"] as? String {
                        if key == "conversation.style" {
                            whereClauses[index]["value"] = conversationStyleSB
                        }
                    }
                    index += 1
                }
                newSettings["whereClauses"] = whereClauses
            }
        }
        return newSettings
    }
    static func getQuerySetting(baseQuery: String, client: String) -> LiQuerySetting? {
        let clientSettings = getClientJsonSetting(client: client)
        let liQuerySetting = LiQuerySetting(data: clientSettings)
        return liQuerySetting
    }
    static func buildQuery(baseQuery: String, liQuerySetting: LiQuerySetting) -> String {
        var query = ""
        query.append(baseQuery)
        query.append(space)
        let queryWhereClauseSize = liQuerySetting.whereClauses.count
        if queryWhereClauseSize > 0 {
            query.append(`where`)
            for index in 0..<queryWhereClauseSize {
                query.append(space)
                query.append(liQuerySetting.whereClauses[index].toString())
                if index < queryWhereClauseSize - 1 {
                    query.append(space)
                    query.append(liQuerySetting.whereClauses[index].operator)
                }
            }
        }
        if let ordering = liQuerySetting.ordering {
            query.append(space)
            query.append(orderBy)
            query.append(space)
            query.append(ordering.map{$0.toString()}.joined(separator: " ,"))
        }
        if let limitSetting = liQuerySetting.limit {
            query.append(space)
            query.append(limit)
            query.append(space)
            query.append(limitSetting)
        }
        return query
    }
    public static func getQuery(baseQuery: String, liQuerySetting: LiQuerySetting) -> String {
        return buildQuery(baseQuery: baseQuery, liQuerySetting: liQuerySetting)
    }
    public static func getQuery(baseQuery: String, client: String) -> String {
        let liQuerySetting = getQuerySetting(baseQuery: baseQuery, client: client)
        if let querySettings = liQuerySetting {
            return buildQuery(baseQuery: baseQuery, liQuerySetting: querySettings)
        }
        return baseQuery
    }
}
