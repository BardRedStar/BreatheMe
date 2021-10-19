//
//  AppSession.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 06.10.2021.
//

import Foundation

/// A session class - main DI container of the app. Holds almost all dependencies and should be passed everywhere
class AppSession {
    // MARK: - Properties

    let dataManager: DataManager
    let sessionRepository: SessionRepository
    let recordRepository: RecordRepository

    // MARK: - Initialization

    init(dataManager: DataManager, sessionRepository: SessionRepository, recordRepository: RecordRepository) {
        self.dataManager = dataManager
        self.sessionRepository = sessionRepository
        self.recordRepository = recordRepository
    }
}
