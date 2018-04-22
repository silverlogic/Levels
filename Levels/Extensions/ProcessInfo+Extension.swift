//
//  ProcessInfo+Extension.swift
//  Levels
//
//  Created by Shaun Bevan on 4/22/18.
//  Copyright © 2018 The SilverLogic. All rights reserved.
//

import Foundation

extension ProcessInfo {

    static var isRunningLevels: Bool {
        let environmentDictionary = processInfo.environment
        return environmentDictionary["LEVELS"] == "TRUE"
    }
}
