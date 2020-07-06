//
//  CoreDataStack.swift
//  ShoutOut
//
//  Created by Thomas Kellough on 7/2/20.
//  Copyright © 2020 pluralsight. All rights reserved.
//

import CoreData
import Foundation


// Note: removed NSManagedObjectContext as return
func createMainContext(completion: @escaping (NSPersistentContainer) -> Void) {
//    // Initialize NSManagedObjectModel
//    let modelURL = Bundle.main.url(forResource: "\(Entity.shoutOut.name)", withExtension: "momd")
//    assert(modelURL != nil, "Model URl was found nil. Ensure everything is correct.")
//    guard let model = NSManagedObjectModel(contentsOf: modelURL!) else { fatalError("Model could not be created.") }
//
//    // Configure NSPersistentStoreCoordinator with an NSPersistentStore
//    let psc = NSPersistentStoreCoordinator(managedObjectModel: model)
//    let storeURL = URL.documentsURL.appendingPathComponent("\(Entity.shoutOut.name).sqlite")
//
//    let pscOptions = [
//        NSMigratePersistentStoresAutomaticallyOption: true,
//        NSInferMappingModelAutomaticallyOption: true
//    ]
//
//    try! psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: pscOptions)
//
//    // Create and return NSManagedObjectContext
//    let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
//    context.persistentStoreCoordinator = psc
//
//    return context
    
    // Refractoring to use NSPersistentContainer
    let container = NSPersistentContainer(name: Entity.shoutOut.name)
    let storeURL = URL.documentsURL.appendingPathComponent("\(Entity.shoutOut.name).sqlite")
    let storeDescription = NSPersistentStoreDescription(url: storeURL)
    container.persistentStoreDescriptions = [storeDescription]
    
    container.loadPersistentStores() {
        NSPersistentStoreDescription, error in
        guard error == nil else { fatalError("Failed to load store: \(error!)") }
        
        DispatchQueue.main.async {
            completion(container)
        }
    }
    
}
