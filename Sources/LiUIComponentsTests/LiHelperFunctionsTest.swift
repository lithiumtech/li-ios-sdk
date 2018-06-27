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
    func testTimeSince() {
        let date1 = format.string(from: Calendar.current.date(byAdding: .day, value: -69, to: Date())!)
        let date2 = format.string(from: Calendar.current.date(byAdding: .second, value: -7, to: Date())!)
        let date3 = format.string(from: Calendar.current.date(byAdding: .year, value: -1, to: Date())!)
        let date4 = format.string(from: Calendar.current.date(byAdding: .minute, value: -10, to: Date())!)
        let date5 = format.string(from: Calendar.current.date(byAdding: .hour, value: -23, to: Date())!)
        XCTAssertEqual(LiHelperFunctions.timeSince(post: date1), "69d", "time ago failed" )
        XCTAssertEqual(LiHelperFunctions.timeSince(post: date2), "7s", "time ago failed" )
        XCTAssertEqual(LiHelperFunctions.timeSince(post: date3), "365d", "time ago failed" )
        XCTAssertEqual(LiHelperFunctions.timeSince(post: date4), "10m", "time ago failed" )
        XCTAssertEqual(LiHelperFunctions.timeSince(post: date5), "23h", "time ago failed" )
    }
}
