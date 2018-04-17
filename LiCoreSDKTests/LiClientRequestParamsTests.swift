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
class LiMessagesByBoardIdClientRequestParamsTests: QuickSpec {
    override func spec() {
        describe("LiMessagesByBoardIdClientRequestParams") {
            context("After being properly initalize") {
                it("Should not throw error") {
                    expect { try LiMessagesByBoardIdClientRequestParams(boardId: "abc") }.toNot( throwError() )
                }
            }
            context("After being initalized with an empty sting") {
                it("should throw an error") {
                    expect { try LiMessagesByBoardIdClientRequestParams(boardId: "") }.to( throwError() )
                }
            }
        }
    }
    public func testDummy() {}
}

class LiSdkSettingsClientRequestParamsTests: QuickSpec {
    override func spec() {
        describe("LiSdkSettingsClientRequestParams") {
            context("After being properly initalize") {
                it("Should not throw error") {
                    expect { try LiSdkSettingsClientRequestParams(clientId: "abc") }.toNot( throwError() )
                }
            }
            context("After being initalized with an empty sting") {
                it("should throw an error") {
                    expect { try LiSdkSettingsClientRequestParams(clientId: "") }.to( throwError() )
                }
            }
        }
    }
}

class LiCategoryBoardsClientRequestParamsTests: QuickSpec {
    override func spec() {
        describe("LiCategoryBoardsClientRequestParams") {
            context("After being properly initalize") {
                it("Should not throw error") {
                    expect { try LiCategoryBoardsClientRequestParams(categoryId: "abc") }.toNot( throwError() )
                }
            }
            context("After being initalized with an empty sting") {
                it("should throw an error") {
                    expect { try LiCategoryBoardsClientRequestParams(categoryId: "") }.to( throwError() )
                }
            }
        }
    }
}

class LiBoardsByDepthClientRequestParamsTests: QuickSpec {
    override func spec() {
        describe("LiBoardsByDepthClientRequestParams") {
            context("After being properly initalize") {
                it("Should not throw error") {
                    expect { try LiBoardsByDepthClientRequestParams(depth: 0) }.toNot( throwError() )
                }
            }
            context("After being initalized with an empty sting") {
                it("should throw an error") {
                    expect { try LiBoardsByDepthClientRequestParams(depth: -21) }.to( throwError() )
                }
            }
        }
    }
}

class LiRepliesClientRequestParamsTests: QuickSpec {
    override func spec() {
        describe("LiRepliesClientRequestParams") {
            context("After being properly initalize") {
                it("Should not throw error") {
                    expect { try LiRepliesClientRequestParams(parentId: "123") }.toNot( throwError() )
                }
            }
            context("After being initalized with an empty sting") {
                it("should throw an error") {
                    expect { try LiRepliesClientRequestParams(parentId: "") }.to( throwError() )
                }
            }
        }
    }
}

class LiSearchClientRequestParamsTest: QuickSpec {
    override func spec() {
        describe("LiSearchClientRequestParams") {
            context("After being properly initalize") {
                it("Should not throw error") {
                    expect { try LiSearchClientRequestParams(query: "123") }.toNot( throwError() )
                }
            }
            context("After being initalized with an empty sting") {
                it("should throw an error") {
                    expect { try LiSearchClientRequestParams(query: "") }.to( throwError() )
                }
            }
        }
    }
    public func test() {}
}

class LiUserMessagesClientRequestParamsTests: QuickSpec {
    override func spec() {
        describe("LiUserMessagesClientRequestParams") {
            context("After being properly initalize") {
                it("Should not throw error") {
                    expect { try LiUserMessagesClientRequestParams(authorId: "123", depth: 0) }.toNot( throwError() )
                }
            }
            context("After being initalized with an empty authorId but proper depth") {
                it("should throw an error") {
                    expect { try LiUserMessagesClientRequestParams(authorId: "", depth: 0) }.to( throwError() )
                }
            }
            context("After being initalized with an proper authorId but negetive depth") {
                it("should throw an error") {
                    expect { try LiUserMessagesClientRequestParams(authorId: "123", depth: -1) }.to( throwError() )
                }
            }
            context("After being initalized with an empty authorId but negetive depth") {
                it("should throw an error") {
                    expect { try LiUserMessagesClientRequestParams(authorId: "", depth: -1) }.to( throwError() )
                }
            }
        }
    }
    public func test() {}
}

class LiUserDetailsClientRequestParamsTest: QuickSpec {
    override func spec() {
        describe("LiUserDetailsClientRequestParams") {
            context("After being properly initalize") {
                it("Should not throw error") {
                    expect { try LiUserDetailsClientRequestParams(userId: "123") }.toNot( throwError() )
                }
            }
            context("After being initalized with an empty sting") {
                it("should throw an error") {
                    expect { try LiUserDetailsClientRequestParams(userId: "") }.to( throwError() )
                }
            }
        }
    }
    public func test() {}
}

class LiMessageClientRequestParamsTests: QuickSpec {
    override func spec() {
        describe("LiMessageClientRequestParams") {
            context("After being properly initalize") {
                it("Should not throw error") {
                    expect { try LiMessageClientRequestParams(messageId: "123") }.toNot( throwError() )
                }
            }
            context("After being initalized with an empty sting") {
                it("should throw an error") {
                    expect { try LiMessageClientRequestParams(messageId: "") }.to( throwError() )
                }
            }
        }
    }
    public func test() {}
}

class LiFloatedMessagesClientRequestParamsTests: QuickSpec {
    override func spec() {
        describe("LiFloatedMessagesClientRequestParams") {
            context("After being properly initalize the depricated initalizer") {
                it("Should not throw error") {
                    expect { try LiFloatedMessagesClientRequestParams(boardId:"123", scope: "local") }.toNot( throwError() )
                }
            }
            context("After being properly initalized") {
                it("Should not throw error") {
                    expect { try LiFloatedMessagesClientRequestParams(boardId:"123", scope: LiFloatedMessagesClientRequestParams.Scope.local) }.toNot( throwError() )
                }
            }
            context("After being initalized with empty board Id") {
                it("Should throw error") {
                    expect { try LiFloatedMessagesClientRequestParams(boardId:"", scope: "local") }.to( throwError() )
                }
            }
            context("After being initalized with empty board Id") {
                it("Should throw error") {
                    expect { try LiFloatedMessagesClientRequestParams(boardId:"", scope: LiFloatedMessagesClientRequestParams.Scope.local) }.to( throwError() )
                }
            }
            context("After being initalized with empty scope string on the depricated initalizer") {
                it("Should throw error") {
                    expect { try LiFloatedMessagesClientRequestParams(boardId:"123", scope: "") }.to( throwError() )
                }
            }
        }
    }
    public func test() {}
}

class LiMessagesByIdsClientRequestParamsTests: QuickSpec {
    override func spec() {
        describe("LiMessagesByIdsClientRequestParams") {
            context("After being properly initalize") {
                it("Should not throw error") {
                    expect { try LiMessagesByIdsClientRequestParams(messageIds: ["123"]) }.toNot( throwError() )
                }
            }
            context("After being initalized with an empty array") {
                it("should throw an error") {
                    expect { try LiMessagesByIdsClientRequestParams(messageIds: []) }.to( throwError() )
                }
            }
            context("After being initalixed with an array containing empty string") {
                it("should throw an error") {
                    expect { try LiMessagesByIdsClientRequestParams(messageIds: ["234", ""]) }.to( throwError() )
                }
            }
        }
    }
    public func test() {}
}

class LiKudoClientRequestParamsTests: QuickSpec {
    override func spec() {
        describe("LiKudoClientRequestParams") {
            context("After being properly initalize") {
                it("Should not throw error") {
                    expect { try LiKudoClientRequestParams(messageId: "123") }.toNot( throwError() )
                }
            }
            context("After being initalized with an empty sting") {
                it("should throw an error") {
                    expect { try LiKudoClientRequestParams(messageId: "") }.to( throwError() )
                }
            }
            context("After being properly initalize") {
                let clientParams = try! LiKudoClientRequestParams(messageId: "123")
                let postParams = clientParams.getPostParams()
                let message = postParams["message"] as? [String: String]
                it("make sure post params are initalized correctly") {
                    expect(postParams["type"] as? String) == "kudo"
                    expect(postParams["message"] as? [String: String]).toNot(beNil())
                    expect(message!["id"]) == "123"
                }
            }
        }
    }
    public func test() {}
}

class LiUnKudoClientRequestParamsTests: QuickSpec {
    override func spec() {
        describe("LiUnKudoClientRequestParams") {
            context("After being properly initalize") {
                it("Should not throw error") {
                    expect { try LiUnKudoClientRequestParams(messageId: "123") }.toNot( throwError() )
                }
            }
            context("After being initalized with an empty sting") {
                it("should throw an error") {
                    expect { try LiUnKudoClientRequestParams(messageId: "") }.to( throwError() )
                }
            }
        }
    }
    public func test() {}
}

class LiMessageDeleteClientRequestParamsTests: QuickSpec {
    override func spec() {
        describe("LiMessageDeleteClientRequestParams") {
            context("After being properly initalize") {
                it("Should not throw error") {
                    expect { try LiMessageDeleteClientRequestParams(messageId: "123", includeReplies: true) }.toNot( throwError() )
                }
            }
            context("After being initalized with an empty sting") {
                it("should throw an error") {
                    expect { try LiMessageDeleteClientRequestParams(messageId: "", includeReplies: true) }.to( throwError() )
                }
            }
            context("If `includeReplies is true") {
                let params = try! LiMessageDeleteClientRequestParams(messageId: "123", includeReplies: true)
                let postParams = params.getPostParams()
                it("then post params should include delete replies parameter") {
                    expect(postParams["delete_message.include_replies"]) == "true"
                }
            }
            context("If `includeReplies is false") {
                let params = try! LiMessageDeleteClientRequestParams(messageId: "123", includeReplies: false)
                it("then post params should be empty") {
                    expect(params.getPostParams()) == [:]
                }
            }
        }
    }
    public func test() {}
}

class LiAcceptSolutionClientRequestParamsTests: QuickSpec {
    override func spec() {
        describe("LiAcceptSolutionClientRequestParams") {
            context("After being properly initalize") {
                it("Should not throw error") {
                    expect { try LiAcceptSolutionClientRequestParams(messageId: "123") }.toNot( throwError() )
                }
            }
            context("After being initalized with an empty sting") {
                it("should throw an error") {
                    expect { try LiAcceptSolutionClientRequestParams(messageId: "") }.to( throwError() )
                }
            }
            context("After being initalized properly") {
                let params = try! LiAcceptSolutionClientRequestParams(messageId: "123")
                let postParams = params.getPostParams()
                it("post params should be correct.") {
                    expect(postParams["type"] as? String) == "solution_data"
                    expect(postParams["message_id"] as? String) == "123"
                }
            }
        }
    }
    public func test() {}
}

class LiCreateMessageClientRequestParamsTests: QuickSpec {
    override func spec() {
        describe("LiCreateMessageClientRequestParams") {
            context("After being properly initalize") {
                it("Should not throw error") {
                    expect { try LiCreateMessageClientRequestParams(subject: "Test", body: "NoTest", boardId: "123", imageId: "xyz", imageName: "testImage.jpg") }.toNot( throwError() )
                }
            }
            context("After being initalized with an empty body") {
                it("should not throw an error") {
                    expect { try LiCreateMessageClientRequestParams(subject: "Test", body: "", boardId: "123", imageId: "xyz", imageName: "testImage.jpg") }.toNot( throwError() )
                }
            }
            context("After being initalized with a nil imageId") {
                it("should not throw an error") {
                    expect { try LiCreateMessageClientRequestParams(subject: "Test", body: "TestBody", boardId: "123", imageId: nil, imageName: "testImage.jpg") }.toNot( throwError() )
                }
            }
            context("After being initalized with a empty subject") {
                it("should throw an error") {
                    expect { try LiCreateMessageClientRequestParams(subject: "", body: "TestBody", boardId: "123", imageId: "123", imageName: "testImage.jpg") }.to( throwError() )
                }
            }
            context("After being initalized with a empty boardId") {
                it("should throw an error") {
                    expect { try LiCreateMessageClientRequestParams(subject: "Test", body: "TestBody", boardId: "", imageId: "123", imageName: "testImage.jpg") }.to( throwError() )
                }
            }
            context("After being initalized with a empty imageId") {
                it("should throw an error") {
                    expect { try LiCreateMessageClientRequestParams(subject: "Test", body: "TestBody", boardId: "123", imageId: "", imageName: "testImage.jpg") }.to( throwError() )
                }
            }
            context("After being initalized with a empty imageName") {
                it("should throw an error") {
                    expect { try LiCreateMessageClientRequestParams(subject: "Test", body: "TestBody", boardId: "123", imageId: "123", imageName: "") }.to( throwError() )
                }
            }
            context("After being initalized properly") {
                let params = try!  LiCreateMessageClientRequestParams(subject: "Test", body: "TestBody", boardId: "123", imageId: "123", imageName: "test.jpg")
                let postParams = params.getPostParams()
                let boardParams = postParams["board"] as? [String: String]
                it("post params should be correct.") {
                    expect(postParams["type"] as? String) == "message"
                    expect(postParams["body"] as? String) == """
                    TestBody
                    <p><li-image id=123 width="500" height="500" alt=test.jpg align="inline" size="large" sourcetype="new"></li-image></p>
                    """
                    expect(postParams["subject"] as? String) == "Test"
                    expect(postParams["board"]).toNot(beNil())
                    expect(boardParams!["id"]) == "123"
                }
            }
        }
    }
    public func test() {}
}


class LiUpdateMessageClientRequestParamsTests: QuickSpec {
    override func spec() {
        describe("LiUpdateMessageClientRequestParams") {
            context("After being properly initalize") {
                it("Should not throw error") {
                    expect { try LiUpdateMessageClientRequestParams(messageId: "123", subject: "Test", body: "NoTest", imageId: "xyz", imageName: "testImage.jpg") }.toNot( throwError() )
                }
            }
            context("After being initalized with an empty body") {
                it("should not throw an error") {
                    expect { try LiUpdateMessageClientRequestParams(messageId: "123", subject: "Test", body: "", imageId: "xyz", imageName: "testImage.jpg") }.toNot( throwError() )
                }
            }
            context("After being initalized with a nil imageId") {
                it("should not throw an error") {
                    expect { try LiUpdateMessageClientRequestParams(messageId: "123", subject: "Test", body: "TestBody", imageId: nil, imageName: "testImage.jpg") }.toNot( throwError() )
                }
            }
            context("After being initalized with a empty subject") {
                it("should throw an error") {
                    expect { try LiUpdateMessageClientRequestParams(messageId: "123", subject: "", body: "TestBody", imageId: "123", imageName: "testImage.jpg") }.to( throwError() )
                }
            }
            context("After being initalized with a empty messageId") {
                it("should throw an error") {
                    expect { try LiUpdateMessageClientRequestParams(messageId: "", subject: "Test", body: "TestBody", imageId: "123", imageName: "testImage.jpg") }.to( throwError() )
                }
            }
            context("After being initalized with a empty imageId") {
                it("should throw an error") {
                    expect { try LiUpdateMessageClientRequestParams(messageId: "123", subject: "Test", body: "TestBody", imageId: "", imageName: "testImage.jpg") }.to( throwError() )
                }
            }
            context("After being initalized with a empty imageName") {
                it("should throw an error") {
                    expect { try LiUpdateMessageClientRequestParams(messageId: "123", subject: "Test", body: "TestBody", imageId: "123", imageName: "") }.to( throwError() )
                }
            }
            context("After being initalized properly") {
                let params = try!  LiUpdateMessageClientRequestParams(messageId: "123", subject: "Test", body: "TestBody", imageId: "123", imageName: "test.jpg")
                let postParams = params.getPostParams()
                it("post params should be correct.") {
                    expect(postParams["type"] as? String) == "message"
                    expect(postParams["body"] as? String) == """
                    TestBody
                    <p><li-image id=123 width="500" height="500" alt=test.jpg align="inline" size="large" sourcetype="new"></li-image></p>
                    """
                    expect(postParams["subject"] as? String) == "Test"
                }
            }
        }
    }
    public func test() {}
}


class LiCreateReplyClientRequestParamsTests: QuickSpec {
    override func spec() {
        describe("LiCreateReplyClientRequestParams") {
            context("After being properly initalize") {
                it("Should not throw error") {
                    expect { try LiCreateReplyClientRequestParams(body: "NoTest", messageId: "123", subject: "Test", imageId: "xyz", imageName: "testImage.jpg") }.toNot( throwError() )
                }
            }
            context("After being initalized with an empty body") {
                it("should throw an error") {
                    expect { try LiCreateReplyClientRequestParams(body: "", messageId: "123", subject: "Test", imageId: "xyz", imageName: "testImage.jpg") }.to( throwError() )
                }
            }
            context("After being initalized with a nil imageId") {
                it("should not throw an error") {
                    expect { try LiCreateReplyClientRequestParams(body: "TestBody", messageId: "123", subject: "Test", imageId: nil, imageName: "testImage.jpg") }.toNot( throwError() )
                }
            }
            context("After being initalized with a empty subject") {
                it("should throw an error") {
                    expect { try LiCreateReplyClientRequestParams(body: "TestBody", messageId: "123", subject: "", imageId: "123", imageName: "testImage.jpg") }.to( throwError() )
                }
            }
            context("After being initalized with a empty messageId") {
                it("should throw an error") {
                    expect { try LiCreateReplyClientRequestParams(body: "TestBody", messageId: "", subject: "Test", imageId: "123", imageName: "testImage.jpg") }.to( throwError() )
                }
            }
            context("After being initalized with a empty imageId") {
                it("should throw an error") {
                    expect { try LiCreateReplyClientRequestParams(body: "TestBody", messageId: "123", subject: "Test", imageId: "", imageName: "testImage.jpg") }.to( throwError() )
                }
            }
            context("After being initalized with a empty imageName") {
                it("should throw an error") {
                    expect { try LiCreateReplyClientRequestParams(body: "TestBody", messageId: "123", subject: "Test", imageId: "123", imageName: "") }.to( throwError() )
                }
            }
            context("After being initalized properly") {
                let params = try!  LiCreateReplyClientRequestParams(body: "TestBody", messageId: "123", subject: "Test", imageId: "123", imageName: "test.jpg")
                let postParams = params.getPostParams()
                let parentParams = postParams["parent"] as? [String: String]
                it("post params should be correct.") {
                    expect(postParams["type"] as? String) == "message"
                    expect(postParams["body"] as? String) == """
                    TestBody
                    <p><li-image id=123 width="500" height="500" alt=test.jpg align="inline" size="large" sourcetype="new"></li-image></p>
                    """
                    expect(postParams["subject"] as? String) == "Test"
                    expect(parentParams!["id"]) == "123"
                }
            }
        }
    }
    public func test() {}
}

class LiUploadImageClientRequestParamsTests: QuickSpec {
    func loadImage(named name: String, type:String = "png") throws -> UIImage {
        let bundle = Bundle(for:type(of: self))
        guard let path = bundle.path(forResource: name, ofType: type) else {
            throw NSError(domain: "loadImage", code: 1, userInfo: nil)
        }
        guard let image = UIImage(contentsOfFile: path) else {
            throw NSError(domain: "loadImage", code: 2, userInfo: nil)
        }
        return image
    }
    override func spec() {
        describe("LiUploadImageClientRequestParams") {
            let image = try! loadImage(named:"keanu", type: "jpg")
            context("After being properly initalize") {
                it("Should not throw error") {
                    expect {try LiUploadImageClientRequestParams(title: "Image", description: "Test description", imageName: "test.jpg", image: image) }.toNot( throwError())
                }
            }
            context("After being initalized with an empty title") {
                it("should throw an error") {
                    expect { try LiUploadImageClientRequestParams(title: "", description: "Test description", imageName: "test.jpg", image: image) }.to( throwError() )
                }
            }
            context("After being initalized with an empty description") {
                it("should throw an error") {
                    expect { try LiUploadImageClientRequestParams(title: "test", description: "", imageName: "test.jpg", image: image) }.to( throwError() )
                }
            }
            context("After being initalized with an empty imageName") {
                it("should throw an error") {
                    expect { try LiUploadImageClientRequestParams(title: "test", description: "demo", imageName: "", image: image) }.to( throwError() )
                }
            }
            context("After being initalized with an imageName without extension") {
                let requestParams = try! LiUploadImageClientRequestParams(title: "test", description: "demo", imageName: "test", image: image)
                it("should have a jpg extenstion") {
                    expect(requestParams.imageName) == "test.jpg"
                }
            }
        }
    }
    public func test() {}
}

class LiReportAbuseClientRequestParamsTests: QuickSpec {
    override func spec() {
        describe("LiReportAbuseClientRequestParams") {
            context("After being properly initalize") {
                it("Should not throw error") {
                    expect { try LiReportAbuseClientRequestParams(messageId: "123", userId: "123", body: "Hello there!") }.toNot( throwError() )
                }
            }
            context("After initalizing messageId with an empty sting") {
                it("should throw an error") {
                    expect { try LiReportAbuseClientRequestParams(messageId: "", userId: "123", body: "Hello there!")  }.to( throwError() )
                }
            }
            context("After initalizing userId with an empty sting") {
                it("should throw an error") {
                    expect { try LiReportAbuseClientRequestParams(messageId: "123", userId: "", body: "Hello there!")  }.to( throwError() )
                }
            }
            context("After initalizing body with an empty sting") {
                it("should throw an error") {
                    expect { try LiReportAbuseClientRequestParams(messageId: "123", userId: "123", body: "")  }.to( throwError() )
                }
            }
            context("After being initalized correctly") {
                let params = try! LiReportAbuseClientRequestParams(messageId: "123", userId: "123", body: "Hello there!")
                let postParams = params.getPostParams()
                let reporterParams = postParams["reporter"] as! [String: String]
                let messageParams = postParams["message"] as! [String: String]
                it("then post params should be correct") {
                    expect(postParams["type"] as! String) == "abuse_report"
                    expect(reporterParams["id"]) == "123"
                    expect(messageParams["id"]) == "123"
                    expect(postParams["body"] as! String) == "Hello there!"
                }
            }
        }
    }
    public func test() {}
}

class LiDeviceIdFetchClientRequestParamsTests: QuickSpec {
    override func spec() {
        describe("LiReportAbuseClientRequestParams") {
            context("After being properly initalize") {
                it("Should not throw error") {
                    expect { try LiDeviceIdFetchClientRequestParams(deviceId: "fsajsfajfjsajfsa", pushNotificationProvider: "APNS") }.toNot( throwError() )
                }
            }
            context("After being properly initalize") {
                it("Should not throw error") {
                    expect { try LiDeviceIdFetchClientRequestParams(deviceId: "fsajsfajfjsajfsa", pushNotificationProvider: LiDeviceIdFetchClientRequestParams.NotificationProviders.apns) }.toNot( throwError() )
                }
            }
            context("After initalizing deviceId with an empty sting") {
                it("should throw an error") {
                    expect { try LiDeviceIdFetchClientRequestParams(deviceId: "", pushNotificationProvider: "APNS")  }.to( throwError() )
                }
            }
            context("After initalizing pushNotificationProvider with empty sting") {
                it("should throw an error") {
                    expect { try LiDeviceIdFetchClientRequestParams(deviceId: "fsajsfajfjsajfsa", pushNotificationProvider: "")  }.to( throwError() )
                }
            }
            context("After initalizing deviceId with an empty sting") {
                it("should throw an error") {
                    expect { try LiDeviceIdFetchClientRequestParams(deviceId: "", pushNotificationProvider: LiDeviceIdFetchClientRequestParams.NotificationProviders.apns)   }.to( throwError() )
                }
            }
            context("After being initalized correctly") {
                let params = try!  LiDeviceIdFetchClientRequestParams(deviceId: "dsasadhdash", pushNotificationProvider: LiDeviceIdFetchClientRequestParams.NotificationProviders.apns)
                let postParams = params.getPostParams()
                it("then post params should be correct") {
                    expect(postParams["type"] as! String) == "user_device_data"
                    expect(postParams["device_id"] as! String) == "dsasadhdash"
                    expect(postParams["push_notification_provider"] as! String) == "APNS"
                    expect(postParams["application_type"] as! String) == "IOS"
                }
            }
        }
    }
    public func test() {}
}

class LiDeviceIdUpdateClientRequestParamsTests: QuickSpec {
    override func spec() {
        describe("LiReportAbuseClientRequestParams") {
            context("After being properly initalize") {
                it("Should not throw error") {
                    expect { try LiDeviceIdUpdateClientRequestParams(deviceId: "fsajsfajfjsajfsa", id: "123") }.toNot( throwError() )
                }
            }
            context("After initalizing deviceId with an empty sting") {
                it("should throw an error") {
                    expect { try LiDeviceIdUpdateClientRequestParams(deviceId: "", id: "123")  }.to( throwError() )
                }
            }
            context("After initalizing id with empty sting") {
                it("should throw an error") {
                    expect { try LiDeviceIdUpdateClientRequestParams(deviceId: "fsajsfajfjsajfsa", id: "")  }.to( throwError() )
                }
            }
            context("After being initalized correctly") {
                let params = try! LiDeviceIdUpdateClientRequestParams(deviceId: "fsajsfajfjsajfsa", id: "123")
                let postParams = params.getPostParams()
                it("then post params should be correct") {
                    expect(postParams["type"] as! String) == "user_device_data"
                    expect(postParams["device_id"] as! String) == "fsajsfajfjsajfsa"
                }
            }
        }
    }
    public func test() {}
}

class LiSubscriptionPostClientRequestParamsTests: QuickSpec {
    override func spec() {
        describe("LiSubscriptionPostClientRequestParams") {
            context("After being properly initalize") {
                it("Should not throw error") {
                    expect { try LiSubscriptionPostClientRequestParams(targetId: "123", targetType: "message") }.toNot( throwError() )
                }
            }
            context("After being properly initalize") {
                it("Should not throw error") {
                    expect { try LiSubscriptionPostClientRequestParams(targetId: "123", targetType: LiSubscriptionPostClientRequestParams.TargetType.board) }.toNot( throwError() )
                }
            }
            context("After initalizing targetId with an empty sting") {
                it("should throw an error") {
                    expect { try LiSubscriptionPostClientRequestParams(targetId: "", targetType: "message")  }.to( throwError() )
                }
            }
            context("After initalizing targetId with an empty sting") {
                it("should throw an error") {
                    expect { try LiSubscriptionPostClientRequestParams(targetId: "", targetType: LiSubscriptionPostClientRequestParams.TargetType.board)  }.to( throwError() )
                }
            }
            context("After initalizing targetType with empty sting") {
                it("should throw an error") {
                    expect { try LiSubscriptionPostClientRequestParams(targetId: "123", targetType: "")  }.to( throwError() )
                }
            }
            context("After being initalized correctly") {
                let params = try! LiSubscriptionPostClientRequestParams(targetId: "123", targetType: LiSubscriptionPostClientRequestParams.TargetType.message)
                let postParams = params.getPostParams()
                let targetParams = postParams["target"] as! [String: String]
                it("then post params should be correct") {
                    expect(postParams["type"] as! String) == "subscription"
                    expect(targetParams["type"]) == "message"
                    expect(targetParams["id"]) == "123"
                }
            }
        }
    }
    public func test() {}
}

class LiMarkMessagePostClientRequestParamsTests: QuickSpec {
    override func spec() {
        describe("LiMarkMessagePostClientRequestParams") {
            context("After being properly initalize") {
                it("Should not throw error") {
                    expect { try LiMarkMessagePostClientRequestParams(userId: "123", messageId: "456", markUnread: true) }.toNot( throwError() )
                }
            }
            context("After initalizing userId with an empty sting") {
                it("should throw an error") {
                    expect { try LiMarkMessagePostClientRequestParams(userId: "", messageId: "456", markUnread: true)  }.to( throwError() )
                }
            }
            context("After initalizing messageId with empty sting") {
                it("should throw an error") {
                    expect { try LiMarkMessagePostClientRequestParams(userId: "123", messageId: "", markUnread: true)  }.to( throwError() )
                }
            }
            context("After being initalized correctly") {
                let params = try! LiMarkMessagePostClientRequestParams(userId: "123", messageId: "456", markUnread: true)
                let postParams = params.getPostParams()
                it("then post params should be correct") {
                    expect(postParams["type"] as! String) == "message_read"
                    expect(postParams["mark_unread"] as! Bool) == true
                    expect(postParams["message_id"] as! String) == "456"
                    expect(postParams["user"] as! String) == "123"
                }
            }
        }
    }
    public func test() {}
}

class LiMarkMessagesPostClientRequestParamsTests: QuickSpec {
    override func spec() {
        describe("LiMarkMessagesPostClientRequestParams") {
            context("After being properly initalize") {
                it("Should not throw error") {
                    expect { try LiMarkMessagesPostClientRequestParams(userId: "123", messageIds: ["456", "789"], markUnread: true) }.toNot( throwError() )
                }
            }
            context("After initalizing userId with an empty sting") {
                it("should throw an error") {
                    expect { try LiMarkMessagesPostClientRequestParams(userId: "", messageIds: ["456"], markUnread: true)  }.to( throwError() )
                }
            }
            context("After initalizing messageId with empty array") {
                it("should throw an error") {
                    expect { try LiMarkMessagesPostClientRequestParams(userId: "123", messageIds: [], markUnread: true)  }.to( throwError() )
                }
            }
            context("After initalizing messageId with an array containing empty string") {
                it("should throw an error") {
                    expect { try LiMarkMessagesPostClientRequestParams(userId: "123", messageIds: ["356", "", "421"], markUnread: true)  }.to( throwError() )
                }
            }
            context("After being initalized correctly") {
                let params = try! LiMarkMessagesPostClientRequestParams(userId: "123", messageIds: ["456","789"], markUnread: true)
                let postParams = params.getPostParams()
                it("then post params should be correct") {
                    expect(postParams["type"] as! String) == "message_read"
                    expect(postParams["mark_unread"] as! Bool) == true
                    expect(postParams["message_ids"] as! String) == "456,789"
                    expect(postParams["user"] as! String) == "123"
                }
            }
        }
    }
    public func test() {}
}


class LiMarkTopicPostClientRequestParamsTests: QuickSpec {
    override func spec() {
        describe("LiMarkTopicPostClientRequestParams") {
            context("After being properly initalize") {
                it("Should not throw error") {
                    expect { try LiMarkTopicPostClientRequestParams(userId: "123", topicId: "456", markUnread: true) }.toNot( throwError() )
                }
            }
            context("After initalizing userId with an empty sting") {
                it("should throw an error") {
                    expect { try LiMarkTopicPostClientRequestParams(userId: "", topicId: "456", markUnread: true)  }.to( throwError() )
                }
            }
            context("After initalizing topicId with empty sting") {
                it("should throw an error") {
                    expect { try LiMarkTopicPostClientRequestParams(userId: "123", topicId: "", markUnread: true)  }.to( throwError() )
                }
            }
            context("After being initalized correctly") {
                let params = try! LiMarkTopicPostClientRequestParams(userId: "123", topicId: "456", markUnread: true)
                let postParams = params.getPostParams()
                it("then post params should be correct") {
                    expect(postParams["type"] as! String) == "message_read"
                    expect(postParams["mark_unread"] as! Bool) == true
                    expect(postParams["topic_id"] as! String) == "456"
                    expect(postParams["user"] as! String) == "123"
                }
            }
        }
    }
    public func test() {}
}

class LiSubscriptionDeleteClientRequestParamsTests: QuickSpec {
    override func spec() {
        describe("LiSubscriptionDeleteClientRequestParams") {
            context("After being properly initalize") {
                it("Should not throw error") {
                    expect { try LiSubscriptionDeleteClientRequestParams(subscriptionId: "123") }.toNot( throwError() )
                }
            }
            context("After initalizing subscriptionId with an empty string") {
                it("should throw an error") {
                    expect { try LiSubscriptionDeleteClientRequestParams(subscriptionId: "")  }.to( throwError() )
                }
            }
        }
    }
    public func test() {}
}

class LiCreateUserClientRequestParamsTests: QuickSpec {
    override func spec() {
        describe("LiCreateUserClientRequestParams") {
            context("After being properly initalize") {
                it("Should not throw error") {
                    expect { try LiCreateUserClientRequestParams(email: "shekhar.dahore@lithium.com", firstName: "Shekhar", lastName: "Dahore", login: "shek", password: "xxxxxx", avatarUrl: nil, avatarImageId: nil, avatarExternal: nil, avatarInternal: nil, biography: "Hello there!", coverImage: nil) }.toNot( throwError() )
                }
            }
            context("After initalizing email with an empty string") {
                it("Should throw an error") {
                    expect { try LiCreateUserClientRequestParams(email: "", firstName: "Shekhar", lastName: "Dahore", login: "shek", password: "xxxxxx", avatarUrl: nil, avatarImageId: nil, avatarExternal: nil, avatarInternal: nil, biography: "Hello there!", coverImage: nil) }.to( throwError() )
                }
            }
            context("After initalizing email with an invalid email") {
                it("Should throw an error") {
                    expect { try LiCreateUserClientRequestParams(email: "da@1.", firstName: "Shekhar", lastName: "Dahore", login: "shek", password: "xxxxxx", avatarUrl: nil, avatarImageId: nil, avatarExternal: nil, avatarInternal: nil, biography: "Hello there!", coverImage: nil) }.to( throwError() )
                }
            }

            context("After initalizing login with an empty string") {
                it("should throw an error") {
                    expect { try LiCreateUserClientRequestParams(email: "shekhar.dahore@lithium.com", firstName: "Shekhar", lastName: "Dahore", login: "", password: "xxxxxx", avatarUrl: nil, avatarImageId: nil, avatarExternal: nil, avatarInternal: nil, biography: "Hello there!", coverImage: nil)  }.to( throwError() )
                }
            }
            context("After initalizing password with an empty string") {
                it("should throw an error") {
                    expect { try LiCreateUserClientRequestParams(email: "shekhar.dahore@lithium.com", firstName: "Shekhar", lastName: "Dahore", login: "shek", password: "", avatarUrl: nil, avatarImageId: nil, avatarExternal: nil, avatarInternal: nil, biography: "Hello there!", coverImage: nil) }.to( throwError() )
                }
            }
            context("After being initalized correctly") {
                let params = try! LiCreateUserClientRequestParams(email: "shekhar.dahore@lithium.com", firstName: "Shekhar", lastName: "Dahore", login: "shek", password: "xxxxxx", avatarUrl: "http://avatar", avatarImageId: "123", avatarExternal: "http://external", avatarInternal: nil, biography: "Hello there!", coverImage: "http://img/testcover.jpg")
                let postParams = params.getPostParams()
                let avatarParams = postParams["avatar"] as! [String: String]
                it("then post params should be correct") {
                    expect(postParams["type"] as! String) == "user"
                    expect(postParams["email"] as! String) == "shekhar.dahore@lithium.com"
                    expect(postParams["login"] as! String) == "shek"
                    expect(postParams["password"] as! String) == "xxxxxx"
                    expect(postParams["first_name"] as! String) == "Shekhar"
                    expect(postParams["last_name"] as! String) == "Dahore"
                    expect(postParams["biography"] as! String) == "Hello there!"
                    expect(postParams["cover_image"] as! String) == "http://img/testcover.jpg"
                    expect(avatarParams["url"]) == "http://avatar"
                    expect(avatarParams["id"]) == "123"
                    expect(avatarParams["external"]) == "http://external"
                    expect(avatarParams["internal"]).to(beNil())
                }
            }
        }
    }
    public func test() {}
}

class LiUpdateUserClientRequestParamsTests: QuickSpec {
    override func spec() {
        describe("LiUpdateUserClientRequestParams") {
            context("After being properly initalize") {
                it("Should not throw error") {
                    expect { try LiUpdateUserClientRequestParams(id: "123", email: "shekhar.dahore@lithium.com", firstName: "Shekhar", lastName: "Dahore", login: "shek", avatarUrl: nil, avatarImageId: nil, avatarExternal: nil, avatarInternal: nil, biography: "Hello there!", coverImage: nil) }.toNot( throwError() )
                }
            }
            context("After initalizing email with an empty sting") {
                it("Should throw an error") {
                    expect { try LiUpdateUserClientRequestParams(id: "123", email: "", firstName: "Shekhar", lastName: "Dahore", login: "shek", avatarUrl: nil, avatarImageId: nil, avatarExternal: nil, avatarInternal: nil, biography: "Hello there!", coverImage: nil) }.to( throwError() )
                }
            }
            context("After initalizing email with an invalid email") {
                it("Should throw an error") {
                    expect { try LiUpdateUserClientRequestParams(id: "123", email: "12hfa@m", firstName: "Shekhar", lastName: "Dahore", login: "shek", avatarUrl: nil, avatarImageId: nil, avatarExternal: nil, avatarInternal: nil, biography: "Hello there!", coverImage: nil) }.to( throwError() )
                }
            }
            context("After initalizing login with an empty string") {
                it("should throw an error") {
                    expect { try LiUpdateUserClientRequestParams(id: "123", email: "shekhar.dahore@lithium.com", firstName: "Shekhar", lastName: "Dahore", login: "", avatarUrl: nil, avatarImageId: nil, avatarExternal: nil, avatarInternal: nil, biography: "Hello there!", coverImage: nil) }.to( throwError() )
                }
            }
            context("After initalizing id with an empty string") {
                it("should throw an error") {
                    expect { try LiUpdateUserClientRequestParams(id: "", email: "shekhar.dahore@lithium.com", firstName: "Shekhar", lastName: "Dahore", login: "shek", avatarUrl: nil, avatarImageId: nil, avatarExternal: nil, avatarInternal: nil, biography: "Hello there!", coverImage: nil) }.to( throwError() )
                }
            }
            context("After being initalized correctly") {
                let params = try! LiUpdateUserClientRequestParams(id: "123", email: "shekhar.dahore@lithium.com", firstName: "Shekhar", lastName: "Dahore", login: "shek", avatarUrl: "http://avatar", avatarImageId: "123", avatarExternal: "http://external", avatarInternal: nil, biography: "Hello there!", coverImage: "http://img/testcover.jpg")
                let postParams = params.getPostParams()
                let avatarParams = postParams["avatar"] as! [String: String]
                it("then post params should be correct") {
                    expect(postParams["type"] as! String) == "user"
                    expect(postParams["id"] as! String) == "123"
                    expect(postParams["email"] as! String) == "shekhar.dahore@lithium.com"
                    expect(postParams["login"] as! String) == "shek"
                    expect(postParams["first_name"] as! String) == "Shekhar"
                    expect(postParams["last_name"] as! String) == "Dahore"
                    expect(postParams["biography"] as! String) == "Hello there!"
                    expect(postParams["cover_image"] as! String) == "http://img/testcover.jpg"
                    expect(avatarParams["url"]) == "http://avatar"
                    expect(avatarParams["id"]) == "123"
                    expect(avatarParams["external"]) == "http://external"
                    expect(avatarParams["internal"]).to(beNil())
                }
            }
        }
    }
    public func test() {}
}

class LiGenericPostClientRequestParamsTests: QuickSpec {
    override func spec() {
        describe("LiGenericPostClientRequestParams") {
            context("After being properly initalize") {
                it("Should not throw error") {
                    expect { try LiGenericPostClientRequestParams(path: "messages", requestBody: ["messageId": "543"], additionalHttpHeaders: ["token" : "1236xp291ms4"]) }.toNot( throwError() )
                }
            }
            context("After initalizing request body with empty parameters") {
                it("Should not throw error") {
                    expect { try LiGenericPostClientRequestParams(path: "messages", requestBody: [:], additionalHttpHeaders: ["token" : "1236xp291ms4"]) }.toNot( throwError() )
                }
            }
            context("After initalizing additional headers with empty parameters") {
                it("Should not throw error") {
                    expect { try LiGenericPostClientRequestParams(path: "messages", requestBody: ["lol": 123], additionalHttpHeaders: [:]) }.toNot( throwError() )
                }
            }
            context("After initalizing path with an empty sting") {
                it("should throw an error") {
                    expect { try LiGenericPostClientRequestParams(path: "", requestBody: ["messageId": "543"], additionalHttpHeaders: ["token" : "1236xp291ms4"])  }.to( throwError() )
                }
            }
            context("After initalizing requestBody with an empty key") {
                it("should throw an error") {
                    expect { try LiGenericPostClientRequestParams(path: "messages", requestBody: ["lol": true, "": "543"], additionalHttpHeaders: ["token" : "1236xp291ms4"])  }.to( throwError() )
                }
            }
            context("After initalizing additionalHttpHeaders with an empty key") {
                it("should throw an error") {
                    expect { try LiGenericPostClientRequestParams(path: "messages", requestBody: ["lol": true, "messageId": "543"], additionalHttpHeaders: ["" : "1236xp291ms4"])  }.to( throwError() )
                }
            }
        }
    }
    public func test() {}
}

class LiGenericPutClientRequestParamsTests: QuickSpec {
    override func spec() {
        describe("LiGenericPutClientRequestParams") {
            context("After being properly initalize") {
                it("Should not throw error") {
                    expect { try LiGenericPutClientRequestParams(path: "messages", requestBody: ["messageId": "543"], additionalHttpHeaders: ["token" : "1236xp291ms4"]) }.toNot( throwError() )
                }
            }
            context("After initalizing request body with empty parameters") {
                it("Should not throw error") {
                    expect { try LiGenericPutClientRequestParams(path: "messages", requestBody: [:], additionalHttpHeaders: ["token" : "1236xp291ms4"]) }.toNot( throwError() )
                }
            }
            context("After initalizing additional headers with empty parameters") {
                it("Should not throw error") {
                    expect { try LiGenericPutClientRequestParams(path: "messages", requestBody: ["lol": 123], additionalHttpHeaders: [:]) }.toNot( throwError() )
                }
            }
            context("After initalizing path with an empty sting") {
                it("should throw an error") {
                    expect { try LiGenericPutClientRequestParams(path: "", requestBody: ["messageId": "543"], additionalHttpHeaders: ["token" : "1236xp291ms4"])  }.to( throwError() )
                }
            }
            context("After initalizing requestBody with an empty key") {
                it("should throw an error") {
                    expect { try LiGenericPutClientRequestParams(path: "messages", requestBody: ["lol": true, "": "543"], additionalHttpHeaders: ["token" : "1236xp291ms4"])  }.to( throwError() )
                }
            }
            context("After initalizing additionalHttpHeaders with an empty key") {
                it("should throw an error") {
                    expect { try LiGenericPutClientRequestParams(path: "messages", requestBody: ["lol": true, "messageId": "543"], additionalHttpHeaders: ["" : "1236xp291ms4"])  }.to( throwError() )
                }
            }
        }
    }
    public func test() {}
}

class LiGenericGetClientRequestParamsTests: QuickSpec {
    override func spec() {
        describe("LiGenericGetClientRequestParams") {
            context("After being properly initalize") {
                it("Should not throw error") {
                    expect { try LiGenericGetClientRequestParams(liQuery: "SELECT subject, body FROM messages LIMIT 10") }.toNot( throwError() )
                }
            }
            context("After initalizing liQuery with an empty sting") {
                it("should throw an error") {
                    expect { try LiGenericGetClientRequestParams(liQuery: "") }.to( throwError() )
                }
            }
        }
    }
    public func test() {}
}

class LiGenericDeleteClientRequestParamsTests: QuickSpec {
    override func spec() {
        describe("LiGenericDeleteClientRequestParams") {
            context("After being properly initalize") {
                it("Should not throw error") {
                    expect { try LiGenericDeleteClientRequestParams(liQueryRequestParams: ["userId": "123"], id: "123", collectionsType: LiGenericDeleteClientRequestParams.CollectionsType.messages, subResourcePath: "messagesId=456") }.toNot( throwError() )
                }
            }
            context("After initalizing liQueryRequestParams with empty parameters") {
                it("Should not throw error") {
                    expect { try LiGenericDeleteClientRequestParams(liQueryRequestParams: [:], id: "123", collectionsType: LiGenericDeleteClientRequestParams.CollectionsType.messages, subResourcePath: "messagesId=456") }.toNot( throwError() )
                }
            }
            context("After initalizing id with an empty sting") {
                it("should throw an error") {
                    expect { try LiGenericDeleteClientRequestParams(liQueryRequestParams: ["userId": "123"], id: "", collectionsType: LiGenericDeleteClientRequestParams.CollectionsType.messages, subResourcePath: "messagesId=456")  }.to( throwError() )
                }
            }
            context("After initalizing subResourcePath with an empty sting") {
                it("should throw an error") {
                    expect { try LiGenericDeleteClientRequestParams(liQueryRequestParams: ["userId": "123"], id: "123", collectionsType: LiGenericDeleteClientRequestParams.CollectionsType.messages, subResourcePath: "")  }.to( throwError() )
                }
            }
            context("After initalizing liQueryRequestParams with an empty key") {
                it("should throw an error") {
                    expect { try LiGenericDeleteClientRequestParams(liQueryRequestParams: ["": "123"], id: "123", collectionsType: LiGenericDeleteClientRequestParams.CollectionsType.messages, subResourcePath: "messagesId=456")  }.to( throwError() )
                }
            }
        }
    }
    public func test() {}
}

class LiBeaconClientRequestParamsTests: QuickSpec {
    override func spec() {
        describe("LiBeaconClientRequestParams") {
            context("After being properly initalize") {
                it("Should not throw error") {
                    expect { try LiBeaconClientRequestParams(type: "node", id: "12") }.toNot( throwError() )
                }
            }
            context("After initalizing type with an empty sting") {
                it("should throw an error") {
                    expect { try LiBeaconClientRequestParams(type: "", id: "12") }.to( throwError() )
                }
            }
            context("After initalizing id with an empty sting") {
                it("should throw an error") {
                    expect { try LiBeaconClientRequestParams(type: "node", id: "") }.to( throwError() )
                }
            }
            context("After being initalized correctly") {
                let params = try! LiBeaconClientRequestParams(type: "node", id: "12")
                let postParams = params.getPostParams()
                it("then post params should be correct") {
                    expect(postParams["type"] as! String) == "node"
                    expect(postParams["id"] as! String) == "12"
                }
            }
        }
    }
    public func test() {}
}

class LiNoLiqlClientRequestParamsTests: QuickSpec {
    override func spec() {
        describe("LiNoLiqlClientRequestParams") {
            context("After being properly initalize") {
                it("Should not throw error") {
                    expect { try LiNoLiqlClientRequestParams(path: "message", queryParameters: "messageId=12") }.toNot( throwError() )
                }
            }
            context("After initalizing path with an empty sting") {
                it("should throw an error") {
                    expect { try LiNoLiqlClientRequestParams(path: "", queryParameters: "messageId=12") }.to( throwError() )
                }
            }
            context("After initalizing queryParmaeters with an empty sting") {
                it("should throw an error") {
                    expect { try LiNoLiqlClientRequestParams(path: "message", queryParameters: "") }.to( throwError() )
                }
            }
        }
    }
    public func test() {}
}

