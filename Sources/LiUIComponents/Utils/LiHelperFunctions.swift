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

import UIKit
public class LiHelperFunctions {
    public static func timeSince(post date: String?) -> String {
        guard let date = date else {
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateFormat = LiUIConstants.dateTimeUTCFormat
        guard let localDate = formatter.date(from: date) else {
            print("Invalid date format found", date)
            return ""
        }
        return LiHelperFunctions.timeSince(date: localDate)
    }
    private static func timeSince(date: Date) -> String {
        let calendar = Calendar.current
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .second]
        let now = Date()
        let latest = (date == now as Date) ? date : now
        let components = calendar.dateComponents(unitFlags, from: date, to: latest)
        guard let day = components.day, let hour = components.hour, let minute = components.minute, let second = components.second  else {
            assert(false, "One/All time components is/are nil")
            return ""
        }
        if day >= 1 {
            return "\(day)" + LiHelperFunctions.localizedString(for: "d")
        } else if hour >= 1 {
                return "\(hour)" + LiHelperFunctions.localizedString(for:"h")
        } else if minute >= 1 {
            return "\(minute)" + LiHelperFunctions.localizedString(for:"m")
        } else if second >= 3 {
            return "\(second)" + LiHelperFunctions.localizedString(for:"s")
        } else {
            return LiHelperFunctions.localizedString(for: "Just now")
        }
    }
    static func localizedString(for: String) -> String {
        return NSLocalizedString(`for`, tableName: nil, bundle: Bundle(for: self), value: "", comment: "")
    }
}
