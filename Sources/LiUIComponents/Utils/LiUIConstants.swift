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

import UIKit
struct LiUIConstants {
    static let dateTimeUTCFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    static let defaultProfileImage = UIImage(named: "li-profileImage", in: Bundle(for: LiHomeViewController.self), compatibleWith: nil)!
    struct Colors {
        static let appleBlue = UIColor(red:0.00, green:0.52, blue:1.00, alpha:1.0)
        static let fadedGray = UIColor(red:0.78, green:0.78, blue:0.8, alpha:1.0)
    }
    static let defaultImageName = "image.JPG"
}
