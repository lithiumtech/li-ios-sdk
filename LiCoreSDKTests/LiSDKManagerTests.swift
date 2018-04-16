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

import Quick
import Nimble
@testable import LiCoreSDK

class LiSDKManagerTests: QuickSpec {
    override func spec() {
        let cred = try! LiAppCredentials(clientId: "a", clientSecret: "a", communityURL: "a", tenantID: "a", apiProxyHost: "a", clientAppName: "a")
        describe("LiSDKManager") {
            LiSDKManager.setup(credentials: cred)
            context("Calling setup before using shared instance") {
                it("Should not throw error") {
                    expect { LiSDKManager.shared() }.toNot( throwError() )
                }
            }
            context("Calling Visitor Id after setup") {
                it("should not be nil") {
                    expect { LiSDKManager.shared().visitorId }.toNot(beNil())
                }
            }
        }
    }
    public func testDummy() {}
}
