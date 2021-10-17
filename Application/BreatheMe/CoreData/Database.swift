//
//  Database.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 14.10.2021.
//

import CoreData


class Database {

    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "BreatheMe")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
                print("context saved")
            } catch {
                print("error while saving context \(error.localizedDescription)")
            }
        }
    }

}
