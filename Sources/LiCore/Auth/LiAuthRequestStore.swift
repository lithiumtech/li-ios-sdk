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
/**
 Request state store
 */
class LiAuthRequestStore {
    public static let sharedInstance = LiAuthRequestStore()
    private var authRequest: [String: URLRequest] = [:]
    init() {}
    /**
     Add request for a particular state
 */
    func addAuthRequest(data: URLRequest, state: String) {
        authRequest[state] = data
    }
    /**
     Check state
 */
    func checkRequest(forState state: String) -> Bool {
        if authRequest[state] != nil {
            authRequest.removeValue(forKey: state)
            return true
        }
        return false
    }
}
