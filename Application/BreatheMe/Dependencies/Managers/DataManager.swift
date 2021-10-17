//
//  DataManager.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 06.10.2021.
//

import Foundation

class DataManager {

    let database: Database

    init(database: Database) {
        self.database = database
    }

    func commitStorageChanges() {
        database.saveContext()
    }
}
