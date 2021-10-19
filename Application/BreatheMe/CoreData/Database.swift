//
//  Database.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 14.10.2021.
//

import CoreData

/// A database class, which contains members related to database
class Database {

    // MARK: - Properties

    /// Current context object
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    /// Persistent container object
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "BreatheMe")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Data Methods

    /// Saves changes in database if needed
    func saveContext() {
        if context.hasChanges {
            try? context.save()
        }
    }

}
