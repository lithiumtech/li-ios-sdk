//
//  File.swift
//  LiCoreSDK
//
//  Created by Shekhar Dahore on 3/16/18.
//  Copyright © 2018 Shekhar Dahore. All rights reserved.
//

import Foundation
/// Enum represnenting errors
public enum LiError: Error {
    /// Error thrown when invalid arguments are passed on to LiClientRequestParams.
    case invalidArgument(errorMessage: String)
}
