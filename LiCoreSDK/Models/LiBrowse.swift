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
public class LiBrowse: LiBaseModel {
    public private(set) var id: String?
    public private(set) var title: String?
    public private(set) var depth: Int?
    public private(set) var parent: LiBrowse?
    public required init(data: [String: Any]) {
        self.id = data["id"] as? String
        self.title = data["title"] as? String
        self.depth = data["depth"] as? Int
        if let parentData = data["parent"] as? [String: Any] {
            self.parent = LiBrowse(data: parentData)
        }
    }
    public func set(id: String?) {
        self.id = id
    }
    public func set(title: String?) {
        self.title = title
    }
    public func set(depth: Int?) {
        self.depth = depth
    }
    public func set(parent: LiBrowse?) {
        self.parent = parent
    }
}
extension LiBrowse: Equatable {
    public static func == (lhs: LiBrowse, rhs: LiBrowse) -> Bool {
        return
            lhs.id == rhs.id
    }
}
