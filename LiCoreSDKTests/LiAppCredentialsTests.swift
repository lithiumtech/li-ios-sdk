//
//  LiAppCredentialsTests.swift
//  LiCoreSDKTests
//
//  Created by Shekhar Dahore on 3/26/18.
//  Copyright © 2018 Shekhar Dahore. All rights reserved.
//

import Quick
import Nimble
@testable import LiCoreSDK

class LiAppCredentialsTests: QuickSpec {
    override func spec() {
        describe("LiAppCredentials") {
            context("Setting up with proper credentials") {
                it("Should not throw error") {
                    expect { try LiAppCredentials(clientId: "a", clientSecret: "a", communityURL: "https://google.com", tenantID: "a", apiProxyHost: "a", clientAppName: "a")}.toNot( throwError() )
                }
            }
            context("Setting up credentials with empty clientId") {
                it("Should throw error") {
                    expect { try LiAppCredentials(clientId: "", clientSecret: "a", communityURL: "https://google.com", tenantID: "a", apiProxyHost: "a", clientAppName: "a")}.to( throwError() )
                }
            }
            context("Setting up credentials with empty clientSecret") {
                it("Should throw error") {
                    expect { try LiAppCredentials(clientId: "a", clientSecret: "", communityURL: "https://google.com", tenantID: "a", apiProxyHost: "a", clientAppName: "a")}.to( throwError() )
                }
            }
            context("Setting up credentials with empty communityURL") {
                it("Should throw error") {
                    expect { try LiAppCredentials(clientId: "a", clientSecret: "a", communityURL: "", tenantID: "a", apiProxyHost: "a", clientAppName: "a")}.to( throwError() )
                }
            }
            context("Setting up credentials with empty tenantID") {
                it("Should throw error") {
                    expect { try LiAppCredentials(clientId: "a", clientSecret: "a", communityURL: "https://google.com", tenantID: "", apiProxyHost: "a", clientAppName: "a")}.to( throwError() )
                }
            }
            context("Setting up credentials with empty apiProxyHost") {
                it("Should throw error") {
                    expect { try LiAppCredentials(clientId: "a", clientSecret: "a", communityURL: "https://google.com", tenantID: "a", apiProxyHost: "", clientAppName: "a")}.to( throwError() )
                }
            }
            context("Setting up credentials with empty clientAppName") {
                it("Should throw error") {
                    expect { try LiAppCredentials(clientId: "a", clientSecret: "a", communityURL: "https://google.com", tenantID: "a", apiProxyHost: "a", clientAppName: "")}.to( throwError() )
                }
            }
            context("Setting up credentials with invalid communityURL") {
                it("Should throw error") {
                    expect { try LiAppCredentials(clientId: "a", clientSecret: "a", communityURL: "http//google.com", tenantID: "a", apiProxyHost: "a", clientAppName: "a")}.to( throwError() )
                }
            }
            context("Setting up credentials with invalid communityURL") {
                it("Should throw error") {
                    expect { try LiAppCredentials(clientId: "a", clientSecret: "a", communityURL: "google.com", tenantID: "a", apiProxyHost: "a", clientAppName: "a")}.to( throwError() )
                }
            }
        }
        
        describe("LiAppCredentials") {
            let appCred = try! LiAppCredentials(clientId: "12jasj32nnds", clientSecret: "121fa322dsds", communityURL: "https://google.com", tenantID: "game223", apiProxyHost: "com.api.proxy", clientAppName: "test")
            context("get URL that initiates lithium login") {
                var url: URLRequest?
                it("url should match") {
                    expect { url = try appCred.getURL() }.toNot(throwError())
                    expect(url?.url?.absoluteString.contains("https://google.com/auth/oauth2/authorize?client_id=12jasj32nnds&redirect_uri=com.google%3A//oauth2callback&response_type=code&state=")).to(beTruthy())
                }
            }
        }
    }
    public func testDummy() {}
}

