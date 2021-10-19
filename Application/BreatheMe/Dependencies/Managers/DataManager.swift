//
//  DataManager.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 06.10.2021.
//

import Foundation

/// A data manager class for common operations with storage data
class DataManager {
    // MARK: - Properties

    let database: Database

    // MARK: - Initialization

    init(database: Database) {
        self.database = database
    }

    // MARK: - Data methods
    
    func commitStorageChanges() {
        database.saveContext()
    }
}
