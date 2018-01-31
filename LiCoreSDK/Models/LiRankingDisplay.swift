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
public struct LiRankingDisplay {
    public private(set) var bold: Bool?
    public private(set) var color: String?
    public private(set) var leftImage: LiImage?
    public private(set) var rightImage: LiImage?
    public private(set) var threadImage: LiImage?
    public init(data: [String: Any]) {
        self.bold = data["bold"] as? Bool
        self.color = data["color"] as? String
        if let leftImage = data["left_image"] as? [String: Any] {
            self.leftImage = LiImage(data: leftImage)
        }
        if let rightImage = data["right_image"] as? [String: Any] {
            self.rightImage = LiImage(data: rightImage)
        }
        if let threadImage = data["thread_image"] as? [String: Any] {
            self.threadImage = LiImage(data: threadImage)
        }
    }
    mutating public func set(bold: Bool?) {
        self.bold = bold
    }
    mutating public func set(color: String?) {
        self.color = color
    }
    mutating public func set(leftImage: LiImage?) {
        self.leftImage = leftImage
    }
    mutating public func set(rightImage: LiImage?) {
        self.rightImage = rightImage
    }
    mutating public func set(threadImage: LiImage?) {
        self.threadImage = threadImage
    }
}
