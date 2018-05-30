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
public struct LiUserContext {
    public private(set) var kudo: Bool?
    public private(set) var isRead: Bool?
    public private(set) var canKudo: Bool?
    public private(set) var canReply: Bool?
    public private(set) var canDelete: Bool?
    public init(data: [String: Any]) {
        self.kudo = data["kudo"] as? Bool
        self.isRead = data["read"] as? Bool
        self.canKudo = data["can_kudo"] as? Bool
        self.canReply = data["can_reply"] as? Bool
        self.canDelete = data["can_delete"] as? Bool
    }
    ///Method used to update kudo/unkudo state of message with respect to current user.
    /// - parameter value: `true` for kudo and `false` for unkudo.
    mutating public func set(kudo: Bool?) {
        self.kudo = kudo
    }
    ///Method used to update read/unread state of message with respect to current user.
    /// - parameter value: `true` for read and `false` for unread.
    mutating public func set(isRead: Bool?) {
        self.isRead = isRead
    }
}
