//
//  EntityEnums.swift
//  ShoutOut
//
//  Created by Thomas Kellough on 7/4/20.
//  Copyright © 2020 pluralsight. All rights reserved.
//

import Foundation

enum Entity {
    case shoutOut
    case employee
    
    var name: String {
        switch self {
        case .shoutOut:
            return "ShoutOut"
        case .employee:
            return "Employee"
        }
    }
}
