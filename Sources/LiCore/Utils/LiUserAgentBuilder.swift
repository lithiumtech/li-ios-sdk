//
//  LiUserAgent.swift
//  LiCore
//
//  Created by Shekhar Dahore on 10/06/20.
//  Copyright © 2020 Lithium Technologies Inc. All rights reserved.
//

import Foundation
import UIKit

func DarwinVersion() -> String {
    var sysinfo = utsname()
    uname(&sysinfo)
    let dv = String(bytes: Data(bytes: &sysinfo.release, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
    return "Darwin/\(dv)"
}

func CFNetworkVersion() -> String {
    guard let dictionary = Bundle(identifier: "com.apple.CFNetwork")?.infoDictionary,     let version = dictionary["CFBundleShortVersionString"] as? String else {
        return ""
    }
    return "CFNetwork/\(version)"
}

func deviceVersion() -> String {
    let currentDevice = UIDevice.current
    return "\(currentDevice.systemName)/\(currentDevice.systemVersion)"
}

func deviceName() -> String {
    var sysinfo = utsname()
    uname(&sysinfo)
    return String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
}

func appNameAndVersion() -> String {
    guard let dictionary = Bundle.main.infoDictionary, let version = dictionary["CFBundleShortVersionString"] as? String, let name = dictionary["CFBundleName"] as? String else {
        return ""
    }
    return "\(name)/\(version)"
}

func userAgent() -> String {
    return "\(appNameAndVersion()) \(deviceName()) \(deviceVersion()) \(CFNetworkVersion()) \(DarwinVersion())"
}
