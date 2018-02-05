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
struct LiAppSdkSettings {
    static var responseLimit: String? {
        return UserDefaults.standard.string(forKey: "LiResponseLimit")
    }
    static var discussionStyle: [String]? {
        return UserDefaults.standard.array(forKey: "LiDiscussionStyle") as? [String]
    }
    static func set(responseLimit: String) {
        UserDefaults.standard.set(responseLimit, forKey: "LiResponseLimit")
    }
    static func set(discussionStyle: [String]) {
        UserDefaults.standard.set(discussionStyle, forKey: "LiDiscussionStyle")
    }
}
