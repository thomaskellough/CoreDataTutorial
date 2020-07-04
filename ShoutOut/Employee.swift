//
//  Employee.swift
//  ShoutOut
//
//  Created by Thomas Kellough on 7/3/20.
//  Copyright © 2020 pluralsight. All rights reserved.
//

import CoreData
import Foundation

class Employee: NSManagedObject {
    @NSManaged var firstName: String
    @NSManaged var lastName: String
    
    @NSManaged var shoutOuts: NSSet?
}
