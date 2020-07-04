//
//  SaveAccessDelete.swift
//  ShoutOutTests
//
//  Created by Thomas Kellough on 7/4/20.
//  Copyright © 2020 pluralsight. All rights reserved.
//

import CoreData
import XCTest

@testable import ShoutOut
class SaveAccessDelete: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFetchAllEmployes() {
        let managedObjectContext = createMainContextInMemory()
        let dataService = DataService(managedObjectContext: managedObjectContext)
        dataService.seedEmployees()
        
        let employeeFetchRequest = NSFetchRequest<Employee>(entityName: "\(Entity.employee.name)")
        
        do {
            let employees = try managedObjectContext.fetch(employeeFetchRequest)
            print(employees)
        } catch {
            print("Something with wrong with fetching employees: \(error)")
        }
    }
    
    func testFilterShoutouts() {
        let managedObjectContext = createMainContextInMemory()
        let dataService = DataService(managedObjectContext: managedObjectContext)
        dataService.seedEmployees()
        
        seedShoutOutForTesting(managedObjectContext: managedObjectContext)
        let shoutOutsFetchRequest = NSFetchRequest<ShoutOut>(entityName: Entity.shoutOut.name)
        
        let shoutCategoryEqualityPredicate = NSPredicate(format: "%K == %@", #keyPath(ShoutOut.shoutCategory), "Awesome work!")
        shoutOutsFetchRequest.predicate = shoutCategoryEqualityPredicate
        
        do {
            let filterdShoutOuts = try managedObjectContext.fetch(shoutOutsFetchRequest)
            printShoutOuts(shoutOuts: filterdShoutOuts)
        } catch {
            print("Something went wrong fetching ShoutOuts: \(error)")
        }
    }
    
    func seedShoutOutForTesting(managedObjectContext: NSManagedObjectContext) {
        let employeeFetchRequest = NSFetchRequest<Employee>(entityName: Entity.employee.name)
        
        do {
            let employees = try managedObjectContext.fetch(employeeFetchRequest)
            
            let shoutOut1 = NSEntityDescription.insertNewObject(forEntityName: Entity.shoutOut.name, into: managedObjectContext) as! ShoutOut
            shoutOut1.shoutCategory = "Great Job!"
            shoutOut1.message = "Hey, great job on that patronus!"
            shoutOut1.toEmployee = employees[0]
            
            let shoutOut2 = NSEntityDescription.insertNewObject(forEntityName: Entity.shoutOut.name, into: managedObjectContext) as! ShoutOut
            shoutOut2.shoutCategory = "Great Job!"
            shoutOut2.message = "Couldn't have mastered that potion without you!"
            shoutOut2.toEmployee = employees[1]
            
            let shoutOut3 = NSEntityDescription.insertNewObject(forEntityName: Entity.shoutOut.name, into: managedObjectContext) as! ShoutOut
            shoutOut3.shoutCategory = "Awesome work!"
            shoutOut3.message = "Dumbledore would be so impressed!"
            shoutOut3.toEmployee = employees[2]
            
            let shoutOut4 = NSEntityDescription.insertNewObject(forEntityName: Entity.shoutOut.name, into: managedObjectContext) as! ShoutOut
            shoutOut4.shoutCategory = "Awesome work!"
            shoutOut4.message = "I'm proud to know you!"
            shoutOut4.toEmployee = employees[3]
            
            let shoutOut5 = NSEntityDescription.insertNewObject(forEntityName: Entity.shoutOut.name, into: managedObjectContext) as! ShoutOut
            shoutOut5.shoutCategory = "Excellent!"
            shoutOut5.message = "That was some wicked spellcasting!"
            shoutOut5.toEmployee = employees[4]
            
            let shoutOut6 = NSEntityDescription.insertNewObject(forEntityName: Entity.shoutOut.name, into: managedObjectContext) as! ShoutOut
            shoutOut6.shoutCategory = "Very cool!"
            shoutOut6.message = "You're a bloody genius!"
            shoutOut6.toEmployee = employees[5]
            
            do {
                try managedObjectContext.save()
            } catch {
                print("Something went wrong with savign ShoutOuts: \(error)")
                managedObjectContext.rollback()
            }
        } catch {
            print("Something went wrong with fetching employees: \(error)")
        }
    }
    
    func printShoutOuts(shoutOuts: [ShoutOut]) {
        for shoutOut in shoutOuts {
            print("\n---------------ShoutOut---------------------")
            print("Shout Category: \(shoutOut.shoutCategory)")
            print("Message: \(String(describing: shoutOut.message))")
            print("To: \(shoutOut.toEmployee.firstName) \(shoutOut.toEmployee.lastName)")
        }
    }

}
