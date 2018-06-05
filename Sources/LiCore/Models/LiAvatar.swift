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
public struct LiAvatar {
    public private(set) var profile: String?
    public private(set) var message: String?
    public private(set) var inline: String?
    public private(set) var favicon: String?
    public private(set) var print: String?
    public private(set) var url: String?
    public private(set) var image: String?
    public private(set) var `internal`: String?
    public private(set) var external: String?
    init(data: [String: Any]) {
        self.profile = data["profile"] as? String
        self.message = data["message"] as? String
        self.inline = data["inline"] as? String
        self.favicon = data["favicon"] as? String
        self.print = data["print"] as? String
        self.url = data["url"] as? String
        self.image = data["image"] as? String
        self.`internal` = data["internal"] as? String
        self.external = data["external"] as? String
    }
    mutating public func set(profile: String?) {
        self.profile = profile
    }
    mutating public func set(message: String?) {
        self.message = message
    }
    mutating public func set(inline: String?) {
        self.inline = inline
    }
    mutating public func set(favicon: String?) {
        self.favicon = favicon
    }
    mutating public func set(print: String?) {
        self.print = print
    }
    mutating public func set(url: String?) {
        self.url = url
    }
    mutating public func set(image: String?) {
        self.image = image
    }
    mutating public func set(`internal`: String?) {
        self.`internal` = `internal`
    }
    mutating public func set(external: String?) {
        self.external = external
    }
}
