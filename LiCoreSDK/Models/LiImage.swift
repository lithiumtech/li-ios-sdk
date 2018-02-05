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
public struct LiImage {
    public private(set) var href: String?
    public private(set) var height: Int?
    public private(set) var url: String?
    public private(set) var viewHref: String?
    public private(set) var width: Int?
    public private(set) var title: String?
    public private(set) var description: String?
    public private(set) var metaData: LiImageMetaData?
    public init(data: [String: Any]) {
        self.href = data["href"] as? String
        self.height = data["height"] as? Int
        self.url = data["url"] as? String
        self.viewHref = data["view_href"] as? String
        self.width = data["width"] as? Int
        self.title = data["title"] as? String
        self.description = data["description"] as? String
        if let imageMetaData = data["content"] as? [String: Any] {
            self.metaData = LiImageMetaData(data: imageMetaData)
        }
    }
    mutating public func set(href: String?) {
        self.href = href
    }
    mutating public func set(height: Int?) {
        self.height = height
    }
    mutating public func set(url: String?) {
        self.url = url
    }
    mutating public func set(viewHref: String?) {
        self.viewHref = viewHref
    }
    mutating public func set(width: Int?) {
        self.width = width
    }
    mutating public func set(title: String?) {
        self.title = title
    }
    mutating public func set(description: String?) {
        self.description = description
    }
    mutating public func set(metaData: LiImageMetaData?) {
        self.metaData = metaData
    }
}
