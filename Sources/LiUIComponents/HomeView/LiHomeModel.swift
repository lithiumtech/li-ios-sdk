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
import LiCore
public struct LiHomeModel {
    var messages: [LiMessage]?
    var userMessages: [LiMessage]?
    func setMessages(data: [LiBaseModel]) -> LiHomeModel {
        var model = self
        guard let messages = data as? [LiMessage] else {
            return  self
        }
        model.messages = messages
        return model
    }
    func setUserMessages(data: [LiBaseModel]) -> LiHomeModel {
        var model = self
        guard let userMessages = data as? [LiMessage] else {
            return  self
        }
        model.userMessages = userMessages
        return model
    }
    func numberOfCells(inSection section: Int) -> Int {
        var count = 0
        if section == 0 {
            return 1
        } else if section == 1 {
            guard let messages = userMessages else {
                return count
            }
            count = messages.count > 3 ? 3:messages.count
        } else if section == 2 {
            guard let messages = messages else {
                return count
            }
            count = messages.count > 10 ? 10:messages.count
        }
        return count
    }
}
