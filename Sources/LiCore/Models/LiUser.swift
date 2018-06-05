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
public struct LiUser: LiBaseModel {
    public fileprivate(set) var anonymous: Bool?
    public fileprivate(set) var avatarImage: LiImage?
    public fileprivate(set) var averageMessageRating: Float?
    public fileprivate(set) var averageRating: Float?
    public fileprivate(set) var banned: Bool?
    public fileprivate(set) var deleted: Bool?
    public fileprivate(set) var email: String?
    public fileprivate(set) var href: String?
    public fileprivate(set) var lastVisitInstant: String?
    ///username
    public fileprivate(set) var login: String?
    public fileprivate(set) var id: String?
    public fileprivate(set) var profilePageUrl: String?
    public fileprivate(set) var ranking: LiRanking?
    public fileprivate(set) var registered: Bool?
    public fileprivate(set) var registrationInstant: String?
    public fileprivate(set) var valid: Bool?
    public fileprivate(set) var avatar: LiAvatar?
    public init(data: [String: Any]) {
        self.anonymous = data["anonymous"] as? Bool
        self.averageMessageRating = data["average_message_rating"] as? Float
        self.averageRating = data["average_rating"] as? Float
        self.banned = data["banned"] as? Bool
        self.deleted = data["deleted"] as? Bool
        self.email = data["email"] as? String
        self.href = data["href"] as? String
        self.lastVisitInstant = data["last_visit_time"] as? String
        self.login = data["login"] as? String
        self.id = data["id"] as? String
        self.profilePageUrl = data["view_href"] as? String
        self.registered = data["registered"] as? Bool
        self.registrationInstant = data["registration_time"] as? String
        self.valid = data["valid"] as? Bool
        if let avatarData = data["avatar"] as? [String: Any] {
            self.avatar = LiAvatar(data: avatarData)
        }
    }
    mutating public func set(anonymous: Bool?) {
        self.anonymous = anonymous
    }
    mutating public func set(avatarImage: LiImage?) {
        self.avatarImage = avatarImage
    }
    mutating public func set(averageMessageRating: Float?) {
        self.averageMessageRating = averageMessageRating
    }
    mutating public func set(averageRating: Float?) {
        self.averageRating = averageRating
    }
    mutating public func set(banned: Bool?) {
        self.banned = banned
    }
    mutating public func set(deleted: Bool?) {
        self.deleted = deleted
    }
    mutating public func set(email: String?) {
        self.email = email
    }
    mutating public func set(href: String?) {
        self.href = href
    }
    mutating public func set(lastVisitInstant: String?) {
        self.lastVisitInstant = lastVisitInstant
    }
    mutating public func set(login: String?) {
        self.login = login
    }
    mutating public func set(id: String?) {
        self.id = id
    }
    mutating public func set(profilePageUrl: String?) {
        self.profilePageUrl = profilePageUrl
    }
    mutating public func set(ranking: LiRanking?) {
        self.ranking = ranking
    }
    mutating public func set(registered: Bool?) {
        self.registered = registered
    }
    mutating public func set(registrationInstant: String?) {
        self.registrationInstant = registrationInstant
    }
    mutating public func set(valid: Bool?) {
        self.valid = valid
    }
    mutating public func set(avatar: LiAvatar?) {
        self.avatar = avatar
    }
}
