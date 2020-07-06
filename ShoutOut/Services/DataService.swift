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
            let employees = try self.managedObjectContext.fetch(employeeFetchRequest)
            let employeesAlreadySeeded = employees.count > 0
            if employeesAlreadySeeded == false {
                let employee1 = NSEntityDescription.insertNewObject(forEntityName: Entity.employee.name, into: self.managedObjectContext) as! Employee
                employee1.firstName = "Harry"
                employee1.lastName = "Potter"
                employee1.department = "Magical Law Enforcement"
                
                let employee2 = NSEntityDescription.insertNewObject(forEntityName: Entity.employee.name, into: self.managedObjectContext) as! Employee
                employee2.firstName = "Hermione"
                employee2.lastName = "Granger"
                employee2.department = "International Magical Cooperation"
                
                let employee3 = NSEntityDescription.insertNewObject(forEntityName: Entity.employee.name, into: self.managedObjectContext) as! Employee
                employee3.firstName = "Ronald"
                employee3.lastName = "Weasley"
                employee3.department = "Magical Games and Sports"
                
                let employee4 = NSEntityDescription.insertNewObject(forEntityName: Entity.employee.name, into: self.managedObjectContext) as! Employee
                employee4.firstName = "Luna"
                employee4.lastName = "Lovegood"
                employee4.department = "Magical Creatures"
                
                let employee5 = NSEntityDescription.insertNewObject(forEntityName: Entity.employee.name, into: self.managedObjectContext) as! Employee
                employee5.firstName = "Severus"
                employee5.lastName = "Snape"
                employee5.department = "Mysteries"
                
                let employee6 = NSEntityDescription.insertNewObject(forEntityName: Entity.employee.name, into: self.managedObjectContext) as! Employee
                employee6.firstName = "Sirius"
                employee6.lastName = "Black"
                employee6.department = "Magical Cooperation"
                
                do {
                    try self.managedObjectContext.save()
                } catch {
                    print("Error with saving employee: \(error)")
                    self.managedObjectContext.rollback()
                }
            } else {
                for employee in employees {
                    switch employee.lastName {
                    case "Black":
                        employee.department = "Magical Cooperation"
                    case "Granger":
                        employee.department = "International Magical Cooperation"
                    case "Lovegood":
                        employee.department = "Magical Creatures"
                    case "Potter":
                        employee.department = "Magical Law Enforcement"
                    case "Snape":
                        employee.department = "Mysteries"
                    case "Weasley":
                        employee.department = "Magical Games and Sports"
                    default:
                        break
                    }
                }
            }
        } catch { }
    }
}
