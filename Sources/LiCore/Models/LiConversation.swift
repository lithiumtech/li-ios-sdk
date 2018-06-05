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
public struct LiConversation {
    public private(set) var type: String?
    public private(set) var style: String?
    public private(set) var isSolved: Bool?
    public private(set) var lastPostTime: String?
    init(data: [String: Any]) {
        self.type = data["type"] as? String
        self.style = data["style"] as? String
        self.isSolved = data["solved"] as? Bool
        self.lastPostTime = data["last_post_time"] as? String
    }
    mutating public func set(type: String?) {
        self.type = type
    }
    mutating public func set(style: String?) {
        self.style = style
    }
    mutating public func set(isSolved: Bool?) {
        self.isSolved = isSolved
    }
    mutating public func set(lastPostTime: String?) {
        self.lastPostTime = lastPostTime
    }
}
