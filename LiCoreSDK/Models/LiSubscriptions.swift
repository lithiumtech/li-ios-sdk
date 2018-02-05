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
public struct LiSubscriptions: LiBaseModel {
    public private(set) var id: String?
    public private(set) var type: String?
    public private(set) var targetObject: [String: Any]?
    public private(set) var user: LiUser?
    init(data: [String: Any]) {
        self.id = data["id"] as? String
        self.type = data["type"] as? String
        self.targetObject = data["target"] as? [String: Any]
        if let subscriberData = data["subscriber"] as? [String: Any] {
            self.user = LiUser(data: subscriberData)
        }
    }
    mutating public func set(user: LiUser?) {
        self.user = user
    }
    mutating public func set(id: String?) {
        self.id = id
    }
    mutating public func set(type: String?) {
        self.type = type
    }
    public func getLiMessage() -> LiMessage? {
        guard let target = targetObject else {
            return nil
        }
        if let typeOfObject = target["type"] as? String, typeOfObject == "message" {
            return LiMessage(data: target)
        } else {
            return nil
        }
    }
    public func getLiBoard() -> LiBoard? {
        guard let target = targetObject else {
            return nil
        }
        if let typeOfObject = target["type"] as? String, typeOfObject == "board" {
            return LiBoard(data: target)
        } else {
            return nil
        }
    }
    mutating public func set(targetObject: [String: Any]?) {
        self.targetObject = targetObject
    }
}
