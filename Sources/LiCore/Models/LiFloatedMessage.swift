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

public struct LiFloatedMessage: LiBaseModel {
    public private(set) var id: String?
    public private(set) var href: String?
    public private(set) var user: LiUser?
    public private(set) var message: LiMessage?
    public private(set) var scope: String?
    public init(data: [String: Any]) {
        self.id = data["id"] as? String
        self.href = data["href"] as? String
        if let messageData = data["message"] as? [String: Any] {
            self.message = LiMessage(data: messageData)
        }
        self.scope = data["scope"] as? String
    }
    mutating public func set(id: String?) {
        self.id = id
    }
    mutating public func set(href: String?) {
        self.href = href
    }
    mutating public func set(user: LiUser?) {
        self.user = user
    }
    mutating public func set(message: LiMessage?) {
        self.message = message
    }
    mutating public func set(scope: String?) {
        self.scope = scope
    }
}
