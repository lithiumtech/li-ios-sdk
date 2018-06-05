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

public struct LiBoard {
    public private(set) var blog: Bool?
    public private(set) var id: String?
    public private(set) var interactionStyle: String?
    public private(set) var title: String?
    public private(set) var shortTitle: String?
    public private(set) var description: String?
    public init(data: [String: Any]) {
        self.blog = data["blog"] as? Bool
        self.id = data["id"] as? String
        self.interactionStyle = data["interaction_style"] as? String
        self.title = data["title"] as? String
        self.shortTitle = data["short_title"] as? String
        self.description = data["description"] as? String
    }
    mutating func set(blog: Bool?) {
        self.blog = blog
    }
    mutating func set(id: String?) {
        self.id = id
    }
    mutating func set(interactionStyle: String?) {
        self.interactionStyle = interactionStyle
    }
    mutating func set(title: String?) {
        self.title = title
    }
    mutating func set(shortTitle: String?) {
        self.shortTitle = shortTitle
    }
    mutating func set(description: String?) {
        self.description = description
    }
}
