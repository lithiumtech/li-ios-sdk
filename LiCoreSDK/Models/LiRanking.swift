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
///A rank model represents a way to recognize and reward community members' achievements.
public struct LiRanking {
    public private(set) var href: String?
    public private(set) var name: String?
    public private(set) var id: String?
    public private(set) var type: String?
    public private(set) var position: String?
    public private(set) var color: String?
    public private(set) var iconLeft: String?
    public private(set) var iconRight: String?
    public private(set) var formula: String?
    public private(set) var iconTopic: String?
    public private(set) var formulaEnabled: Bool?
    public private(set) var bold: Bool?
    public private(set) var lithiumRankingDisplay: LiRankingDisplay?
    public init(data: [String: Any]) {
        self.href = data["href"] as? String
        self.name = data["name"] as? String
        self.id = data["id"] as? String
        self.type = data["type"] as? String
        self.position = data["position"] as? String
        self.color = data["color"] as? String
        self.iconLeft = data["icon_left"] as? String
        self.iconRight = data["icon_right"] as? String
        self.formula = data["formula"] as? String
        self.iconTopic = data["icon_topic"] as? String
        self.formulaEnabled = data["formula_enabled"] as? Bool
        self.bold = data["bold"] as? Bool
        if let rankingDisplay = data[""] as? [String: Any] {
            self.lithiumRankingDisplay = LiRankingDisplay(data: rankingDisplay)
        }
    }
    mutating public func set(href: String?) {
        self.href = href
    }
    mutating public func set(name: String?) {
        self.name = name
    }
    mutating public func set(id: String?) {
        self.id = id
    }
    mutating public func set(type: String?) {
        self.type = type
    }
    mutating public func set(position: String?) {
        self.position = position
    }
    mutating public func set(color: String?) {
        self.color = color
    }
    mutating public func set(iconLeft: String?) {
        self.iconLeft = iconLeft
    }
    mutating public func set(iconRight: String?) {
        self.iconRight = iconRight
    }
    mutating public func set(formula: String?) {
        self.formula = formula
    }
    mutating public func set(iconTopic: String?) {
        self.iconTopic = iconTopic
    }
    mutating public func set(formulaEnabled: Bool?) {
        self.formulaEnabled = formulaEnabled
    }
    mutating public func set(bold: Bool?) {
        self.bold = bold
    }
    mutating public func set(lithiumRankingDisplay: LiRankingDisplay?) {
        self.lithiumRankingDisplay = lithiumRankingDisplay
    }
}
