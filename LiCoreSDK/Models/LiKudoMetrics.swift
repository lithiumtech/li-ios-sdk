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
public struct LiKudoMetrics {
    public private(set) var weight: Int?
    init(data: [String: Any]) {
        if let sum = data["sum"] as? [String: Any], let weight = sum["weight"] as? Int {
            self.weight = weight
        }
    }
    ///Update weight of message.
    /// - parameter weight: new weight of the message.
    mutating public func set(weight: Int?) {
        self.weight = weight
    }
    ///Update weight of message.
    /// - parameter value: new weight of the message.
    /// - returns: new LiKudoMetrics object containting the updated vaule
    public func setWeight(value: Int, didKudo: Bool) -> LiKudoMetrics {
        var newKudoMetrics = self
        if didKudo {
            newKudoMetrics.weight = (newKudoMetrics.weight ?? 0) + value
        } else {
            newKudoMetrics.weight = (newKudoMetrics.weight ?? 1) - value
        }
        return newKudoMetrics
    }
}
