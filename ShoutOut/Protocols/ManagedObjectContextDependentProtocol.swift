//
//  ManagedObjectContextDependentProtocol.swift
//  ShoutOut
//
//  Created by Thomas Kellough on 7/2/20.
//  Copyright © 2020 pluralsight. All rights reserved.
//

import CoreData
import Foundation

protocol ManagedObjectContextDependentType {
    var managedObjectContext: NSManagedObjectContext! { get set }
}
