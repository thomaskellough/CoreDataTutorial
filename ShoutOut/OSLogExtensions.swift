//
//  OSLogExtensions.swift
//  ShoutOut
//
//  Created by Thomas Kellough on 7/5/20.
//  Copyright © 2020 pluralsight. All rights reserved.
//

import Foundation
import os.log

extension OSLog {
    private static var subsystem = Bundle.main.bundleIdentifier!

    /// Logs the view cycles like viewDidLoad.
    static let viewCycle = OSLog(subsystem: subsystem, category: "viewcycle")
}
