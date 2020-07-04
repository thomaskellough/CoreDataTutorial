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
        
        let employeeFetchRequest = NSFetchRequest<Employee>(entityName: "\(Entity.employee.rawValue)")
        
        do {
            let employees = try managedObjectContext.fetch(employeeFetchRequest)
            print(employees)
        } catch {
            print("Something with wrong with fetching employees: \(error)")
        }
    }

}
