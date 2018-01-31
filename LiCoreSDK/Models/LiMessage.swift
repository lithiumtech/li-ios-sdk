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

public protocol LiBaseModel {}

public class LiMessage: LiBaseModel {
    public private(set) var board: LiBoard?
    public private(set) var parent: LiMessage?
    public private(set) var isFloating: Bool?
    public private(set) var boardId: Double?
    public private(set) var body: String?
    public private(set) var author: LiUser?
    public private(set) var messageMetrics: LiMessageMetrics?
    public private(set) var isAcceptedSolution: Bool?
    public private(set) var moderationStatus: LiModerationStatus?
    public private(set) var canAcceptSolution: Bool?
    public private(set) var userContext: LiUserContext?
    public private(set) var id: String?
    public private(set) var subject: String?
    public private(set) var postTime: String?
    public private(set) var conversation: LiConversation?
    public private(set) var kudos: LiKudoMetrics?
    public private(set) var replyCount: Int?
    ///Updated weight of the message. Comes during kudo/unkudo.
    public private(set) var weight: Int?
    ///Url for the message
    public private(set) var viewHref: String?
    init(data: [String: Any]) {
        if let id = data["id"] as? String {
            self.id = id
        }
        if let parentData = data["parent"] as? [String: Any] {
            self.parent = LiMessage(data: parentData)
        }
        self.subject = data["subject"] as? String
        self.postTime = data["post_time"] as? String
        self.isFloating = data["isFloating"] as? Bool
        self.boardId = data["board_id"] as? Double
        self.body = data["body"] as? String
        self.isAcceptedSolution = data["is_solution"] as? Bool
        self.canAcceptSolution = data["can_accept_solution"] as? Bool
        self.weight = data["weight"] as? Int
        self.viewHref = data["view_href"] as? String
        if let reply = data["replies"] as? [String: Any], let count = reply["count"] as? Int {
            self.replyCount = count
        }
        if let authorData = data["author"] as? [String: Any] {
            self.author = LiUser(data: authorData)
        }
        if let messageMetricsData = data["metrics"] as? [String: Any] {
            self.messageMetrics = LiMessageMetrics(data: messageMetricsData)
        }
        if let userContextData = data["user_context"] as? [String: Any] {
            self.userContext = LiUserContext(data: userContextData)
        }
        if let kudosData = data["kudos"] as? [String: Any] {
            self.kudos = LiKudoMetrics(data: kudosData)
        }
        if let conversationData = data["conversation"] as? [String: Any] {
            self.conversation = LiConversation(data: conversationData)
        }
        if let boardData = data["board"] as? [String: Any] {
            self.board = LiBoard(data: boardData)
        }
        if let modStatus = data["moderation_status"] as? String {
            self.moderationStatus = LiModerationStatus(rawValue: modStatus)
        }
    }
    public func set(id: String?) {
        self.id = id
    }
    public func set(parent: LiMessage?) {
        self.parent = parent
    }
    public func set(subject: String?) {
        self.subject = subject
    }
    public func set(postTime: String?) {
        self.postTime = postTime
    }
    public func set(isFloating: Bool?) {
        self.isFloating = isFloating
    }
    public func set(boardId: Double?) {
        self.boardId = boardId
    }
    public func set(body: String?) {
        self.body = body
    }
    public func set(isAcceptedSolution: Bool?) {
        self.isAcceptedSolution = isAcceptedSolution
    }
    public func set(isFloaticanAcceptSolutionng: Bool?) {
        self.canAcceptSolution = isFloaticanAcceptSolutionng
    }
    public func set(weight: Int?) {
        self.weight = weight
    }
    public func set(viewHref: String?) {
        self.viewHref = viewHref
    }
    public func set(replyCount: Int?) {
        self.replyCount = replyCount
    }
    public func set(author: LiUser?) {
        self.author = author
    }
    public func set(messageMetrics: LiMessageMetrics?) {
        self.messageMetrics = messageMetrics
    }
    public func set(userContext: LiUserContext?) {
        self.userContext = userContext
    }
    public func set(kudos: LiKudoMetrics?) {
        self.kudos = kudos
    }
    public func set(conversation: LiConversation?) {
        self.conversation = conversation
    }
    public func set(board: LiBoard?) {
        self.board = board
    }
    public func set(moderationStatus: LiModerationStatus?) {
        self.moderationStatus = moderationStatus
    }
}
