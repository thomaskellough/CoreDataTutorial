//
//  CoreDataStack.swift
//  ShoutOut
//
//  Created by Thomas Kellough on 7/2/20.
//  Copyright © 2020 pluralsight. All rights reserved.
//

import CoreData
import Foundation


func createMainContext() -> NSManagedObjectContext {
    // Initialize NSManagedObjectModel
    let modelURL = Bundle.main.url(forResource: "\(Entity.shoutOut.name)", withExtension: "momd")
    assert(modelURL != nil, "Model URl was found nil. Ensure everything is correct.")
    guard let model = NSManagedObjectModel(contentsOf: modelURL!) else { fatalError("Model could not be created.") }
    
    // Configure NSPersistentStoreCoordinator with an NSPersistentStore
    let psc = NSPersistentStoreCoordinator(managedObjectModel: model)
    let storeURL = URL.documentsURL.appendingPathComponent("\(Entity.shoutOut.name).sqlite")
    try! psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
    
    // Create and return NSManagedObjectContext
    let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    context.persistentStoreCoordinator = psc
    
    return context
    
}
