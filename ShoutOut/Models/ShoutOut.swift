//
//  ShoutOut.swift
//  ShoutOut
//
//  Created by Thomas Kellough on 7/2/20.
//  Copyright © 2020 pluralsight. All rights reserved.
//

import CoreData
import Foundation

class ShoutOut: NSManagedObject {
    @NSManaged var from: String?
    @NSManaged var message: String?
    @NSManaged var sentOn: Date?
    @NSManaged var shoutCategory: String
    
    @NSManaged var toEmployee: Employee
}
