//
//  SessionRepository.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 16.10.2021.
//

import Foundation

class SessionRepository {

    let database: Database
    let sessionDao: SessionDao

    init(database: Database, sessionDao: SessionDao) {
        self.database = database
        self.sessionDao = sessionDao
    }

    func getSessions(completion: (Result<[Session], Error>) -> Void) {
        do {
            let sessions = try sessionDao.getSessions(context: database.context)
            completion(.success(sessions))
        } catch {
            completion(.failure(error))
        }
    }
    
    func saveSessionWith(startDate: Date, endDate: Date, completion: (Result<Void, Error>) -> Void ) {
        do {
            sessionDao.insert(startDate: startDate, endDate: endDate)
            try database.saveContext()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
}
