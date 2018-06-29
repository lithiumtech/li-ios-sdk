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

import XCTest
@testable import LiUIComponents
class LiHelperFunctionsTest: XCTestCase {
    var format: DateFormatter!
    override func setUp() {
        super.setUp()
        format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        format = nil
        super.tearDown()
    }
    
    func testTimeSinceDay() {
        let date1 = format.string(from: Calendar.current.date(byAdding: .day, value: -1, to: Date())!)
        let date2 = format.string(from: Calendar.current.date(byAdding: .hour, value: -27, to: Date())!)
        let date3 = format.string(from: Calendar.current.date(byAdding: .hour, value: -23, to: Date())!)
        let date4 = format.string(from: Calendar.current.date(byAdding: .day, value: 0, to: Date())!)
        let date5 = format.string(from: Calendar.current.date(byAdding: .day, value: 1, to: Date())!)
        XCTAssertEqual(LiHelperFunctions.timeSince(post: date1, default: ""), "1d", "time ago failed")
        XCTAssertEqual(LiHelperFunctions.timeSince(post: date2), "1d", "time ago failed")
        XCTAssertEqual(LiHelperFunctions.timeSince(post: date3), "23h", "time ago failed")
        XCTAssertEqual(LiHelperFunctions.timeSince(post: date4), "Just now", "time ago failed")
        XCTAssertEqual(LiHelperFunctions.timeSince(post: date5), "", "time ago failed")
    }
    
    func testTimeSinceHour() {
        let date1 = format.string(from: Calendar.current.date(byAdding: .hour, value: -1, to: Date())!)
        let date2 = format.string(from: Calendar.current.date(byAdding: .minute, value: -59, to: Date())!)
        let date3 = format.string(from: Calendar.current.date(byAdding: .minute, value: -60, to: Date())!)
        let date4 = format.string(from: Calendar.current.date(byAdding: .hour, value: 0, to: Date())!)
        let date5 = format.string(from: Calendar.current.date(byAdding: .hour, value: 1, to: Date())!)
        XCTAssertEqual(LiHelperFunctions.timeSince(post: date1), "1h", "time ago failed")
        XCTAssertEqual(LiHelperFunctions.timeSince(post: date2), "59m", "time ago failed")
        XCTAssertEqual(LiHelperFunctions.timeSince(post: date3), "1h", "time ago failed")
        XCTAssertEqual(LiHelperFunctions.timeSince(post: date4), "Just now", "time ago failed")
        XCTAssertEqual(LiHelperFunctions.timeSince(post: date5, default: "future"), "future", "time ago failed")
    }
    
    func testTimeSinceMinute() {
        let date1 = format.string(from: Calendar.current.date(byAdding: .minute, value: -1, to: Date())!)
        let date2 = format.string(from: Calendar.current.date(byAdding: .second, value: -59, to: Date())!)
        let date3 = format.string(from: Calendar.current.date(byAdding: .second, value: -60, to: Date())!)
        let date4 = format.string(from: Calendar.current.date(byAdding: .minute, value: 0, to: Date())!)
        let date5 = format.string(from: Calendar.current.date(byAdding: .second, value: 61, to: Date())!)
        XCTAssertEqual(LiHelperFunctions.timeSince(post: date1), "1m", "time ago failed")
        XCTAssertEqual(LiHelperFunctions.timeSince(post: date2), "59s", "time ago failed")
        XCTAssertEqual(LiHelperFunctions.timeSince(post: date3), "1m", "time ago failed")
        XCTAssertEqual(LiHelperFunctions.timeSince(post: date4), "Just now", "time ago failed")
        XCTAssertEqual(LiHelperFunctions.timeSince(post: date5, default: "future"), "future", "time ago failed")
    }
    
    func testTimeSinceSecond() {
        let date1 = format.string(from: Calendar.current.date(byAdding: .second, value: -1, to: Date())!)
        let date2 = format.string(from: Calendar.current.date(byAdding: .second, value: -3, to: Date())!)
        let date3 = format.string(from: Calendar.current.date(byAdding: .second, value: -4, to: Date())!)
        let date4 = format.string(from: Calendar.current.date(byAdding: .second, value: -1, to: Date())!)
        let date5 = format.string(from: Calendar.current.date(byAdding: .second, value: 2, to: Date())!)
        XCTAssertEqual(LiHelperFunctions.timeSince(post: date1), "Just now", "time ago failed")
        XCTAssertEqual(LiHelperFunctions.timeSince(post: date2), "3s", "time ago failed")
        XCTAssertEqual(LiHelperFunctions.timeSince(post: date3), "4s", "time ago failed")
        XCTAssertEqual(LiHelperFunctions.timeSince(post: date4), "Just now", "time ago failed")
        XCTAssertEqual(LiHelperFunctions.timeSince(post: date5, default: "future"), "future", "time ago failed")
    }
    
    func testTimeSince() {
        XCTAssertEqual(LiHelperFunctions.timeSince(post: nil), "", "time ago failed")
        XCTAssertEqual(LiHelperFunctions.timeSince(post: ""), "", "time ago failed")
        XCTAssertEqual(LiHelperFunctions.timeSince(post: "Hello there", default: "General Kanobi!"), "General Kanobi!", "time ago failed")
    }
}
