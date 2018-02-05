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
public class LiDefaultQueryHelper {
    static let sharedInstance = LiDefaultQueryHelper()
    var defaultSettings: [String: Any]
    init() {
        defaultSettings = LiDefaultQueryHelper.getDefaultSetting()
    }
    private static func getDefaultSetting() -> [String: Any] {
        guard let pathString = Bundle(for: self).path(forResource: "li_default_query_settings", ofType: "json") else {
            fatalError("li_default_query_settings.json not found")
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: pathString), options: .alwaysMapped)
            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any] ?? [:]
            return json
        } catch let error {
            print(error)
        }
        return [:]
    }
}
