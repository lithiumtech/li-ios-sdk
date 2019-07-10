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
class LiMessageViewModel {
    var messages: [LiMessage]
    var originalMessage: LiMessage
    var acceptedSolutions: [LiMessage]
    var discussion: [LiMessage]
    var contentHeightsOriginalMessage: [CGFloat]
    var contentHeightsAcceptedSolutions: [CGFloat]
    var contentHeightsDiscussion: [CGFloat]
    init(data: [LiMessage]) {
        messages = data
        originalMessage = messages.first!
        acceptedSolutions = messages.filter({ (m: LiMessage) -> Bool in
            if let isSolution =  m.isAcceptedSolution {
                return isSolution
            } else {
                return false
            }
        })
        discussion = messages.tail.filter({ (m: LiMessage) -> Bool in
            if let isSolution =  m.isAcceptedSolution {
                return !isSolution
            } else {
                return false
            }
        })
        contentHeightsOriginalMessage = [0.0]
        contentHeightsDiscussion = discussion.map({ (_) -> CGFloat in
            return 0.0
        })
        contentHeightsAcceptedSolutions = acceptedSolutions.map({ (_) -> CGFloat in
            return 0.0
        })
    }
    func getNumberOfSections() -> Int {
        if hasSolution() && !discussion.isEmpty {
            return 3
        } else if hasSolution() && discussion.isEmpty {
            return 2
        } else if !hasSolution() && !discussion.isEmpty {
            return 2
        } else {
            return 1
        }
    }
    func hasSolution() -> Bool {
        if acceptedSolutions.isEmpty {
            return false
        }
        return true
    }
    func acceptSolution(messageId: String) {
        if let messageIndex = discussion.firstIndex(where: { $0.id == messageId }) {
            let message = discussion.remove(at: messageIndex)
            message.set(isAcceptedSolution: true)
            acceptedSolutions.append(message)
            contentHeightsAcceptedSolutions.append(contentHeightsDiscussion.remove(at: messageIndex))
        }
    }
    func kudoSolution(messageId: String, kudo: Bool, weight: Int) -> IndexPath {
        if originalMessage.id == messageId {
            originalMessage = getKudoedMessage(message: originalMessage, didKudo: kudo, weight: weight)
            return IndexPath(row: 0, section: 0)
        } else {
            if let messageIndex = discussion.firstIndex(where: { $0.id == messageId }) {
                discussion[messageIndex] = getKudoedMessage(message: discussion[messageIndex], didKudo: kudo, weight: weight)
                if hasSolution() {
                    return IndexPath(row: messageIndex, section: 2)
                } else {
                    return IndexPath(row: messageIndex, section: 1)
                }
            } else if let messageIndex = acceptedSolutions.firstIndex(where: { $0.id == messageId }) {
                acceptedSolutions[messageIndex] = getKudoedMessage(message: acceptedSolutions[messageIndex], didKudo: kudo, weight: weight)
                return IndexPath(row: messageIndex, section: 1)
            }
        }
        return IndexPath(row: 0, section: 0)
    }
    func getKudoedMessage(message: LiMessage, didKudo: Bool, weight: Int) -> LiMessage {
        let message = message
        var newWeight: Int
        var newKudo = message.kudos
        let oldWeight = newKudo?.weight
        if didKudo {
            newWeight = (oldWeight ?? 0) + weight
        } else {
            newWeight = (oldWeight ?? 1) - weight
        }
        newKudo?.set(weight: newWeight)
        message.set(kudos: newKudo)
        var newUserContext = message.userContext
        newUserContext?.set(kudo: didKudo)
        message.set(userContext: newUserContext)
        return message
    }
    func numberOfRowsInSection(section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            if hasSolution() {
                return acceptedSolutions.count
            }
            return discussion.count
        default:
            return discussion.count
        }
    }
    func canDeleteMessage(messageId: String) -> Bool {
        return messages.first{$0.id == messageId}?.userContext?.canDelete ?? false
    }
}
