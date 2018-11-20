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
import Alamofire
extension String {
    func hasImageExtension() -> Bool {
        let imageExtRegEx = "([^\\s]+(\\.(?i)(jpg|jpeg|png))$)"
        let extTest =  NSPredicate(format:"SELF MATCHES[c] %@", imageExtRegEx)
        return extTest.evaluate(with: self)
    }
}
//Utils methods
struct LiUtils {
    static func nonEmptyStringCheck(value: String, errorMessage: String) throws -> String {
        if value == "" {
            throw LiError.invalidArgument(errorMessage: errorMessage)
        }
        return value
    }
    static func nonEmptyStringCheck(value: String?, errorMessage: String) throws -> String? {
        if value != nil && value == "" {
            throw LiError.invalidArgument(errorMessage: errorMessage)
        }
        return value
    }
    static func positiveIntegerCheck(value: Int, errorMessage: String) throws -> Int {
        if value < 0 {
            throw LiError.invalidArgument(errorMessage: errorMessage)
        }
        return value
    }
    static func nonEmptyArrayCheck<T>(value:[T], errorMessage: String) throws -> [T] {
        if value.isEmpty {
            throw LiError.invalidArgument(errorMessage: errorMessage)
        }
        for v in value {
            if v is String {
                _ = try nonEmptyStringCheck(value: v as! String, errorMessage: errorMessage)
            }
        }
        return value
    }
    static func emailValidation(email: String) throws -> String {
        let emailRegEx = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        if emailTest.evaluate(with: email) {
            return email
        } else {
            throw LiError.invalidArgument(errorMessage: "Invalid email format.")
        }
    }
    static func urlValidation(url: String, message: String) throws -> String {
        let regEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[regEx])
        if predicate.evaluate(with: url) {
            return url
        } else {
            throw LiError.invalidArgument(errorMessage: message)
        }
    }
}
extension Dictionary {
    mutating func update(other: Dictionary) {
        for (key, value) in other {
            self.updateValue(value, forKey:key)
        }
    }
}

extension SessionManager {
    static func makeSessionManager() -> SessionManager {
        let configuration = URLSessionConfiguration.default
        var defaultHeaders = SessionManager.defaultHTTPHeaders
        defaultHeaders["User-Agent"] = LiCoreConstants.userAgent
        configuration.httpAdditionalHeaders = defaultHeaders
        return SessionManager(configuration: configuration)
    }
}
