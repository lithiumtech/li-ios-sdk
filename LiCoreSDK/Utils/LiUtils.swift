//
//  LiUtils.swift
//  LiCoreSDK
//
//  Created by Shekhar Dahore on 3/1/18.
//  Copyright © 2018 Shekhar Dahore. All rights reserved.
//

import Foundation
extension String {
    func hasImageExtension() -> Bool {
        let imageExtRegEx = "([^\\s]+(\\.(?i)(jpg|jpeg|png))$)"
        let extTest =  NSPredicate(format:"SELF MATCHES[c] %@", imageExtRegEx)
        return extTest.evaluate(with: self)
    }
}
//Utils methods
enum LiError: Error {
    case invalidArrgument(String)
}
struct LiUtils {
    static func nonEmptyStringCheck(value: String, errorMessage: String) throws -> String {
        if value == "" {
            throw LiError.invalidArrgument(errorMessage)
        }
        return value
    }
    static func nonEmptyStringCheck(value: String?, errorMessage: String) throws -> String? {
        if value != nil && value == "" {
            throw LiError.invalidArrgument(errorMessage)
        }
        return value
    }
    static func positiveIntegerCheck(value: Int, errorMessage: String) throws -> Int {
        if value < 0 {
            throw LiError.invalidArrgument(errorMessage)
        }
        return value
    }
    static func nonEmptyArrayCheck<T>(value:[T], errorMessage: String) throws -> [T] {
        if value.isEmpty {
            throw LiError.invalidArrgument(errorMessage)
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
            throw LiError.invalidArrgument("Invalid email format.")
        }
    }
}
