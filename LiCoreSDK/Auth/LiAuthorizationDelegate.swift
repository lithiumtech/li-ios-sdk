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
 The `LiAuthorizationDelegate` is designed to post process the results from login. You sould call use these methods to handle login successful and unsuccessful scenarios.
 */
public protocol LiAuthorizationDelegate: class {
    /**
     Call this function from the view controller you are initiating login. You can process the result of login using this function.
     
     - parameter status:   Status of login. `true` if successful.
     - parameter userId:   Optional Id of the logged in user. `nil` if login fails.
     - parameter error:    Optional error object containing the details of error. All lithium related error come as `LiBaseError`. `nil` if login successful.
     */
    func login(status: Bool, userId: String?, error: Error?)
}
