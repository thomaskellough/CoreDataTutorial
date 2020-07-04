//
//  DataService.swift
//  ShoutOut
//
//  Created by Thomas Kellough on 7/4/20.
//  Copyright © 2020 pluralsight. All rights reserved.
//

import CoreData
import Foundation

struct DataService: ManagedObjectContextDependentType {
    
    var managedObjectContext: NSManagedObjectContext!
    
    func seedEmployees() {
        let employeeFetchRequest = NSFetchRequest<Employee>(entityName: Entity.employee.name)
        do {
            let employeesAlreadySeeded = try self.managedObjectContext.fetch(employeeFetchRequest).count > 0
            if employeesAlreadySeeded == false {
                let employee1 = NSEntityDescription.insertNewObject(forEntityName: Entity.employee.name, into: self.managedObjectContext) as! Employee
                employee1.firstName = "Harry"
                employee1.lastName = "Potter"
                
                let employee2 = NSEntityDescription.insertNewObject(forEntityName: Entity.employee.name, into: self.managedObjectContext) as! Employee
                employee2.firstName = "Hermione"
                employee2.lastName = "Granger"
                
                let employee3 = NSEntityDescription.insertNewObject(forEntityName: Entity.employee.name, into: self.managedObjectContext) as! Employee
                employee3.firstName = "Ronald"
                employee3.lastName = "Weasley"
                
                let employee4 = NSEntityDescription.insertNewObject(forEntityName: Entity.employee.name, into: self.managedObjectContext) as! Employee
                employee4.firstName = "Luna"
                employee4.lastName = "Lovegood"
                
                let employee5 = NSEntityDescription.insertNewObject(forEntityName: Entity.employee.name, into: self.managedObjectContext) as! Employee
                employee5.firstName = "Severus"
                employee5.lastName = "Snape"
                
                let employee6 = NSEntityDescription.insertNewObject(forEntityName: Entity.employee.name, into: self.managedObjectContext) as! Employee
                employee6.firstName = "Sirius"
                employee6.lastName = "Black"
                
                do {
                    try self.managedObjectContext.save()
                } catch {
                    print("Error with saving employee: \(error)")
                    self.managedObjectContext.rollback()
                }
            }
        } catch { }
    }
}
