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
public struct LiBadge {
    public fileprivate(set) var id: String?
    public fileprivate(set) var description: String?
    public fileprivate(set) var title: String?
    public fileprivate(set) var iconURL: String?
    public fileprivate(set) var awarded: Int?
    public fileprivate(set) var activationDate: String?
    public fileprivate(set) var earnedDate: String?
    init(data: [String: Any]) {
        if let badgeInfo = data["badge"] as? [String: Any] {
            self.id = badgeInfo["id"] as? String
            self.description = badgeInfo["description"] as? String
            self.title = badgeInfo["title"] as? String
            self.iconURL = badgeInfo["icon_url"] as? String
            self.awarded = badgeInfo["awarded"] as? Int
            self.activationDate = badgeInfo["activation_date"] as? String
        }
        self.earnedDate = data["earned_date"] as? String
    }
    mutating public func set(id: String?) {
        self.id = id
    }
    mutating public func set(description: String?) {
        self.description = description
    }
    mutating public func set(title: String?) {
        self.title = title
    }
    mutating public func set(iconURL: String?) {
        self.iconURL = iconURL
    }
    mutating public func set(awarded: Int?) {
        self.awarded = awarded
    }
    mutating public func set(activationDate: String?) {
        self.activationDate = activationDate
    }
    mutating public func set(earnedDate: String?) {
        self.earnedDate = earnedDate
    }
}
