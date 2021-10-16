//
//  AppSession.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 06.10.2021.
//

import Foundation

class AppSession {

    let dataManager: DataManager
    let sessionRepository: SessionRepository
    let recordRepository: RecordRepository

    init(dataManager: DataManager, sessionRepository: SessionRepository, recordRepository: RecordRepository) {
        self.dataManager = dataManager
        self.sessionRepository = sessionRepository
        self.recordRepository = recordRepository
    }
}
