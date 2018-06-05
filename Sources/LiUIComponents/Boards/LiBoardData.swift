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
struct LiBoardData {
    var messages: [LiMessage]
    init(data: [LiBaseModel]) {
        guard let messages = data as? [LiMessage] else {
            self.messages = []
            return
        }
        self.messages = messages
    }
    ///Sets pinned messsages as floating so the they appear on top
    /// - parameter data: Array of floating messages from the client .liFloatedMessagesClient
    /// - returns: Object of struct LiBoardData that sorted to put pinned messages at top.
    func floatingData(data: [LiBaseModel]) -> LiBoardData {
        guard let floatedMessages = data as? [LiFloatedMessage] else {
            return LiBoardData(data: messages)
        }
        var newData = messages.map { (message: LiMessage) -> LiMessage in
            let msg = message
            for floatMsg in floatedMessages where floatMsg.message?.id == message.id {
                msg.set(isFloating: true)
                return msg
            }
            msg.set(isFloating: false)
            return msg
        }
        newData = newData.sorted { $0.isFloating! && !$1.isFloating! }
        return LiBoardData(data: newData)
    }
}
