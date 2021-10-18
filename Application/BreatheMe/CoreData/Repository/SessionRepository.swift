//
//  SessionRepository.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 16.10.2021.
//

import Foundation

class SessionRepository {

    let database: Database
    private let sessionDao: SessionDao

    init(database: Database, sessionDao: SessionDao) {
        self.database = database
        self.sessionDao = sessionDao
    }

    func getSessions(limit: Int = 0, offset: Int = 0, completion: (Result<[Session], Error>) -> Void) {
        do {
            let sessions = try sessionDao.getSessions(limit: limit, offset: offset, context: database.context)
            completion(.success(sessions))
        } catch {
            completion(.failure(error))
        }
    }
    
    func createSessionWith(startDate: Date, endDate: Date?, completion: (Result<Session, Error>) -> Void ) {

        guard let session = sessionDao.insert(startDate: startDate, endDate: endDate, context: database.context) else {
            completion(.failure(CoreDataError.createNewObject("Couldn't create new session")))
            return
        }

        completion(.success(session))
    }
}
