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
public struct LiImageMetaData {
    public private(set) var format: String?
    public private(set) var size: Int?
    public init(data: [String: Any]) {
        self.format = data["format"] as? String
        self.size = data["size"] as? Int
    }
    mutating public func set(format: String?) {
        self.format = format
    }
    mutating public func set(size: Int?) {
        self.size = size
    }
}
