//
//  LiSDKManagerTests.swift
//  LiCoreSDKTests
//
//  Created by Shekhar Dahore on 3/23/18.
//  Copyright © 2018 Shekhar Dahore. All rights reserved.
//

import Quick
import Nimble
@testable import LiCoreSDK

class LiSDKManagerTests:  QuickSpec {
    override func spec() {
        let cred = LiAppCredentials(clientId: "a", clientSecret: "a", communityURL: "a", tenantID: "a", apiProxyHost: "a", clientAppName: "a")
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
