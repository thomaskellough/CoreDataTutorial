//
//  ShoutOutTests.swift
//  ShoutOutTests

import CoreData
import XCTest
import UIKit

@testable import ShoutOut

class ShoutOutTests: XCTestCase {
	
	var systemUnderTest: ShoutOutDraftsViewController!
	
	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
		
		let storyboard = UIStoryboard(name: "Main",
		                              bundle: Bundle.main)
		let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
		systemUnderTest = (navigationController.viewControllers[0] as! ShoutOutDraftsViewController)
		
		UIApplication.shared.keyWindow!.rootViewController = systemUnderTest
		
		// Using the preloadView() extension method
		navigationController.preloadView()
		systemUnderTest.preloadView()
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	func testExample() {
		// This is an example of a functional test case.
		// Use XCTAssert and related functions to verify your tests produce the correct results.
	}
	
	func testPerformanceExample() {
		// This is an example of a performance test case.
		self.measure {
			// Put the code you want to measure the time of here.
		}
	}
    
    func testManagedObjectContext() {
        let managedObjectContext = createMainContextInMemory()
        self.systemUnderTest.managedObjectContext = managedObjectContext
        
        XCTAssertNotNil(self.systemUnderTest.managedObjectContext)
    }
}

func createMainContextInMemory() -> NSManagedObjectContext {
    // Initialize NSManagedObjectModel
    let modelURL = Bundle.main.url(forResource: "ShoutOut", withExtension: "momd")
    assert(modelURL != nil, "Model URl was found nil. Ensure everything is correct.")
    guard let model = NSManagedObjectModel(contentsOf: modelURL!) else { fatalError("Model could not be created.") }
    
    // Configure NSPersistentStoreCoordinator with an NSPersistentStore
    let psc = NSPersistentStoreCoordinator(managedObjectModel: model)
    try! psc.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
    
    // Create and return NSManagedObjectContext
    let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    context.persistentStoreCoordinator = psc
    
    return context
    
}

extension UIViewController {
	func preloadView() {
		_ = view
	}
}
