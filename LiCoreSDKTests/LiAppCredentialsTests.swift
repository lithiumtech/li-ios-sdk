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

